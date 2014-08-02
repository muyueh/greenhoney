var enterStruct, exitStruct;
enterStruct = function(){
  var lslsclrstruct, struct;
  lslsclrstruct = [["Android <span class='gn'>green</span>", "Apple <span class='gn'>green</span>", "Army <span class='gn'>green</span>"], ["腥<span class='rd'>紅</span>", "鮭<span class='rd'>紅</span>", "暗鮭<span class='rd'>紅</span>"]];
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