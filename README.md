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


# what limbo looks like

``` js
var MyClass = Limbo(function(proto) {
  // this is the initialization method
  proto.init = function(arg) {
    // you can call private methods here
    myPrivateMethod(this, arg);
  };

  // closure-based "private" methods
  function myPrivateMethod(self, arg) {
    self.arg = arg;
  }
});

// create objects by just calling the plain function
var myObject = MyClass()

// using the `new` operator with no args
// will allocate an object without calling .init()
var myUninitializedObject = new MyClass
```

# how you use limbo

You can call `Limbo` in a few different ways:

``` js
# this defines a class that inherits directly from Object.
Limbo(function(proto, super, class, superclass) { ... });

# this defines a class that inherits from MySuperclass
Limbo(MySuperclass, function(proto, super, class, superclass) { ... });
```
