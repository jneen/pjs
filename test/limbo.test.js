var assert = require('assert')
  , Limbo = require('./../index').Limbo
;

describe('Limbo', function() {
  describe('creating idiomatic classes', function() {
    var MyClass = Limbo(function(p) {
      p.foo = 1
    });

    it('creates functions', function() {
      assert.equal('function', typeof MyClass);
    });

    it('uses the prototype', function() {
      assert.equal(1, MyClass.prototype.foo);
    });

    it('respects instanceof', function() {
      assert.ok(new MyClass instanceof MyClass);
      assert.ok(MyClass() instanceof MyClass);
    });
  });

  describe('init', function() {
    var MyClass = Limbo(function(p) {
      p.init = function() {
        this.initCalled = true;
        this.initArgs = arguments;
      };

      p.initCalled = false;
    });

    it('is called when the class is called plainly', function() {
      assert.ok(MyClass().initCalled);
      assert.equal(3, MyClass(1,2,3).initArgs[2]);
    });

    it('is not called when the new keyword is given', function() {
      assert.ok(!(new MyClass).initCalled);
    });
  });

  describe('inheritance', function() {
    // see examples/ninja.js
    var Person = Limbo(function(person) {
      person.init = function(isDancing) { this.dancing = isDancing };
      person.dance = function() { return this.dancing };
    });

    var Ninja = Limbo(Person, function(ninja, person) {
      ninja.init = function() { person.init.call(this, false) };
      ninja.swingSword = function() { return 'swinging sword!' };
    });

    var ninja = Ninja();

    it('respects instanceof', function() {
      assert.ok(ninja instanceof Person);
    });

    it('inherits methods (also super)', function() {
      assert.equal(false, ninja.dance());
    });
  });

  describe('definition', function() {
    it('passes the prototype as the first arg', function() {
      var proto;
      var MyClass = Limbo(function(p) { proto = p; });

      assert.equal(proto, MyClass.prototype);
    });

    it('passes the superclass prototype as the second arg', function() {
      var _super;
      Limbo(Error, function(a, b) { _super = b; });
      assert.equal(_super, Error.prototype);
    });

    it('passes the class itself as the third arg', function() {
      var klass;
      var MyClass = Limbo(function(a, b, c) { klass = c; });

      assert.equal(klass, MyClass);
    });

    it('passes the superclass as the fourth argument', function() {
      var sclass;
      var MyClass = Limbo(function(a, b, c, d) { sclass = d; });
      assert.equal(Object, sclass);

      Limbo(MyClass, function(a, b, c, d) { sclass = d; });
      assert.equal(MyClass, sclass);
    });

    it('passes the class itself as `this`', function() {
      var klass;
      var MyClass = Limbo(function() { klass = this; });
      assert.equal(MyClass, klass);
    });

  });
});
