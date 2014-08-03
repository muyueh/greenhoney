var Str, addClass, addColor, enterStruct, exitStruct;
Str = require("prelude-ls").Str;
addClass = function(array, className, it){};
addColor = function(it){
  return "<div style='display:inline; background-color:" + gnh.lsclr[cleanName(it)] + ";' class=clrnmdots></div>";
};
enterStruct = function(){
  var lslsclrstruct, struct;
  lslsclrstruct = [
    ["Android green", "Apple green", "Army green"].map(function(it){
      return it + addColor(it);
    }), ["腥紅", "鮭紅", "暗鮭紅"].map(function(it){
      return it + addColor(it);
    })
  ];
  console.log(lslsclrstruct);
  struct = {};
  struct.fntsize = 50;
  struct.top = 100;
  struct.left = 100;
  d3.select(".svgholder").append("div").attr({
    "class": "clrstructholder"
  }).style({
    "position": "fixed",
    "top": "100px",
    "left": "100px"
  }).selectAll(".clrstruct").data(lslsclrstruct).enter().append("div").attr({
    "top": function(it, i){
      return i * 4 * struct.fntsize + "px";
    },
    "class": "clrstruct"
  }).selectAll("div").data(function(it){
    return it;
  }).enter().append("div").attr({
    "left": (gnh.w / 2 + struct.left) + "px",
    "top": function(it, i){
      return (100 + i * struct.fntsize) + struct.top + "px";
    }
  }).style({
    "font-size": struct.fntsize + "px",
    "text-align": "right"
  }).html(function(it){
    return it;
  });
  d3.selectAll(".rd").transition().duration(1200).style({
    "color": "rgb(201, 0, 0)"
  });
  return d3.selectAll(".gn").transition().duration(1200).style({
    "color": "green"
  });
};
exitStruct = function(){
  return d3.selectAll(".clrstructholder").remove();
};