(function() {
  angular.module('gapFront')
    .factory('Map', MapFactory)
    .constant('API_TOKEN', {
      MAPBOX: 'pk.eyJ1IjoiYmFodm9reiIsImEiOiJjaWkyNWllNnYwMGtpc3drcTFvdHV4NGs5In0.tXMxAmwb2f4JG12ELI6C3w'
    })

  /** @ngInject */
  function MapFactory(MapData, API_TOKEN) {
    var Map = {};
    var hiddenFacilities = {};
    Map.init = init;
    
    return Map;

    // Private

    function init() {
      Map.data = initStorage();  // hash to properties
      Map.tileLayers = initMapTiles();
      Map.dataLayers = {};
      Map.update = update;
      Map.map = initMap();

      hiddenFacilities = {};
      Map.showAll = showAll;
      Map.hideLayer = hideLayer;
      Map.showLayer = showLayer;
      Map.clearHiddenFacilities = clearHiddenFacilities;
      Map.loaded = true;
    }

    function initStorage(){
      var data = {};
      clear.call(data);
      data.clear = clear;
      data.changed = false;

      function clear() {
        this.chemicals = {};
        this.facilities = {
          names: [],
          properties: {}
        };
        this.healthEffects = {
          body_weight: initHealthEffectHash(),
          cardiovascular: initHealthEffectHash(),
          dermal: initHealthEffectHash(),
          developmental: initHealthEffectHash(),
          endocrine: initHealthEffectHash(),
          gastrointestinal: initHealthEffectHash(),
          hematological: initHealthEffectHash(),
          hepatic: initHealthEffectHash(),
          immunological: initHealthEffectHash(),
          metabolic: initHealthEffectHash(),
          musculoskeletal: initHealthEffectHash(),
          neurological: initHealthEffectHash(),
          ocular: initHealthEffectHash(),
          other_systemic: initHealthEffectHash(),
          renal: initHealthEffectHash(),
          reproductive: initHealthEffectHash()
        };

        function initHealthEffectHash() {
          return {
            chemicals: {},
            facilities: []
          }
        }
      }

      data.populateFacilities = function(properties) {
        this.facilities.names.push(properties.facility_name);
        this.facilities.properties[properties.facility_name] = properties;
        this.changed = true;
      }

      data.populateChemicals = function(properties) {
        _.each(properties.chemicals, addInformation.bind(this));

        function addInformation(chemical) {
          if(!_.has(this.chemicals, chemical)){
            this.chemicals[chemical] = {
              facilities: [],
              healthEffects: []
            };
          }
          this.chemicals[chemical]['facilities'].push(properties);
          this.chemicals[chemical]['healthEffects'] = _.union(this.chemicals[chemical]['healthEffects'], properties.healthEffects);
          this.changed = true;
        }
      }

      data.populateHealthEffects = function(properties){
        _.each(properties.healthEffects, recordData.bind(this));

        function recordData(effect){
          _.each(properties.chemicals, updateChemicalCount.bind(this)); // Make call to update all chemicals associated
          this.healthEffects[effect]['facilities'].push(properties);  // record the facilities
          this.changed = true;

          function updateChemicalCount(chemical) {
            if(_.has(this.healthEffects[effect]['chemicals'], chemical)) {
              this.healthEffects[effect]['chemicals'][chemical]++;
            } else {
              this.healthEffects[effect]['chemicals'][chemical] = 1;
            }
          }
        }
      }

      return data;
    }

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
        delete results;       // Clear out the results after being formatted
        Map.data.clear();     // Clear out the data hash that links to each feature

        Map.dataLayers.geojson = L.geoJson(filteredResult, {
          onEachFeature: function(feature, layer) {
            layer.bindPopup(popUpGenerator(feature.properties));

            // Add to data hash
            var props = layer.feature.properties;
            Map.data.populateFacilities(props);
            Map.data.populateChemicals(props);
            Map.data.populateHealthEffects(props);
          }
        });

        Map.loaded = true;
        Map.dataLayers.geojson.addTo(Map.map);

        // Private

        function formatData(results) {
          var HEALTH_EFFECTS = 'body_weight cardiovascular dermal developmental endocrine gastrointestinal hematological hepatic immunological metabolic musculoskeletal neurological ocular other_systemic renal reproductive'.split(' ');

          var storedFacilities = {};

          return results.reduce(function(total, feature){
            var name = feature.properties.facility_name;
            if(!_.has(storedFacilities, name)){
              storedFacilities[name] = feature;  // store it in hash

              feature.properties.latitude = Number(feature.properties.latitude);
              feature.properties.longitude = Number(feature.properties.longitude);
              feature.properties.healthEffects = mapHealthEffectsToBoolean(feature.properties);
              feature.properties.chemicals = [feature.properties.chemical_name]; //  create the chemicals array

              total.push(feature);
            } else { // already stored then don't re-create a marker
              storedFacilities[name].properties.chemicals.push(feature.properties.chemical_name);
            }

            return total;
          }, []);

          function mapHealthEffectsToBoolean(properties){
            var healthEffects = [];

            // Loop through each health effect and only keep relevant effects
            // Store in health effects hash and delete other information
            for(var i = 0; i < HEALTH_EFFECTS.length; i++){
              var effect = HEALTH_EFFECTS[i];
              if(properties[effect] === "YES"){
                healthEffects.push(effect);
              }
              delete properties[effect]
            }

            return healthEffects;
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
        minZoom: 9,
        layers: [Map.tileLayers.streets]
      }).on('layeradd', function(layerEvent){
        // Only add ID if the layer is a marker (has a feature hash)
        // Skips tileLayers, controls, etc
        if(!_.isUndefined(layerEvent.layer.feature)){
          var id = layerEvent.layer._leaflet_id;
          layerEvent.layer.feature.properties.id = id;
        }
      });
    }

    function hideLayer(facilityProps) {
      var facilityId = facilityProps.id;
      var targetLayer = Map.dataLayers.geojson.getLayer(facilityId);

      targetLayer.setOpacity(0);
      targetLayer.unbindPopup();

      hiddenFacilities[facilityProps.facility_name] = facilityProps;
    }

    function showLayer(facilityProps) {
      var facilityId = facilityProps.id;
      var targetLayer = Map.dataLayers.geojson.getLayer(facilityId);

      targetLayer.setOpacity(100);
      targetLayer.bindPopup(popUpGenerator(facilityProps));

      delete hiddenFacilities[facilityProps.facility_name];
    }

    function showAll(){
      _.each(_.values(hiddenFacilities), showLayer);
    }

    function clearHiddenFacilities() {
      hiddenFacilities = {};
    }

    function popUpGenerator(properties) {
      return '<b>Facility Name : ' + properties['facility_name'] + "</b><br/>" +
                  'Air Emissions : ' + properties['total_air_emissions'].toLocaleString() + ' lbs<br />' +
                  'On Site Land Releases : ' + properties['total_on_site_land_releases'].toLocaleString() + ' lbs<br />' +
                  'Underground Injection : ' + properties['total_underground_injection'].toLocaleString() + ' lbs<br />' +
                  'Surface Water Discharge : ' + properties['total_surface_water_discharge'].toLocaleString() + ' lbs'
    }
  }
})();
