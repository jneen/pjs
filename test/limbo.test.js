var assert = require('assert')
  , Limbo = require('./../build/limbo.min.js').Limbo
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
});
