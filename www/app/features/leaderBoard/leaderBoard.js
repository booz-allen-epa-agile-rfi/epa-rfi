'use strict';

/**
 * @ngdoc function
 * @name gapFront.controller:LeaderBoardCtrl
 * @description A simple controller to update leader board.
 * # LeaderBoardCtrl
 * Controller of the gapFront
 */
angular.module('gapFront')
  .controller('LeaderBoardCtrl', function ($scope, APIService, IntegrationService) {

    IntegrationService.registerIntegrationMethod('initLeaderBoard', initLeaderBoard);

    var initLeaderBoard = function(params){
      $scope.selectedDrug = DrugService.getSelectedDrug();

      APIService.getLeadersApi().getList().then(function(resp) {
        $scope.leaders = resp;
      });
    };

    APIService.getLeadersApi().getList().then(function(resp) {
      $scope.leaders = resp;
    });


    $scope.addLeader = function(leader){
      var post = {leader: {name: leader.firstName + ' ' + leader.lastName, zipcode: leader.zip, count: 5}};
      $scope.newLeader = name;
      APIService.getLeadersApi().post(post).then(function() {
        APIService.getLeadersApi().getList().then(function(resp) {
          $scope.leaders = resp;
        });
      }, serviceError);
    };

    function serviceError(error) {
    }

    // $scope.leaders = ["Steve S.", "Jason P.", "Sami M.", "Sameer D.", "Fred J.", "George B.", "Shelly R."];
});
