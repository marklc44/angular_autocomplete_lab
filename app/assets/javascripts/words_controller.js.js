// Generated by CoffeeScript 1.8.0
var ShowWordCtrl, WordsCtrl, WordsCtrls,
  __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

WordsCtrls = angular.module("WordsCtrls", []);

WordsCtrl = (function() {
  function WordsCtrl(scope, resource, Trie) {
    this.scope = scope;
    this.resource = resource;
    this.Trie = Trie;
    this.findByName = __bind(this.findByName, this);
    this.addWords = __bind(this.addWords, this);
    this.words = [];
    this.t = new this.Trie();
    this.completions = [];
    this.Word = this.resource("/words/:id.json", {});
    this.Word.query((function(_this) {
      return function(data) {
        console.log(data);
        _this.words = data;
        return _this.words.forEach(function(word) {
          return _this.t.learn(word.name);
        });
      };
    })(this));
  }

  WordsCtrl.prototype.completeWord = function(word) {
    return this.completions = this.t.autoComplete(word);
  };

  WordsCtrl.prototype.addWords = function(word) {
    return this.Word.save({
      word: word
    }, (function(_this) {
      return function(data) {
        _this.words.push(data);
        _this.t.learn(data.name);
        return _this.scope.newWord = {};
      };
    })(this));
  };

  WordsCtrl.prototype.findByName = function(name) {
    var item, result;
    result = (function() {
      var _i, _len, _ref, _results;
      _ref = this.words;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        item = _ref[_i];
        if (item.name === name) {
          _results.push(item);
        }
      }
      return _results;
    }).call(this);
    return result[0].id;
  };

  return WordsCtrl;

})();

ShowWordCtrl = (function() {
  function ShowWordCtrl(scope, resource, routeParams) {
    this.scope = scope;
    this.resource = resource;
    this.word = '';
    this.id = routeParams.id;
    this.Word = this.resource("/words/:id", {
      id: this.id
    });
    this.Word.get({
      id: this.id
    }, (function(_this) {
      return function(data) {
        return _this.word = data;
      };
    })(this));
  }

  return ShowWordCtrl;

})();

WordsCtrls.controller("WordsCtrl", ["$scope", "$resource", "Trie", WordsCtrl]);

WordsCtrls.controller("ShowWordCtrl", ["$scope", "$resource", "$routeParams", ShowWordCtrl]);
