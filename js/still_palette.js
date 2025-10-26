var listsToObj, ggl, svg, cleanName, changeColor, changeColor2, updateModel, updateColor;
listsToObj = ((typeof window !== "undefined" ? window.prelude : void 8) || {}).listsToObj;
ggl = {};
ggl.margin = {
  top: 10,
  left: 10,
  right: 20,
  bottom: 20
};
ggl.w = 600 - ggl.margin.left - ggl.margin.right;
ggl.h = 600 - ggl.margin.top - ggl.margin.bottom;
ggl.r = 3;
ggl.cx = 200;
ggl.cy = 200;
ggl.cr = 200;
ggl.cmdl = function(it){
  return d3.hsl(it);
};
ggl.cmdlfix = "s";
ggl.clrfl = "en";
ggl.cdata = {};
svg = d3.select("body").append("svg").attr({
  "width": ggl.w + ggl.margin.left + ggl.margin.right,
  "height": ggl.h + ggl.margin.top + ggl.margin.bottom
}).append("g").attr({
  "transform": "translate(" + ggl.margin.left + "," + ggl.margin.right + ")"
});
cleanName = function(str){
  return str.replace(/,/g, "").replace(/"/g, "").replace(/\./g, "").replace(/'/g, "").replace(/-/g, "").toLowerCase();
};
changeColor = function(){
  ggl.cmdlfix = "l";
  return svg.selectAll(".cdots").transition().duration(1500).call(updateModel);
};
changeColor2 = function(){
  ggl.clrfl = "ch";
  updateColor();
  return svg.selectAll(".cdots").transition().duration(1500).call(updateModel);
};
updateModel = function(it){
  return it.each(function(it){
    var clr, attr;
    clr = ggl.cmdl(it.color);
    for (attr in clr) {
      if (isNaN(clr[attr])) {
        clr[attr] = 0;
      }
    }
    it.x = ggl.cx + Math.cos(clr.h * Math.PI / 180) * ggl.cr * clr[ggl.cmdlfix];
    return it.y = ggl.cy + Math.sin(clr.h * Math.PI / 180) * ggl.cr * clr[ggl.cmdlfix];
  }).attr({
    "cx": function(it, i){
      return it.x;
    },
    "cy": function(it, i){
      return it.y;
    }
  });
};
updateColor = function(){
  var c;
  c = svg.selectAll(".cdots").data(ggl.cdata[ggl.clrfl]);
  c.enter().append("circle").attr({
    "fill": function(it, i){
      return it.color;
    },
    "class": function(it, i){
      return "cdots c" + cleanName(it.color);
    },
    "r": function(){
      return ggl.r;
    }
  }).call(updateModel);
  c.transition().call(updateModel);
  return c.exit().remove();
};
["en", "ch"].map(function(it){
  return d3.tsv("./data/colorname_" + it + ".tsv", function(err, colorTSV){
    return ggl.cdata[it] = colorTSV;
  });
});