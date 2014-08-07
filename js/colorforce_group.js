var ref$, listsToObj, join, flatten, isType, take, buildForce, hightlightGroup, slideDown;
ref$ = require("prelude-ls"), listsToObj = ref$.listsToObj, join = ref$.join, flatten = ref$.flatten, isType = ref$.isType, take = ref$.take;
gnh.force = null;
buildForce = function(){
  var f, col, node, collide, build, i$;
  f = {};
  f.dtsr = 3;
  f.data = [];
  f.size = 800;
  f.grpnm = [];
  f.margin = 1.5;
  f.targetFunc = function(it){
    it.target = {};
    it.target.x = f.posX(it.grpidx);
    it.target.y = f.posY(it.grpidx);
    return true;
  };
  col = 9;
  f.posX = function(it){
    return (it % (col + 1) + 0.5) * (gnh.w / (col + 1));
  };
  f.posY = function(it){
    return (~~(it / (col + 1)) + 0.25) * (gnh.w / (col + 1));
  };
  f.selector = "cdots";
  node = [];
  function tick(it){
    var k, q, i, n;
    k = 1 * it.alpha;
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
        return ifNaN(it.x);
      },
      "cy": function(it){
        return ifNaN(it.y);
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
  build = function(){
    f.data = f.data.filter(f.targetFunc);
    gnh.force = d3.layout.force().nodes(f.data).links([]).gravity(0).charge(0).size([f.size, f.size]).on("tick", tick);
    node = svg.selectAll("." + f.selector).data(f.data).call(gnh.force.drag);
    svg.selectAll(".grp" + f.selector).data(take(100, f.grpnm)).enter().append("text").attr({
      "x": function(it, i){
        return f.posX(i);
      },
      "y": function(it, i){
        if (i <= col) {
          return f.posY(i) + 55;
        } else {
          return f.posY(i) + 40;
        }
      },
      "class": function(it){
        return "grp" + f.selector + " grp" + it;
      }
    }).style({
      "text-anchor": "middle"
    }).text(function(it){
      return it;
    });
    gnh.force.start();
    gnh.force.stop();
    return gnh.force.alpha(0.01);
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
hightlightGroup = function(name, selector){
  selector = selector || ".cdots";
  if (isType("String", name)) {
    d3.selectAll("." + selector + ":not(.prm" + name + "), .grp" + selector + ":not(.grp" + name + ")").transition().style({
      "opacity": 0.2
    });
    return d3.selectAll(".prm" + name + ", .grp" + name).transition().style({
      "opacity": 1
    });
  } else if (isType("Array", name)) {
    d3.selectAll(("." + selector + join("", name.map(function(it){
      return ":not(.prm" + it + ")";
    }))) + (",.grp" + selector + join("", name.map(function(it){
      return ":not(.grp" + it + ")";
    })))).transition().style({
      "opacity": 0.2
    });
    return d3.selectAll(join(",", name.map(function(it){
      return ".prm" + it;
    })) + ", " + join(",", name.map(function(it){
      return ".grp" + it;
    }))).transition().style({
      "opacity": 1
    });
  }
};
slideDown = function(){
  return svg.transition().duration(1000).attr({
    "transform": "translate(" + gnh.margin.left + "," + -1000 + ")"
  });
};