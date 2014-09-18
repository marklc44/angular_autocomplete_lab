WordsCtrls = angular.module "WordsCtrls", []

class WordsCtrl

  constructor: (@scope, @resource, @Trie) ->
    @words = []
    @t = new @Trie()
    @completions = []

    @Word = @resource "/words/:id.json", {}

    @Word.query (data) =>
      console.log data
      @words = data
      @words.forEach (word) =>
        @t.learn(word.name)

  completeWord: (word) ->
    @completions = @t.autoComplete(word)

  addWords: (word) =>
    @Word.save {word: word}, (data) =>
      @words.push(data)
      @t.learn(data.name)
      @scope.newWord = {}

  findByName: (name) =>
    result = (item for item in @words when item.name is name)
    result[0].id


class ShowWordCtrl

  constructor: (@scope, @resource, routeParams) ->
    @word = ''
    @id = routeParams.id
    @Word = @resource "/words/:id", {id: @id}

    @Word.get {id: @id}, (data) =>
      @word = data


WordsCtrls.controller "WordsCtrl", ["$scope", "$resource", "Trie", WordsCtrl]

WordsCtrls.controller "ShowWordCtrl", ["$scope", "$resource", "$routeParams", ShowWordCtrl]