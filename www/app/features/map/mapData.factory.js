(function() {
  'use strict';

  angular.module('gapFront')
    .factory('MapData', MapDataFactory);

  /** @ngInject */
  function MapDataFactory($resource) {
    var MapData = $resource('', {}, {});

    return MapData;
  }
})();
