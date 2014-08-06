var buildPallete;
buildPallete = function(){
  var m, build, i$;
  m = {};
  m.cx = 250;
  m.cy = 250;
  m.cr = 250;
  m.mdl = function(it){
    return d3.hsl(it);
  };
  m.mdlfx = "s";
  m.lightload = false;
  build = function(it){
    return it.each(function(it){
      var clr, attr;
      clr = m.mdl(it.color);
      for (attr in clr) {
        if (isNaN(clr[attr])) {
          clr[attr] = 0;
        }
      }
      it.x = m.cx + Math.cos(clr.h * Math.PI / 180) * m.cr * clr[m.mdlfx];
      return it.y = m.cy + Math.sin(clr.h * Math.PI / 180) * m.cr * clr[m.mdlfx];
    }).attr({
      "cx": function(it, i){
        return it.x;
      },
      "cy": function(it, i){
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