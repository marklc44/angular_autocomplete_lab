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

  completeWord: (word) ->
    @completions = @t.autoComplete(word)

  addWords: (word) =>
    @Word.create(word).success (data) =>
      @words.push(data)
      @t.learn(data.name)
      @scope.newWord = {}

  findByName: (name) =>
    result = (item for item in @words when item.name is name)
    result[0].id


class ShowWordCtrl

  constructor: (@scope, @Word, routeParams) ->
    @word = ''
    id = routeParams.id.split('.')[0]
    @Word.find(id).success (data) =>
      @word = data


WordsCtrls.controller "WordsCtrl", ["$scope", "Word", "Trie", WordsCtrl]

WordsCtrls.controller "ShowWordCtrl", ["$scope", "Word", "$routeParams", ShowWordCtrl]