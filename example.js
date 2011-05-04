var MyModule = (function(Class, create) {
  var Greeter = Class(function(proto) {
    // an initializer
    init = function(name) {
      this.name = name
    }

    // private functions
    function sayHello(self) {
      console.log("Hello, "+self.name);
    }

    function sayGoodBye(self) {
      console.log("Goodbye, "+self.name);
    }

    return {
      // an initializer
      init: function(foo) { this.foo = foo },
      greet: function() { sayHello(this); sayGoodBye(this); }
    }
  });

  var joe = create(Person, "Joe");
  console.log(joe instanceof Person) // true
  console.log(joe.name) // Joe
  joe.greet() // Hello, Joe\nGoodbye, Joe

  var Ninja = Class(Person, function(proto, _super, Ninja, Person) {
    
  });
})(Limbo, Limbo.create);
