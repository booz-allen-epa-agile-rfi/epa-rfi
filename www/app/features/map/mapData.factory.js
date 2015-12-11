(function() {
  'use strict';

  angular.module('gapFront')
    .factory('MapData', MapDataFactory);

  /** @ngInject */
  function MapDataFactory($resource) {
    var MapData = $resource('http://localhost:3000/api/v1/staff/:id', {id: '@id'}, {});

    return MapData;
  }
})();
