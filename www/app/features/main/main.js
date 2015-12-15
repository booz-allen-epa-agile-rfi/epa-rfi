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

/** @ngInject */
function MainController($scope, $routeParams, $location, Map) {
  $scope.state = $scope.state || {};

  if(!_.isEmpty($routeParams)) initState();
  $scope.shareUrl = generateShareUrl();

  $scope.submitMapFilters = function(e) {
    $scope.state = grabState();
    Map.update($scope.state);
  }

  function generateShareUrl() {
    // return 'hello'
    // var currentState = grabState();

    // $location.search('');
    // $location.search('bounds', currentState.bounds.join('_'));
    // $location.search('emissions', currentState.emissions.join('_'));
    // $location.search('reporting_year', currentState.reporting_year.join('_'));

    // var url = $location.absUrl();
    // console.log(url);
    // return url;
  }

  function initState() {
    // Route Params ----------------------------
    // reporting_year --> YR-START_YR-END (always 2)
    // emissions --> ['Water', 'Air']
    // bounds --> S-lat_S-long_N-lat_N-long
    if(isInRouteParams('reporting_year')) {
      var rawBounds = $routeParams.reporting_year.split('_').map(Number);
      $scope.state.reporting_year = _.range(rawBounds[0], rawBounds[1]+1);
    } else {
      $scope.state.reporting_year = [];
    }

    $scope.state.emissions = isInRouteParams('emissions') ? $routeParams.emissions.split('_') : [];
    $scope.state.bounds = isInRouteParams('bounds') ? $routeParams.bounds.split('_').map(Number) : [];

    Map.update($scope.state);

    function isInRouteParams(keyToCheck) {
      return $routeParams[keyToCheck] && $routeParams[keyToCheck] != '';
    }
  }

  // Grabs the state and returns it in an object format

  function grabState() {
    var emissions = $('#emission').find('.active').map(function(){
      return this.textContent.trim();
    }).get() || {};

    // var startYear = $('#start-year').value();
    // var endYear = $('#end-year').value();
    // var reporting_year = _.range(startYear, endYear+1);
    var reporting_year = [];

    if(emissions.indexOf('Total') >= 0 || ['Land', 'Water', 'Air'].every(allOptionsChosen)){
      emissions = ['Total'];
    }

    var bounds = formatBounds(Map.map.getBounds()) || {};

    return {
      emissions: emissions,
      reporting_year: reporting_year,
      bounds: bounds
    }

    // Private

    function allOptionsChosen(option) {
      return emissions.indexOf(option) >= 0;
    }

    function formatBounds(boundsData){
      return [boundsData._southWest.lat, boundsData._southWest.lng, boundsData._northEast.lat, boundsData._northEast.lat]
    }
  }
}
