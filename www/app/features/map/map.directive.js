(function() {
  'use strict';

  angular.module('gapFront')
    .directive('map', MapDirective);

  /** @ngInject */
  function MapDirective() {
    var directive = {
      restrict: 'AE',
      scope: {},
      link: link,
      template: '<div id="map" class="col-md-9"><span ng-hide="vm.mapLoaded" us-spinner="{radius:30, width:8, length: 16}"></span></div>',
      controller: MapController,
      controllerAs: 'vm',
      bindToController: true
    };

    return directive;

    function link(scope, element, attrs, vm, transclude) {
      vm.activate();
    }

    /** @ngInject */
    function MapController($scope, Map, MapData) {
      var vm = this;

      vm.activate = activate;

      function activate() {
        Map.init();
        vm.mapLoaded = false;
        $scope.$watch(function(){ return Map.loaded }, function(newValue) {
          vm.mapLoaded = Map.loaded;
        });
      }
    }
  }
})();
