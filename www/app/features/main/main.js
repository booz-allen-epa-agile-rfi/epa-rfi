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
function MainController($scope, $routeParams, $location, Map, Geocode) {
  $scope.state = {
    emissions: [],
    reporting_year: [],
    bounds: []
  }
  $scope.searchValue = '';

  $scope.subdomain = getSubDomain();

  // Initialization

  if(!_.isEmpty($routeParams)) initState();
  $scope.shareUrl = generateShareUrl($scope.state);
  initClipboard();

  // Map Search
  $scope.searchSubmit = function(searchVal) {
    Geocode.search(searchVal, grabState());
  };

  // On Submit of Filters
  $scope.submitMapFilters = function(e) {
    $scope.state = grabState();
    Map.update($scope.state);
    Map.clearHiddenFacilities();
    $scope.shareUrl = generateShareUrl($scope.state);
  };

  function getSubDomain() {
    var regexParse = new RegExp('[a-z\-0-9]{2,63}\.[a-z\.]{2,5}$');
    var urlParts = regexParse.exec(window.location.hostname);
    var subdomain = window.location.hostname.replace(urlParts[0],'').slice(0, -1);

    return (subdomain == '') ? 'api' : subdomain + '-api';
  }

  // Generate the current url map state
  function generateShareUrl(state) {
    var url = 'http://treeview.io' + '/' +
      '?bounds=' + state.bounds.join('_') +
      '&emissions=' + state.emissions.join('_') +
      '&reporting_year=' + state.reporting_year.join('_')

    return url;
  }

  // Grab state data from url parameters and initialize map
  function initState() {
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
      return this.textContent.trim().toLowerCase();
    }).get() || {};

    var startYear = $('#start-year').val();
    var endYear = $('#end-year').val();
    var reporting_year = _.range(parseInt(startYear), parseInt(endYear)+1);

    if(emissions.indexOf('total') >= 0 || ['land', 'water', 'air'].every(allOptionsChosen)){
      emissions = ['land', 'air', 'water'];
    }

    var bounds = formatBounds(Map.map.getBounds()) || {};

    return {
      emissions: emissions,
      reporting_year: reporting_year,
      bounds: bounds
    }

    function allOptionsChosen(option) {
      return emissions.indexOf(option) >= 0;
    }

    function formatBounds(boundsData){
      return [boundsData._southWest.lat, boundsData._southWest.lng, boundsData._northEast.lat, boundsData._northEast.lng]
    }
  }

  function initClipboard(){
    var client = new ZeroClipboard(document.getElementById("copy-button"));
  }
}
