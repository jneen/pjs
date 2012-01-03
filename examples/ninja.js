var Person = C(function(person) {
  person.init = function(isDancing) { this.dancing = isDancing };
  person.dance = function() { return this.dancing };
});

var Ninja = C(Person, function(ninja, person) {
  ninja.init = function() { person.init.call(this, false) };
  ninja.swingSword = function() { return 'swinging sword!' };
});

var p = Person(true);
p.dance(); // => true

var n = Ninja();
n.dance(); // => false
n.swingSword(); // => 'swinging sword!'
