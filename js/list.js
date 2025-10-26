var flatten, buildList;
flatten = ((typeof window !== "undefined" ? window.prelude : void 8) || {}).flatten;
buildList = function(){
  var m, build, i$;
  m = {};
  m.dtsr = 3;
  m.margin = 5;
  m.type = "circle";
  m.limit = 300;
  m.colw = 100;
  build = function(it){
    if (m.type === "circle") {
      return it.attr({
        "cx": function(it, i){
          return m.colw / 3 + ~~(i / m.limit) * m.colw;
        },
        "cy": function(it, i){
          return (i % m.limit) * 2 * (m.dtsr + m.margin);
        }
      });
    } else if (m.type === "text") {
      return it.attr({
        "x": function(it, i){
          return m.colw / 3 + 10 + ~~(i / m.limit) * m.colw;
        },
        "y": function(it, i){
          return (i % m.limit) * 2 * (m.dtsr + m.margin) + 6;
        }
      }).style({
        "opacity": function(it, i){
          if (~~((i + 1) / m.limit) < 5) {
            return 0.3;
          } else {
            return 0;
          }
        }
      });
    }
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