var flatten, buildBar, buildRect;
flatten = require("prelude-ls").flatten;
buildBar = function(){
  var m, build, i$;
  m = {};
  m.dtsr = 3;
  m.margin = 1;
  build = function(it){
    return it.each(function(it, i){
      it.x = it.ingrpidx * 2 * (m.dtsr + m.margin);
      return it.y = it.grpidx * 2 * (m.dtsr + m.margin);
    }).attr({
      "cx": function(it){
        return it.x;
      },
      "cy": function(it){
        return it.y;
      }
    });
  };
  for (i$ in m) {
    (fn$.call(this, i$));
  }
  return build;
  function fn$(it){
    build[it] = function(v){
      m[it] = v;
      return build;
    };
  }
};
buildRect = function(){
  var m, build, i$;
  m = {};
  m.dtsr = 3;
  m.margin = 1;
  m.rectWidth = 50;
  build = function(it){
    return it.each(function(it, i){
      it.x = (it.ttlidx % m.rectWidth) * 2 * (m.dtsr + m.margin);
      return it.y = ~~(it.ttlidx / m.rectWidth) * 2 * (m.dtsr + m.margin);
    }).attr({
      "cx": function(it){
        return it.x;
      },
      "cy": function(it){
        return it.y;
      }
    });
  };
  for (i$ in m) {
    (fn$.call(this, i$));
  }
  return build;
  function fn$(it){
    build[it] = function(v){
      m[it] = v;
      return build;
    };
  }
};