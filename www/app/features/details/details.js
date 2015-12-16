(function() {
  'use strict';

  angular.module('gapFront')
    .directive('mapDetails', MapDetailsDirective);

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
    function MapDetailsController($scope) {
      var vm = this;

      vm.activate = activate;

      function activate() {
      }
    }
  }
})();
