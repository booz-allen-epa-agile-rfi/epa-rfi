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
      template: '<div id="map" class="col-md-9"></div>',
      controller: MapController,
      controllerAs: 'vm',
      bindToController: true
    };

    return directive;

    function link(scope, element, attrs, vm, transclude) {
      vm.activate();
    }

    /** @ngInject */
    function MapController(Map) {
      var vm = this;

      vm.activate = activate;

      function activate() {
      }
    }
  }
})();
