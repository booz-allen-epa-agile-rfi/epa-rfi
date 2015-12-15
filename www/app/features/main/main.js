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

function MainController($scope, Map) {
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

    Map.update({
      reporting_year: reporting_year,
      emissions: active_emissions
    });    

    // Private

    function allOptionsChosen(option) {
      return active_emissions.indexOf(option) >= 0;
    }
  }  
}
