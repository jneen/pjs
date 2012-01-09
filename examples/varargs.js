var Breakfast = P(function(breakfast) {
  breakfast.init = function(bacon, eggs) {
    this.bacon = bacon;
    this.eggs = eggs;
  };
});

Breakfast('bacon', 'eggs') // => { bacon: 'bacon', eggs: 'eggs' }

// it's just a function.  Use `apply` to call it with varargs.
// NB: this is impossible with traditional JS and the `new` keyword.
var ingredients = ['bacon', 'eggs'];
Breakfast.apply(null, ingredients) // => { bacon: 'bacon', eggs: 'eggs' }
