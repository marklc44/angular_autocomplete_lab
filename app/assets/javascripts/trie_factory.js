var TrieFactories = angular.module("TrieFactories", [])

TrieFactories.factory("Trie", [function() {
  Trie = function(){
    this.characters = {};
  };

  Trie.prototype.learn = function(word, index){

    if (index === undefined) {
      index = 0;
    }
    if (word.length === index) {
      this.isWord = true;
    } else {
      if (this.characters[word[index]] === undefined) {
        this.characters[word[index]] = new Trie();
        this.characters[word[index]].learn(word, index + 1);
      } else {
        this.characters[word[index]].learn(word, index + 1);
      }
    }
  };

  Trie.prototype.getWords = function(words, currentWord){
    currentWord = currentWord || '';
    words = words || [];

    if (this.isWord) {
      words.push(currentWord);
    }
    for (var letter in this.characters) {
      var nextWord = currentWord + letter;
      this.characters[letter].getWords(words, nextWord);
    }
    return words;
  };

  Trie.prototype.find = function(word, index){
    if (index === undefined) {
      index = 0;
    }

    var node = this.characters[word[index]];
    if (node) {
      if(word.length - 1 === index) {
        return node;
      } else {
        return node.find(word, index + 1);
      }
    }
  };

  Trie.prototype.autoComplete = function(prefix){

    var node = this.find(prefix);

    if (node) {
      var suffixes = node.getWords();

      var wholeWords = suffixes.map(function(suffix) {
        return prefix + suffix;
      });

      return wholeWords;
    } else {
      return [];
    }
  };
  return Trie;
}]);
