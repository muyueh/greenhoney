var listsToObj, buildForce, ifNaN, go;
listsToObj = require("prelude-ls").listsToObj;
buildForce = function(){
  var f, build;
  f = {};
  f.dtsr = 3;
  f.data = [];
  build = function(){
    var force, collide, node;
    force = d3.layout.force().nodes(f.data).links([]).gravity(0).charge(0).size([500, 500]).on("tick", tick);
    function tick(it){
      var k, q, i, n;
      k = 0.1 * it.alpha;
      f.data.forEach(function(o, i){
        o.y += (o.target.y - o.y) * k;
        return o.x += (o.target.x - o.x) * k;
      });
      q = d3.geom.quadtree(f.data);
      i = 0;
      n = f.data.length;
      while (++i < n) {
        q.visit(collide(f.data[i]));
      }
      return node.attr({
        "cx": function(it){
          return it.x;
        },
        "cy": function(it){
          return it.y;
        }
      });
    }
    collide = function(it){
      var r, nx1, nx2, ny1, ny2;
      r = f.dtsr;
      nx1 = it.x - r;
      nx2 = it.x + r;
      ny1 = it.y - r;
      ny2 = it.y + r;
      return function(quad, x1, y1, x2, y2){
        var x, y, l, r;
        if (quad.point && quad.point !== it) {
          x = it.x - quad.point.x;
          y = it.y - quad.point.y;
          l = Math.sqrt(x * x + y * y);
          r = 2 * f.dtsr;
          if (l < r) {
            l = (l - r) / l * 0.5;
            it.x -= x *= l;
            it.y -= y *= l;
            quad.point.x += x;
            quad.point.y += y;
          }
        }
        return x1 > nx2 || x2 < nx1 || y1 > ny2 || y2 < ny1;
      };
    };
    node = svg.selectAll("circle").data(f.data).enter().append("circle").attr({
      "class": "node",
      "r": f.dtsr
    }).style({
      "fill": function(it){
        return it.color;
      }
    }).call(force.drag);
    return force.start();
  };
  ["data", "dtsr"].map(function(it){
    return build[it] = function(v){
      f[it] = v;
      return build;
    };
  });
  return build;
};
ifNaN = function(it){
  if (isNaN(it)) {
    return 0;
  } else {
    return it;
  }
};
go = function(){
  var dt, a;
  dt = gnh.cdata.clr_en.filter(function(it){
    var clr;
    it.target = {};
    it.target.x = 0;
    it.target.y = 0;
    clr = d3.hsl(it.color);
    it.target.x = 250 + Math.cos(ifNaN(clr.h) * Math.PI / 180) * 250 * ifNaN(clr.s);
    it.target.y = 250 + Math.sin(ifNaN(clr.h) * Math.PI / 180) * 250 * ifNaN(clr.s);
    return true;
  });
  a = buildForce().data(dt);
  return a();
};