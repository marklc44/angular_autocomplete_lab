// Generated by CoffeeScript 1.8.0
var Router, WordsRouter;

WordsRouter = angular.module("WordsRouter", ["ngRoute", "ngResource"]);

Router = (function() {
  function Router(routeProvider, locationProvider) {
    this.routeProvider = routeProvider;
    this.locationProvider = locationProvider;
    console.log("Initialized Router");
    console.log("Setting Up");
    this.routeProvider.when("/", {
      templateUrl: "/word_template",
      controller: "WordsCtrl as words"
    }).when("/words/:id", {
      templateUrl: "/word_template/show.html",
      controller: "ShowWordCtrl as showWord"
    });
    this.locationProvider.html5Mode(true);
  }

  return Router;

})();

WordsRouter.config(["$routeProvider", "$locationProvider", Router]);

WordsRouter.config([
  "$httpProvider", function($httpProvider) {
    return $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
  }
]);
