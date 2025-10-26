var flatten, countColor, b, initBar, barXY, rectXY, buildBar, toCircle, toBar, toRect, sortRect;
flatten = ((typeof window !== "undefined" ? window.prelude : void 8) || {}).flatten;
countColor = function(list, splitFunc){
  var freq;
  freq = {};
  list.map(function(it){
    return splitFunc(it.name).map(function(nmtoken){
      if (freq[nmtoken] === undefined) {
        freq[nmtoken] = [];
      }
      return freq[nmtoken].push(it);
    });
  });
  return d3.entries(freq).sort(function(a, b){
    return b.value.length - a.value.length;
  });
};
b = {};
b.data = gnh.barclr["clr_en"];
b.selector = "encdatas";
b.dtsr = 3;
initBar = function(){
  var lsNmToken;
  lsNmToken = [
    {
      name: "clr_en",
      del: " "
    }, {
      name: "clr_ch",
      del: ""
    }, {
      name: "clr_fr",
      del: " "
    }
  ];
  lsNmToken.map(function(clr){
    return gnh.barclr[clr.name] = countColor(gnh.cdata[clr.name], function(it){
      return it.split(clr.del);
    });
  });
  return b.data = gnh.barclr["clr_en"];
};
barXY = function(it){
  return it.attr({
    "cx": function(it, i){
      return it.barx;
    },
    "cy": function(it, i){
      return it.bary;
    }
  });
};
rectXY = function(it){
  var rw;
  rw = 25;
  return it.attr({
    "cx": function(it, i){
      return ~~(i % rw) * 2 * (b.dtsr + 1);
    },
    "cy": function(it, i){
      return ~~(i / rw) * 2 * (b.dtsr + 1);
    }
  });
};
buildBar = function(){
  var data;
  data = b.data.map(function(n, i){
    return n.value.map(function(c, j){
      return {
        "barx": j * 2 * (b.dtsr + 1),
        "bary": i * 2 * (b.dtsr + 1),
        "nm": c.name,
        "color": c.color
      };
    });
  });
  console.log(JSON.stringify(flatten(data)));
  return svg.selectAll("." + b.selector).data(flatten(data)).enter().append("circle").attr({
    "r": b.dtsr,
    "class": b.selector
  }).style({
    "fill": function(it){
      return it.color;
    }
  }).call(barXY);
};
toCircle = function(){
  return svg.selectAll("." + b.selector).transition().delay(function(it, i){
    return i * 1;
  }).call(buildModel());
};
toBar = function(){
  return svg.selectAll("." + b.selector).transition().delay(function(it, i){
    return i * 1;
  }).call(barXY);
};
toRect = function(){
  return svg.selectAll("." + b.selector).transition().duration(1200).call(rectXY);
};
sortRect = function(){
  return svg.selectAll("." + b.selector).sort(function(a, b){
    return d3.hsl(a.color).l - d3.hsl(b.color).l;
  }).transition().duration(1200).call(rectXY);
};