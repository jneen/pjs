var Limbo = module.exports = (function() {
  var slice = [].slice;
  function Limbo(_superclass, definition) {
    function Noop() {}

    if (typeof definition === 'undefined') {
      definition = _superclass;
      _superclass = Object;
    }
    else if (typeof _superclass.prototype === 'object') {
      Noop.prototype = new _superclass;
    }

    var proto = Noop.prototype
      , _super = _superclass.prototype
      , extensions = {}
    ;

    if (typeof definition === 'function') {
      extensions = definition(proto, Noop, _super, _superclass);
    }
    else if (definition && typeof definition === 'object') {
      extensions = definition;
    }

    if (extensions && typeof extensions === 'object') {
      for (var ext in extensions) {
        if (extensions.hasOwnProperty(ext)) {
          proto[ext] = extensions[ext];
        }
      }
    }

    return Noop;
  }

  Limbo.create = function create(klass /*, args... */) {
    var args = slice.call(arguments, 1)
      , obj = new klass
    ;

    if (typeof obj.init === 'function') obj.init.apply(obj, args);

    return obj;
  };


  return Limbo;
})();
