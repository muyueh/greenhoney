var ref$, listsToObj, join, flatten, buildForce, ifNaN, go, move;
ref$ = (typeof window !== "undefined" ? window.prelude : void 8) || {}, listsToObj = ref$.listsToObj, join = ref$.join, flatten = ref$.flatten;
buildForce = function(){
  var f, build, i$;
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
          r = 2.5 * f.dtsr;
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
      "class": function(it){
        return it.name + " node";
      },
      "r": f.dtsr
    }).style({
      "fill": function(it){
        return it.color;
      }
    }).call(force.drag).on("mouseenter", function(it){
      return d3.selectAll(join(",", it.name.split(" ").map(function(it){
        return "." + it;
      }))).transition().duration(100).attr({
        "r": 10
      });
    }).on("mouseout", function(it){
      return d3.selectAll(join(",", it.name.split(" ").map(function(it){
        return "." + it;
      }))).transition().duration(10).attr({
        "r": 3
      });
    });
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
ifNaN = function(it){
  if (isNaN(it)) {
    return 0;
  } else {
    return it;
  }
};
go = function(){
  var col, dt, a;
  col = 7;
  dt = flatten(gnh.grpclr.clr_en.map(function(it, i){
    var r;
    r = it.value.map(function(c, j){
      var tmpc, attr;
      tmpc = {};
      for (attr in c) {
        tmpc[attr] = c[attr];
      }
      tmpc["target"] = {};
      tmpc["target"].x = (i % (col + 1) + 0.5) * (gnh.w / (col + 1));
      tmpc["target"].y = (~~(i / (col + 1)) + 0.5) * (gnh.w / (col + 1));
      return tmpc;
    });
    return r;
  }));
  a = buildForce().data(dt);
  return a();
};
move = function(){
  return svg.transition().duration(1000).attr({
    "transform": "translate(" + gnh.margin.left + "," + -1000 + ")"
  });
};