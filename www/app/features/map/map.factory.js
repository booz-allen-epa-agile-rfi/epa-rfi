(function() {
  angular.module('gapFront')
    .factory('Map', MapFactory)
    .constant('API_TOKEN', {
      MAPBOX: 'pk.eyJ1IjoiYmFodm9reiIsImEiOiJjaWkyNWllNnYwMGtpc3drcTFvdHV4NGs5In0.tXMxAmwb2f4JG12ELI6C3w'
    })

  /** @ngInject */
  function MapFactory(MapData, API_TOKEN) {
    var Map = {};

    Map.data = {};  // hash to properties
    Map.tileLayers = initMapTiles();
    Map.dataLayers = {};
    Map.update = update;
    Map.map = initMap();

    Map.loaded = true;

    return Map;

    // Private

    function update(queryParams) {
      Map.loaded = false;
      if(Map.dataLayers.geojson){
        Map.dataLayers.geojson.clearLayers();
      }

      MapData.search.save(queryParams).$promise.then(function(results) {
        var filteredResult = {
          type: "FeatureCollection",
          features: formatData(results.features)
        }
        delete results; // Clear out the results after being formatted
        Map.data = {};  // Clear out the data hash that links to each feature

        Map.dataLayers.geojson = L.geoJson(filteredResult, {
          onEachFeature: function(feature, layer) {
            var popUpHtml = '<b>Facility Name : ' + feature.properties['facility_name'] + "</b><br/>" +
                        'Air Emissions : ' + feature.properties['total_air_emissions'].toLocaleString() + ' lbs<br />' +
                        'On Site Land Releases : ' + feature.properties['total_on_site_land_releases'].toLocaleString() + ' lbs<br />' +
                        'Underground Injection : ' + feature.properties['total_underground_injection'].toLocaleString() + ' lbs<br />' +
                        'Surface Water Discharge : ' + feature.properties['total_surface_water_discharge'].toLocaleString() + ' lbs'

            layer.bindPopup(popUpHtml);

            // Add to data hash
            Map.data[layer.feature.properties.facility_name] = layer.feature.properties;
          }
        });
        Map.loaded = true;

        Map.dataLayers.geojson.addTo(Map.map);

        function formatData(results) {
          var health_effects = 'cercla_chemicals haps priority_chemicals osha_chemicals body_weight cardiovascular dermal developmental endocrine gastrointestinal hematological hepatic immunological metabolic musculoskeletal neurological ocular other_systemic renal reproductive'.split(' ');

          var storedFacilities = {};

          return results.reduce(function(total, feature){
            var name = feature.properties.facility_name;
            if(!_.has(storedFacilities, name)){
              storedFacilities[name] = feature;  // store it in hash

              feature.properties = _.omit(feature.properties, 'latitude', 'longitude')
              mapHealthEffectsToBoolean(feature.properties);
              feature.properties.chemicals = [feature.properties.chemical_name]; //  create the chemicals array
              total.push(feature);
            } else { // already stored then don't re-create a marker
              storedFacilities[name].properties.chemicals.push(feature.properties.chemical_name);
            }

            return total;
          }, []);

          function mapHealthEffectsToBoolean(properties){
            _.each(health_effects, function(effect){
              properties[effect] = properties[effect] === "YES" ? true : false;
            });
          }
        }
      });
    }

    function initMapTiles() {
      var mapTiles = {};

      var tileURL = 'https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token=' + API_TOKEN.MAPBOX
      var attribution = 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, ' +
          '<a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, ' +
          'Imagery © <a href="http://mapbox.com">Mapbox</a>'

      mapTiles.grayScale = L.tileLayer(tileURL, {
        maxZoom: 18,
        attribution: attribution,
        id: 'mapbox.light'
      });

      mapTiles.streets = L.tileLayer(tileURL, {
        maxZoom: 18,
        attribution: attribution,
        id: 'mapbox.streets'
      });

      return mapTiles;
    }

    function initMap(tileLayers) {
      return L.map('map' , {
        center: [38.9338676, -77.1772604],
        zoom: 5,
        minZoom: 8,
        layers: [Map.tileLayers.streets]
      });
    }
  }
})();
