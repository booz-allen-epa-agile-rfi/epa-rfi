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
        $scope.keys = function(obj){
          return !_.isUndefined(obj) ? Object.keys(obj) : [];
        }

        $scope.$watch(function(){ return Map.data.changed }, function(newValue){
          $scope.data = Map.data;
          Map.data.changed = false;
          
          console.log(Map.data);
        });
      }
    }
  }
})();
