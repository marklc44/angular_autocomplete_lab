WordsFactories = angular.module "WordsFactories", []

WordsFactories.factory "Word", ["$http", ($http) ->
  return {
    all: ->
      $http.get("/words.json")
    ,
    create: (word) ->
      console.log("create run")
      $http.post("/words.json", {word: word})
    ,
    find: (id) ->
      console.log("id: ", id)
      $http.get("/words/#{id}.json")
  }
]