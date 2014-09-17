WordsCtrls = angular.module "WordsCtrls", []

class WordsCtrl

  constructor: (@scope, @Word, @Trie) ->
    @words = []
    @t = new @Trie()
    @completions = []

    @Word.all().success (data) =>
      @words = data
      # console.log(@words)
      @words.forEach (word) =>
        # console.log word
        @t.learn(word.name)
        console.log @t


  completeWord: (word) ->
    @completions = @t.autoComplete(word)


  addWords: (word) =>
    @Word.create(word).success (data) =>
      @words.push(data)
      @t.learn(data.name)
      console.log @t
      @scope.newWord = {}


class ShowWordCtrl

  constructor: (@scope, @Word, routeParams) ->

  # @Word.find(id).success (data) =>
  #   @word = data
  #   console.log(@word)


WordsCtrls.controller "WordsCtrl", ["$scope", "Word", "Trie", WordsCtrl]

WordsCtrls.controller "ShowWordCtrl", ["$scope", "Word", "$routeParams", ShowWordCtrl]