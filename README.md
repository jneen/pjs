# P.js

P.js is a lightweight layer over javascript's built-in inheritance system that keeps all the good stuff and hides all the crap.

## just show me some code already

Okay.

``` js
// adapted from coffeescript.org
// P.js exposes the `P` variable
var Animal = P(function(animal) {
  animal.init = function(name) { this.name = name; };

  animal.move = function(meters) {
    console.log(this.name+" moved "+meters+"m.");
  }
});

var Snake = P(Animal, function(snake, animal) {
  snake.move = function() {
    console.log("Slithering...");
    animal.move.call(this, 5);
  };
});

var Horse = P(Animal, function(horse, animal) {
  horse.move = function() {
    console.log("Galloping...");
    animal.move.call(this, 45);
  };
});

var sam = Snake("Sammy the Python")
  , tom = Horse("Tommy the Palomino")
;

sam.move()
tom.move()
```

## how is pjs different from X

Most class systems for JS let you define classes by passing an object.  P.js lets you pass a function instead, which allows you to closure private methods and macros.  It's also <500b minified.

### why doesn't pjs suck?

Unlike [some][prototypejs] [other][classjs] [frameworks][joose] [out][zjs] [there][structr], Pjs doesn't do any of this:

- mixins, interfaces, abstract static factory factories, [and][joose] [other][prototypejs] [bloat][zjs]
- use Object.create (it even works in IE &lt; 8!)
- break `instanceof`
- [hack functions onto `this` at runtime][classjs]
- rely on magical object keys which don't minify (the only special name is `init`)

[prototypejs]: http://prototypejs.org/learn/class-inheritance
[classjs]: https://github.com/kilhage/class.js
[zjs]: http://code.google.com/p/zjs/
[joose]: http://joose.it
[structr]: http://search.npmjs.org/#/structr

## what can i do with pjs?

- inheritable constructors (via the optional `init` method)
- closure-based "private" methods (see below)
- easily call `super` on public methods without any dirty hacks
- instantiate your objects without calling the constructor (absolutely necessary for inheritance)
- construct objects with variable arguments

## how do i use pjs?

You can call `P` in a few different ways:

``` js
// this defines a class that inherits directly from Object.
P(function(proto, super, class, superclass) {
  // define private methods as regular functions that take
  // `self` (or `me`, or `it`, or anything you really want)
  function myPrivateMethod(self, arg1, arg2) {
    // ...
  }

  proto.init = function() {
    myPrivateMethod(this, 1, 2)
  };

  // you can also return an object from this function, which will
  // be merged into the prototype.
  return { thing: 3 };
});

// this defines a class that inherits from MySuperclass
P(MySuperclass, function(proto, super, class, superclass) {
  proto.init = function() {
    // call superclass methods with super.method.call(this, ...)
    //                           or super.method.apply(this, arguments)
    super.init.call(this);
  };
});

// for shorthand, you can pass an object in lieu of the function argument,
// but you lose the niceness of super and private methods.
P({ init: function(a) { this.thing = a } });

MyClass = P(function(p) { p.init = function() { console.log("init!") }; });
// instantiate objects by calling the class
MyClass() // => init!

// allocate blank objects with `new`
new MyClass // nothing logged
```
