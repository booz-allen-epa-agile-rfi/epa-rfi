(function() {
  angular.module('gapFront')
    .factory('Map', MapFactory);

  /** @ngInject */
  function MapFactory($resource) {
    console.log('map factory ran');
    var Map = {};
    init(); 

    return Map;

    function init() {
      debugger;
      Map.tileLayers = initMapTiles() || {};
      Map.dataLayers = initData() || {};
      Map.map = initMap() || {};

      addToMap(Map.map);
    }

    // Private

    function addToMap(mapInstance) {
      var baseMaps = {
        'Grayscale': Map.tileLayers.grayScale,
        'Streets': Map.tileLayers.streets
      }

      var overlayMaps = {
        'Counties': Map.dataLayers.county,
        'Air Quality': Map.dataLayers.air
      }

      L.control.layers(baseMaps, overlayMaps).addTo(mapInstance);
      Map.tileLayers.grayScale.addTo(mapInstance);
      Map.dataLayers.county.addTo(mapInstance);
    }

    function initMapTiles() {
      var mapTiles = {};

      var tileURL = 'https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token=pk.eyJ1IjoibWFwYm94IiwiYSI6IjZjNmRjNzk3ZmE2MTcwOTEwMGY0MzU3YjUzOWFmNWZhIn0.Y8bhBaUMqFiPrDRW9hieoQ';
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
        center: [30.3669563, -97.7926704],
        zoom: 5,
        layers: [Map.tileLayers.grayScale, Map.dataLayers.county]      // Renders the stuff
      });
    }

    function initData() {
      var countyLayer = initCountyLayer();
      var airLayer = initAirLayer();

      return {
        county: countyLayer,
        air: airLayer
      }

      // Private

      function initAirLayer() {
        return omnivore.csv('features/map/mockData/data1r_randomized2.csv')           // Air Quality Data
          .on('ready', function(layer) {
            console.log('air quality data loaded');
            this.eachLayer(function(marker){
              marker.setIcon(new L.Icon({       // sets the marker icon
                iconUrl: './leaf-red.png',
                iconSize: [25, 25]
              }));

              marker.bindPopup("<b>"+ marker.feature.properties['FACILITY.NAME'] +"</b><br />" + marker.feature.properties['FACILITY.CITY']);

              marker.on('click', function(e){
                console.log('you clicked', marker)
                marker.openPopup();
              })
            });
          });
      }

      function initCountyLayer() {
        return L.geoJson(mockCountiesData, {
          style: style,
          onEachFeature: function(feature, layer){
            createPop();
            layer.on({
              // click: zoomToFeature,
              mouseover: highlightFeature,
              mouseout: resetHighlight
            });

            // Private

            function createPop() {
              var countyPopUp = '<b>County Name : ' + feature.properties['NAME'] + "</b><br/>" +
                          'State : ' + feature.properties['STATE'] + '<br />' +
                          'Census Area: ' + feature.properties['CENSUSAREA']

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
            return d > 10000 ? '#800026' :
                   d > 5000  ? '#BD0026' :
                   d > 2000 ? '#E31A1C' :
                   d > 1000  ? '#FC4E2A' :
                   d > 500   ? '#FD8D3C' :
                   d > 200   ? '#FEB24C' :
                   d > 10   ? '#FED976' :
                              '#FFEDA0';
        }

        function style(feature) {
            return {
                fillColor: getColor(feature.properties.CENSUSAREA),
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
