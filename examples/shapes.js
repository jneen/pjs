// from http://onestepback.org/articles/poly/

var Shape = C(function(shape) {
  shape.moveTo = 
  shape.init = function(x, y) { this.x = x; this.y = y; };
  shape.move = function(x, y) { this.moveTo(this.x + x, this.y + y); };
});

var Rectangle = C(Shape, function(rect, shape) {
  // @override
  rect.init = function(x, y, width, height) {
    shape.init.call(this, x, y);
    this.w = w;
    this.h = h;
  };
});

var Circle = C(Shape, function(circle, shape) {
  // @override
  circle.init = function(x, y, radius) {
    shape.init.call(this, x, y);
    this.radius = radius;
  };
});
