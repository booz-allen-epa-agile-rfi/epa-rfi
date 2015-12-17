(function() {
  'use strict';

  angular.module('gapFront')
    .filter('startCase', function(){
      return function(str) {
        return _.startCase(str);
      }
    })
    .directive('mapDetails', MapDetailsDirective)

  /** @ngInject */
  function MapDetailsDirective() {
    var directive = {
      restrict: 'AE',
      scope: {},
      link: link,
      templateUrl: 'features/details/details.html',
      controller: MapDetailsController,
      controllerAs: 'vm',
      bindToController: true
    };

    return directive;

    function link(scope, element, attrs, vm, transclude) {
      vm.activate();
    }

    /** @ngInject */
    function MapDetailsController($scope, Map) {
      var vm = this;

      vm.activate = activate;

      function activate() {
        $scope.data = {};
        $scope.keys = getKeys;

        // Results toggling 
        $scope.selectedResult = 'Facilities';
        $scope.otherResults = ['Facilities', 'Chemicals'];
        $scope.toggleSelectedResult = toggleSelectedResult;

        // Emission Toggling
        $scope.hasAirEmissions = createEmissionCheck('total_air_emissions');
        $scope.hasGroundEmissions = createEmissionCheck('total_on_site_land_releases');
        $scope.hasUndergroundEmissions = createEmissionCheck('total_underground_injection');
        $scope.hasWaterEmissions = createEmissionCheck('total_surface_water_discharge');

        // Watch function to update Scope's data when Map factory has new data
        $scope.$watch(function(){ return Map.data.changed }, function(newValue){
          $scope.data = Map.data;
          Map.data.changed = false;

          console.log(Map.data);
        });

        // Private

        function getKeys(obj) {
          return !_.isUndefined(obj) ? Object.keys(obj) : [];
        }

        function toggleSelectedResult(newResult){
          var choices = ['Health Effects', 'Facilities', 'Chemicals'];
          $scope.selectedResult = newResult;
          $scope.otherResults = _.without(choices, newResult);
        }

        function createEmissionCheck(emissionType){
          return function(facilityName) {
            return Map.data.facilities.properties[facilityName][emissionType] > 0;
          }
        }
      }
    }
  }
})();
