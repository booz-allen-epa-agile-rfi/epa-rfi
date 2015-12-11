(function() {
  'use strict';

  angular.module('gapFront')
    .factory('Map', MapFactory);

  /** @ngInject */
  function MapFactory($resource, MapData) {
    deugger;
    var Map = {};
    init();

    return Map;

    function init() {
      debugger;
      Map.tileLayers = initMapTiles() || {};
      Map.map = initMap(Map.tileLayers) || {};
      Map.dataLayers = initData() || {};
      Map.controls = initControls() || {};
    }

    // Private

    function initControls() {
      return {
        layers: initLayerControl()        // Create the layer control
      }

      function initLayerControl() {
        var baseMaps = {
          'Grayscale': Map.tileLayers.grayScale,
          'Streets': Map.tileLayers.streets
        }

        var overlayMaps = {
          'Counties': Map.dataLayers.county,
          'Air Quality': Map.datalayers.air
        }
      }
    }

    function initMapTiles(mapTiles) {
      var tileURL = 'https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token=pk.eyJ1IjoibWFwYm94IiwiYSI6IjZjNmRjNzk3ZmE2MTcwOTEwMGY0MzU3YjUzOWFmNWZhIn0.Y8bhBaUMqFiPrDRW9hieoQ';
      var attribution = 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, ' +
          '<a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, ' +
          'Imagery © <a href="http://mapbox.com">Mapbox</a>'

      return { 
        grayScale: L.tileLayer(tileUrl, {
          maxZoom: 18,
          attribution: attribution,
          id: 'mapbox.light'
        }),
        streets: L.tileLayer(tileUrl, {
          maxZoom: 18,
          attribution: attribution,
          id: 'mapbox.streets'
        })

      }
    }

    function initMap(tileLayers) {
      return L.map('map' , {
        center: [30.3669563, -97.7926704],
        zoom: 5,
        layers: [tileLayers.grayScale, tileLayers.streets]
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
        return omnivore.csv('./mockData/data1r_randomized2.csv')           // Air Quality Data
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
              info.update(layer.feature.properties);
            }

            function resetHighlight(e) {
              countyLayer.resetStyle(e.target);
              info.update();
            }
          }
        });
      }
    }
  }
})();
