var ref$, flatten, unique, sort, fntsize, lslsclrstruct, enterStruct, move, exitStruct;
ref$ = (typeof window !== "undefined" ? window.prelude : void 8) || {}, flatten = ref$.flatten, unique = ref$.unique, sort = ref$.sort;
fntsize = 35;
lslsclrstruct = [["Android", "green"], ["Apple", "green"], ["Army", "green"], ["腥", "紅"], ["鮭", "紅"], ["暗", "鮭", "紅"]];
enterStruct = function(){
  return svg.selectAll(".cStrucGroup").data(lslsclrstruct).enter().append("g").attr({
    "class": "cStrucGroup"
  }).selectAll(".cStruc").data(function(it){
    return it;
  }).enter().append("text").attr({
    "x": function(it, i){
      return it.length === 1
        ? i * fntsize
        : i * fntsize * it.length / 1.8;
    },
    "class": "cStruc"
  }).style({
    "font-size": fntsize,
    "text-anchor": "end"
  }).text(function(it){
    return it;
  });
};
move = function(){
  var flt;
  console.log(sort(
  unique(
  flatten(
  lslsclrstruct))));
  return flt = svg.selectAll(".cStruc").data(["green", "Android", "Apple", "Army", "紅", "鮭", "腥", "暗"]).transition().duration(1500).attr({
    "x": 300,
    "y": function(it, i){
      return i * fntsize * 1.1;
    }
  });
};
exitStruct = function(){};