var listsToObj, buildForce;
listsToObj = ((typeof window !== "undefined" ? window.prelude : void 8) || {}).listsToObj;
buildForce = function(){
  var f, build, i$;
  f = {};
  f.dtsr = 3;
  f.data = [];
  f.size = 800;
  f.margin = 1.5;
  f.targetFunc = function(it){
    it.target = {};
    it.target.x = 300;
    it.target.y = 300;
    return true;
  };
  build = function(){
    var force, collide, node;
    f.data = f.data.filter(f.targetFunc);
    force = d3.layout.force().nodes(f.data).links([]).gravity(0).charge(0).size([f.size, f.size]).on("tick", tick);
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
          r = 2 * f.dtsr + f.margin;
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
  for (i$ in f) {
    (fn$.call(this, i$));
  }
  return build;
  function fn$(it){
    build[it] = function(v){
      f[it] = v;
      return build;
    };
  }
};