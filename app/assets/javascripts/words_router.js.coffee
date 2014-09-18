WordsRouter = angular.module "WordsRouter", [
  "ngRoute",
  "ngResource"
]

class Router

  constructor: (@routeProvider, @locationProvider) ->
    console.log("Initialized Router")
    console.log("Setting Up")
    @routeProvider
      .when "/",
        templateUrl: "/word_template",
        controller: "WordsCtrl as words"
      .when "/words/:id",
        templateUrl: "/word_template/show.html",
        controller: "ShowWordCtrl as showWord"

    @locationProvider.html5Mode(true)

WordsRouter.config ["$routeProvider", "$locationProvider", Router]

WordsRouter.config ["$httpProvider", ($httpProvider) ->
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
]