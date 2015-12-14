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

function MainController($scope) {
  $scope.submitMapFilters = function(e) {
    var active = $('#emission').find('.active').map(function(){
      return this.textContent.trim();
    }).get();

    if(active.indexOf('Total') >= 0 || ['Land', 'Water', 'Air'].every(allOptionsChosen)){
      active = ['Total'];
    }

    

    // Private

    function allOptionsChosen(option) {
      return active.indexOf(option) >= 0;
    }
  }  
}
