// from http://onestepback.org/articles/poly/

var Shape = P(function(shape) {
  shape.moveTo = 
  shape.init = function(x, y) { this.x = x; this.y = y; };
  shape.move = function(x, y) { this.moveTo(this.x + x, this.y + y); };
});

var Rectangle = P(Shape, function(rect, shape) {
  // @override
  rect.init = function(x, y, w, h) {
    shape.init.call(this, x, y);
    this.w = w;
    this.h = h;
  };
});

var Circle = P(Shape, function(circle, shape) {
  // @override
  circle.init = function(x, y, radius) {
    shape.init.call(this, x, y);
    this.radius = radius;
  };
});
