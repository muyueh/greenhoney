var flatten, buildBar, buildRect;
flatten = require("prelude-ls").flatten;
buildBar = function(){
  var m, build, i$;
  m = {};
  m.dtsr = 3;
  m.margin = 0.5;
  build = function(it){
    return it.attr({
      "cx": function(it, i){
        return it.ingrpidx * 2 * (m.dtsr + m.margin);
      },
      "cy": function(it, i){
        return it.grpidx * 2 * (m.dtsr + m.margin);
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
  m.margin = 0.5;
  m.rectWidth = 50;
  build = function(it){
    return it.attr({
      "cx": function(it, i){
        return (it.ttlidx % m.rectWidth) * 2 * (m.dtsr + m.margin);
      },
      "cy": function(it, i){
        return ~~(it.ttlidx / m.rectWidth) * 2 * (m.dtsr + m.margin);
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