(function() {
  'use strict';

  angular.module('gapFront')
    .factory('Geocode', GeocodeFactory);

  /** @ngInject */
  function GeocodeFactory($http, Map) {
    var Geocode = {} 
    Geocode.search = function(searchTerm, queryParams) {
      $http.get('https://maps.googleapis.com/maps/api/geocode/json?address=' + encodeURI(searchTerm)).then(handleResult);

      function handleResult(result){
        var loc = result.data.results[0].geometry.location;
        var lat = loc.lat, lng = loc.lng;

        Map.map.setView([lat,lng]);
        // Map.update(queryParams);
      }
    }
    return Geocode;
  }
})();
