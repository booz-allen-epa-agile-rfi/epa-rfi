(function() {
  'use strict';

  angular.module('gapFront')
    .factory('MapData', MapDataFactory);

  /** @ngInject */
  function MapDataFactory($resource) {
    var MapData = {} 
    MapData.county = $resource('http://52.10.159.127/county_totals', {});

    return MapData;
  }
})();
