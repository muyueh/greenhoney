var listsToObj, gnh, svg, cleanName, cleanPunc, buildModel, builPalette;
listsToObj = require("prelude-ls").listsToObj;
gnh = {};
gnh.margin = {
  top: 10,
  left: 10,
  right: 20,
  bottom: 20
};
gnh.w = 1000 - gnh.margin.left - gnh.margin.right;
gnh.h = 800 - gnh.margin.top - gnh.margin.bottom;
gnh.lsfl = ["clr_en", "clr_ch", "clr_fr", "bat_1", "bat_2", "bat_3"];
gnh.cdata = {};
gnh.lsclr = {};
gnh.barclr = {};
svg = d3.select("body").select(".svgholder").append("svg").attr({
  "width": gnh.w + gnh.margin.left + gnh.margin.right,
  "height": gnh.h + gnh.margin.top + gnh.margin.bottom
}).append("g").attr({
  "transform": "translate(" + gnh.margin.left + "," + gnh.margin.right + ")"
});
cleanName = function(str){
  return str.replace(/,/g, "").replace(/"/g, "").replace(/\./g, "").replace(/'/g, "").replace(/-/g, "").replace(/ /g, "").toLowerCase();
};
cleanPunc = function(str){
  return str.replace(/-/g, " ").replace(/\//g, " ").replace(/\(/g, "").replace(/\)/g, "").replace(/[1]/g, " ").toLowerCase();
};
buildModel = function(){
  var m, build;
  m = {};
  m.cx = 250;
  m.cy = 250;
  m.cr = 250;
  m.mdl = function(it){
    return d3.hsl(it);
  };
  m.mdlfx = "s";
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
  ["cx", "cy", "cr", "mdl", "mdlfx"].map(function(it){
    return build[it] = function(v){
      m[it] = v;
      return build;
    };
  });
  return build;
};
builPalette = function(){
  var p, build;
  p = {};
  p.selector = "cdots";
  p.data = [];
  p.updateModel = function(){};
  p.dtsr = 3;
  build = function(){
    var c;
    c = svg.selectAll("." + p.selector).data(p.data, function(it){
      return cleanName(it.color);
    });
    c.transition().duration(1200).call(p.updateModel);
    c.enter().append("circle").attr({
      "fill": function(it, i){
        return it.color;
      },
      "class": function(it, i){
        return "calldots c" + cleanName(it.color) + " " + p.selector;
      },
      "r": 0
    }).transition().duration(1200).attr({
      "r": p.dtsr
    }).call(p.updateModel);
    return c.exit().transition().attr({
      "r": 0
    }).remove();
  };
  ["selector", "data", "updateModel", "dtsr"].map(function(it){
    return build[it] = function(v){
      p[it] = v;
      return build;
    };
  });
  return build;
};
(function(){
  var wait;
  wait = gnh.lsfl.length;
  return gnh.lsfl.map(function(it){
    return d3.tsv("./data/" + it + ".tsv", function(err, colorTSV){
      if (colorTSV[0].name !== undefined) {
        colorTSV = colorTSV.filter(function(it){
          gnh.lsclr[cleanName(it.name)] = it.color;
          it.name = cleanPunc(it.name);
          return true;
        });
      }
      gnh.cdata[it] = colorTSV;
      if (--wait === 0) {
        return setupslide();
      }
    });
  });
})();