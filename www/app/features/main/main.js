'use strict';

/**
 * @ngdoc function
 * @name gapFront.controller:MainCtrl
 * @description
 * # MainCtrl
 * Controller of the gapFront
 */
angular.module('gapFront')
  .controller('MainCtrl', MainController);

function MainController($scope, $routeParams, Map) {
  if(!_.isEmpty($routeParams)) loadState();

  $scope.submitMapFilters = function(e) {
    var active_emissions = $('#emission').find('.active').map(function(){
      return this.textContent.trim();
    }).get();

    var startYear = $('#start-year').value();
    var endYear = $('#end-year').value();
    var reporting_year = _.range(startYear, endYear+1);

    if(active_emissions.indexOf('Total') >= 0 || ['Land', 'Water', 'Air'].every(allOptionsChosen)){
      active_emissions = ['Total'];
    }

    var bounds = formatBounds(Map.map.getBounds());

    Map.update({
      reporting_year: reporting_year,
      emissions: active_emissions,
      bounds: bounds
    });

    // Private

    function allOptionsChosen(option) {
      return active_emissions.indexOf(option) >= 0;
    }

    function formatBounds(boundsData){
      return [boundsData._southWest.lat, boundsData._southWest.lng, boundsData._northEast.lat, boundsData._northEast.lat]
    }
  }

  $scope.convertStateToLink = function() {

  }

  function loadState() {
    // Route Params ----------------------------
    // reporting_year --> YR-START_YR-END (always 2)
    // emissions --> ['Water', 'Air']
    // bounds --> S-lat_S-long_N-lat_N-long
    $scope.state = {};

    // Handle reporting_year
    if($routeParams.reporting_year) {
      var rawBounds = $routeParams.reporting_year.split('_').map(Number);
      $scope.state.reporting_year = _.range(rawBounds[0], rawBounds[1]+1);
    } else {
      $scope.state.reporting_year = [];
    }

    $scope.state.emissions = $routeParams.emissions ? $routeParams.emissions.split('_') : [];
    $scope.state.bounds = $routeParams.bounds ? $routeParams.bounds.split('_').map(Number) : [];

    Map.update($scope.state);
  }
}
