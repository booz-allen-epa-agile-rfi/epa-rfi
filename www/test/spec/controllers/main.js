'use strict';

describe('Controller: MainCtrl', function () {

  // load the controller's module
  beforeEach(module('gapFront'));

  var MainCtrl,
    scope;

  // Initialize the controller and a mock scope
  beforeEach(inject(function ($controller, $rootScope) {
    scope = $rootScope.$new();
    MainCtrl = $controller('MainCtrl', {
      $scope: scope,
      IntegrationService: {
        callIntegrationMethod: function(){
          return null;
        }
      }
    });
  }));

  it('should have clear search area on page load', function () {
    expect(scope.searchValue).toBe('');
  });

  describe('scope.state', function(){
    it('should be an array of strings for emissions', function() {
      _.each(scope.emissions, function(emission) {
        expect(typeof emission).toEqual('string');
      });
    });
    it('should be an array of strings for reporting_year', function() {
      _.each(scope.reporting_year, function(reporting_year) {
        expect(typeof reporting_year).toEqual('string');
      });
    });
    it('should be an array of strings for bounds', function() {
      _.each(scope.bounds, function(bounds) {
        expect(typeof bounds).toEqual('string');
      });
    });
  });

  it('should contain bounds, emissions and reporting_year in the generateShareUrl', function(){
    expect(scope.generateShareUrl).toBeUndefined();
    var url = 'http://treeview.io:9000' + '/' +
      '?bounds=' +
      '&emissions=' +
      '&reporting_year='
  });
});
