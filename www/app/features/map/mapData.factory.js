(function() {
  'use strict';

  angular.module('gapFront')
    .factory('MapData', MapDataFactory);

  /** @ngInject */
  function MapDataFactory($resource) {
    var MapData = {} 
    MapData.search = $resource('http://dev.treeview.io:3000/search', {});

    return MapData;
  }
})();
