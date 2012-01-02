# Limbo

Limbo is a lightweight layer over javascript's built-in inheritance system that keeps all the good stuff and hides all the crap.

# what limbo doesn't do

- limit itself to Limbo-defined classes (you can inherit from Error or Boolean or even Function)
- mixins, interfaces, abstract static factory factories, and other bloat
- use Object.create (it even works in IE &lt; 8!)

# what you can do with limbo

- inheritable constructors (via the optional `init` method)
- closure-based "private" methods (see below)
- instantiate your objects without calling the constructor (absolutely necessary for inheritance)
- construct objects with variable arguments

# what limbo looks like

``` js
// adapted from coffeescript.org
var Animal = Limbo(function(animal) {
  animal.init = function(name) { this.name = name; };

  animal.move = function(meters) {
    console.log(this.name+" moved "+meters+"m.");
  }
});

var Snake = Limbo(Animal, function(snake, animal) {
  snake.move = function() {
    console.log("Slithering...");
    animal.move.call(this, 5);
  };
});

var Horse = Limbo(Animal, function(horse, animal) {
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

# how you use limbo

You can call `Limbo` in a few different ways:

``` js
// this defines a class that inherits directly from Object.
Limbo(function(proto, super, class, superclass) { ... });

// this defines a class that inherits from MySuperclass
Limbo(MySuperclass, function(proto, super, class, superclass) {
  proto.init = function() {
    // call superclass methods with super.method.call(this, ...)
    //                           or super.method.apply(this, arguments)
    super.init.call(this);
  };
});

MyClass = Limbo(function(p) { p.init = function() { console.log("init!") }; });
// instantiate objects by calling the class
MyClass() // => init!

// allocate blank objects with `new`
new MyClass // nothing logged
```
