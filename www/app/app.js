'use strict';

/**
 * @ngdoc overview
 * @name gapFront
 * @description
 * # gapFront
 *
 * Main module of the application.
 */
angular
  .module('gapFront', [
    'ngAnimate',
    'ngCookies',
    'ngResource',
    'ngRoute',
    'ngSanitize',
    'ngTouch',
    'restangular',
    'ui.checkbox',
    'mgcrea.ngStrap',
    'angularSpinner'
  ])
  .config(function ($routeProvider, $locationProvider) {
    $routeProvider
      .when('/', {
        templateUrl: 'features/main/main.html',
        controller: 'MainCtrl'
      })
      // .when('/about', {
      //   templateUrl: 'features/routeView/routeView.html'
      // })
      .otherwise({
        redirectTo: '/'
      });
      $locationProvider.html5Mode(true);
  })
  .config(function($modalProvider) {
    angular.extend($modalProvider.defaults, {
      html: true
    });
  });
