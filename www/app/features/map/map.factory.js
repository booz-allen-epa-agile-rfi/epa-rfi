(function() {
  angular.module('gapFront')
    .factory('Map', MapFactory)
    .constant('API_TOKEN', {
      MAPBOX: 'pk.eyJ1IjoiYmFodm9reiIsImEiOiJjaWkyNWllNnYwMGtpc3drcTFvdHV4NGs5In0.tXMxAmwb2f4JG12ELI6C3w'
    })

  /** @ngInject */
  function MapFactory(MapData, API_TOKEN) {
    var Map = {};

    Map.tileLayers = initMapTiles();
    Map.dataLayers = initData() || {};

    Map.update = update;
    Map.map = initMap();
    addToMap(Map.map);

    Map.loaded = true;

    return Map;

    // Private

    function update(queryParams) {
      Map.loaded = false;
      if(Map.dataLayers.geojson) Map.dataLayers.geojson.clearLayers();

      MapData.search.save(queryParams).$promise.then(function(results) {
        var filteredResult = {
          type: "FeatureCollection",
          features: formatData(results.features)
        }
        delete results;

        Map.dataLayers.geojson = L.geoJson(filteredResult, {
          onEachFeature: function(feature, layer) {
            var popUpHtml = '<b>Facility Name : ' + feature.properties['facility_name'] + "</b><br/>" +
                        'Air Emissions : ' + feature.properties['total_air_emissions'].toLocaleString() + ' lbs<br />' +
                        'On Site Land Releases : ' + feature.properties['total_on_site_land_releases'].toLocaleString() + ' lbs<br />' +
                        'Underground Injection : ' + feature.properties['total_underground_injection'].toLocaleString() + ' lbs<br />' +
                        'Surface Water Discharge : ' + feature.properties['total_surface_water_discharge'].toLocaleString() + ' lbs'

            layer.bindPopup(popUpHtml);
          }
        });
        Map.loaded = true;

        Map.dataLayers.geojson.addTo(Map.map);

        // if(queryParams.bounds && queryParams.bounds.length === 4) {
        //   var sw = queryParams.bounds.slice(0,2);
        //   var ne = queryParams.bounds.slice(2,4);
        //   Map.map.fitBounds([sw,ne]);
        // }

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

    function addToMap(mapInstance) {
      var baseMaps = {
        // 'Grayscale': Map.tileLayers.grayScale,
        'Streets': Map.tileLayers.streets
      }

      // var overlayMaps = {
      //   'Counties': Map.dataLayers.county,
      //   'Air Quality': Map.dataLayers.air
      // }

      // L.control.layers(baseMaps, overlayMaps).addTo(mapInstance);
      // Map.dataLayers.county.addTo(mapInstance);
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
        layers: [Map.tileLayers.streets]      // Renders the stuff
      });
    }

    function initData() {
      // prepare the data
      // prepareData(mockCountiesData, );

      // var countyLayer = initCountyLayer();
      // var airLayer = initAirLayer();

      // return {
      //   county: countyLayer,
      //   air: airLayer
      // }

      // Private

      // function prepareData(mockCounty, ) {
      //   apiData.forEach(function(apiRow){
      //     mockCounty.features.forEach(function(county){
      //       if(county.properties.STATE === apiRow.state && county.properties.NAME.toUpperCase() === apiRow.county){
      //         county.properties.total_air_emissions = apiRow.total_air_emissions;
      //         county.properties.total_on_site_land_releases = apiRow.total_on_site_land_releases;
      //         county.properties.total_underground_injection = apiRow.total_underground_injection;
      //         county.properties.total_surface_water_discharge = apiRow.total_surface_water_discharge;
      //         county.properties.total = apiRow.total;
      //       }
      //     });
      //   });
      // }

      function initAirLayer() {
        return omnivore.csv('features/map/mockData/data1r_randomized2.csv')           // Air Quality Data
          .on('ready', function(layer) {
            this.eachLayer(function(marker){
              marker.setIcon(new L.Icon({       // sets the marker icon
                iconUrl: 'assets/Pin_1.png',
                iconSize: [20, 25]
              }));

              marker.bindPopup("<b>"+ marker.feature.properties['FACILITY.NAME'] +"</b><br />" + marker.feature.properties['FACILITY.CITY']);

              marker.on('click', function(e){
                console.log('you clicked', marker)
                marker.openPopup();
              })
            });
          });
      }

      function initCountyLayer(apiData) {
        return L.geoJson(mockCountiesData, {
          style: style,
          onEachFeature: function(feature, layer){
            createPop();
            layer.on({
              // click: zoomToFeature,
              mouseover: highlightFeature,
              mouseout: resetHighlight
            });

            // debuggging
            layer.on('click', function(e) {
              console.log(e.target.feature.properties);
            });

            // Private

            function createPop() {
              var countyPopUp = '<b>County Name : ' + feature.properties['NAME'] + "</b><br/>" +
                          'State : ' + feature.properties['STATE'] + '<br />' +
                          'Air Emissions : ' + feature.properties['total_air_emissions'] + '<br />' +
                          'On Site Land Releases : ' + feature.properties['total_on_site_land_releases'] + '<br />' +
                          'Underground Injection : ' + feature.properties['total_underground_injection'] + '<br />' +
                          'Surface Water Discharge : ' + feature.properties['total_surface_water_discharge']

              layer.bindPopup(countyPopUp);
            }

            function zoomToFeature(e){
              Map.map.fitBounds(e.target.getBounds());
            }

            function highlightFeature(e){
              var layer = e.target;

              layer.setStyle({
                  weight: 5,
                  color: '#000',
                  dashArray: '',
                  fillOpacity: 0.7
              });

              if (!L.Browser.ie && !L.Browser.opera) {
                  layer.bringToFront();
              }
            }

            function resetHighlight(e) {
              countyLayer.resetStyle(e.target);
            }
          }
        });

        function getColor(d) {
            return d > 10000000 ? '#800026' :
                   d > 490000  ? '#BD0026' :
                   d > 350000 ? '#E31A1C' :
                   d > 225000  ? '#FC4E2A' :
                   d > 55000  ? '#FD8D3C' :
                   d > 20000   ? '#FEB24C' :
                   // d > 100   ? '#FED976' :
                              '#FED976';
        }

        function style(feature) {
            return {
                fillColor: getColor(feature.properties.total),
                weight: 2,
                opacity: 1,
                color: 'white',
                dashArray: '3',
                fillOpacity: 0.7
            };
        }
      }
    }
  }
})();
