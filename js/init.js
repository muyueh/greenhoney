var ref$, listsToObj, join, gnh, svg, cleanName, cleanPunc, ifNaN, clone, countColor, initBar, appendCircle;
ref$ = (typeof window !== "undefined" ? window.prelude : void 8) || {}, listsToObj = ref$.listsToObj, join = ref$.join;
gnh = {};
gnh.margin = {
  top: 10,
  left: 10,
  right: 20,
  bottom: 20
};
gnh.w = 1000 - gnh.margin.left - gnh.margin.right;
gnh.h = 850 - gnh.margin.top - gnh.margin.bottom;
gnh.lsfl = ["clr_en", "clr_ch"];
gnh.clr = {};
gnh.allclrls = {};
gnh.grpclr = {};
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
  return str.replace(/-/g, " ").replace(/\//g, " ").replace(/\(/g, "").replace(/\)/g, "").replace(/&/g, "").replace(/[1]/g, " ").replace(/  /g, " ").replace(/	 /g, " ").trim().toLowerCase();
};
ifNaN = function(it){
  if (isNaN(it)) {
    return 0;
  } else {
    return it;
  }
};
clone = function(obj){
  return JSON.parse(JSON.stringify(obj));
};
countColor = function(list, splitFunc){
  var freq, rslt, ttlidx;
  freq = {};
  list.filter(function(clr){
    clr.grp = splitFunc(clr.name);
    clr.grp.map(function(nmtoken){
      if (nmtoken === "色") {
        return;
      }
      if (freq[nmtoken] === undefined) {
        freq[nmtoken] = [];
      }
      return freq[nmtoken].push(clone(clr));
    });
    return true;
  });
  rslt = d3.entries(freq).sort(function(a, b){
    return b.value.length - a.value.length;
  });
  ttlidx = -1;
  list = flatten(rslt.map(function(grp, grpidx){
    return grp.value.map(function(clr, ingrpidx){
      var cclr;
      cclr = clr;
      cclr.grpidx = grpidx;
      cclr.ingrpidx = ingrpidx;
      cclr.ttlidx = ++ttlidx;
      cclr.primclr = grp.key;
      return cclr;
    });
  }));
  return {
    "clr": list,
    "grpclr": rslt
  };
};
initBar = function(){
  var delRule;
  delRule = [
    {
      name: "clr_en",
      del: " "
    }, {
      name: "clr_ch",
      del: ""
    }
  ];
  return delRule.map(function(fl){
    var rslt;
    rslt = countColor(gnh.clr[fl.name], function(it){
      return it.split(fl.del);
    });
    return ["grpclr", "clr"].map(function(attr){
      return gnh[attr][fl.name] = rslt[attr];
    });
  });
};
appendCircle = function(){
  var m, build, i$;
  m = {};
  m.selector = "cdots";
  m.data = [];
  m.updateModel = function(){};
  m.dtsr = 3;
  m.lightload = false;
  m.textload = false;
  m.textModel = function(){};
  build = function(){
    var c;
    if (m.lightload) {
      c = svg.selectAll("." + m.selector).data(m.data, function(it){
        return cleanName(it.color);
      });
    } else {
      c = svg.selectAll("." + m.selector).data(m.data);
    }
    c.transition().duration(1200).attr({
      "r": m.dtsr
    }).call(m.updateModel);
    c.enter().append("circle").attr({
      "fill": function(it, i){
        return it.color;
      },
      "class": function(it, i){
        return "calldots c" + cleanName(it.color) + " " + m.selector + " " + join(" cgr", it.grp) + " prm" + it.primclr;
      },
      "r": 0
    }).transition().duration(1200).attr({
      "r": m.dtsr
    }).call(m.updateModel);
    c.exit().transition().attr({
      "r": 0
    }).remove();
    if (m.textload) {
      return c.enter().append("text").attr({
        "class": "clrnm"
      }).style({
        "opacity": 0
      }).transition().style({
        "opacity": 1
      }).text(function(it){
        return it.name;
      }).call(m.textModel);
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