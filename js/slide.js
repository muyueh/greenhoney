var sld, updtBlackIdxDots, slBlank, slChHSLFxS, slChHSLFxL, slEnHSLFxL, slEnHSLFxS, slChEnHSLFxs, slBatHSLFxs, slEnBar, slEnRect, slChForce, slHighChTop, slHighChAdj, slHighChObj, slHighChMis, slEnForce, slHighEnTop, slHighEnBase, slHighEnObj, slHighEnFlower, slHighEnAdj, slHighEnGeo, slHighEnIdea, exitChForce, exitslChEnHSLFxs, lsExplain, ticking, scrollingTo, scrolling, initiateData;
sld = {};
sld.screenh = $(window).height();
sld.hghidx = -1;
updtBlackIdxDots = function(){
  return d3.selectAll(".idx").style({
    "background-color": function(it, i){
      if (i === sld.hghidx) {
        return "black";
      } else {
        return "white";
      }
    }
  });
};
slBlank = function(){
  return console.log("do nothing");
};
slChHSLFxS = function(){
  return appendCircle().data(gnh.clr["clr_ch"]).updateModel(buildPallete())();
};
slChHSLFxL = function(){
  return appendCircle().data(gnh.clr["clr_ch"]).updateModel(buildPallete().mdlfx("l"))();
};
slEnHSLFxL = function(){
  return appendCircle().data(gnh.clr["clr_en"]).updateModel(buildPallete().mdlfx("l"))();
};
slEnHSLFxS = function(){
  return appendCircle().data(gnh.clr["clr_en"]).updateModel(buildPallete().mdlfx("s"))();
};
slChEnHSLFxs = function(){
  appendCircle().data(gnh.clr["clr_en"]).updateModel(buildPallete().mdlfx("s").cr(100).cx(120))();
  appendCircle().lightload(true).data(gnh.clr["clr_en"]).selector("encdatas").updateModel(buildPallete().mdlfx("l").cr(100).cx(120).cy(460))();
  appendCircle().lightload(true).data(gnh.clr["clr_ch"]).selector("chcdatas").updateModel(buildPallete().mdlfx("s").cr(100).cx(360))();
  appendCircle().lightload(true).data(gnh.clr["clr_ch"]).selector("chcdatal").updateModel(buildPallete().mdlfx("l").cr(100).cx(360).cy(460))();
  return svg.selectAll("text").data(["English", "Chinese"]).enter().append("text").attr({
    "y": 370,
    "x": function(it, i){
      if (i === 0) {
        return 100;
      } else {
        return 330;
      }
    },
    "class": "clrtitle"
  }).text(function(it){
    return it;
  });
};
slBatHSLFxs = function(){
  appendCircle().data(gnh.clr["bat_1"]).selector("bat_1").dtsr(1).updateModel(buildPallete().mdlfx("l").cr(80).cx(100))();
  appendCircle().data(gnh.clr["bat_2"]).selector("bat_2").dtsr(1).updateModel(buildPallete().mdlfx("l").cr(80).cx(300))();
  return appendCircle().data(gnh.clr["bat_3"]).selector("bat_3").dtsr(1).updateModel(buildPallete().mdlfx("l").cr(80).cx(500))();
};
slEnBar = function(){
  return appendCircle().data(gnh.clr["clr_en"]).updateModel(buildBar())();
};
slEnRect = function(){
  return appendCircle().data(gnh.clr["clr_en"]).updateModel(buildRect())();
};
slChForce = function(){
  return appendCircle().data(gnh.clr["clr_ch"]).selector("chforce").updateModel(buildForce().selector("chforce").data(gnh.clr["clr_ch"]).grpnm(gnh.grpclr["clr_ch"].map(function(it){
    return it.key;
  })))();
};
slHighChTop = function(){
  return hightlightGroup(["紅", "藍", "綠"], "chforce");
};
slHighChAdj = function(){
  return hightlightGroup(["暗", "亮"], "chforce");
};
slHighChObj = function(){
  return hightlightGroup(["鮭", "石", "松"], "chforce");
};
slHighChMis = function(){
  return hightlightGroup(["青"], "chforce");
};
slEnForce = function(){
  return appendCircle().data(gnh.clr["clr_en"]).selector("enforce").updateModel(buildForce().selector("enforce").data(gnh.clr["clr_en"]).grpnm(gnh.grpclr["clr_en"].map(function(it){
    return it.key;
  })))();
};
slHighEnTop = function(){
  return hightlightGroup(["blue", "green", "pink"], "enforce");
};
slHighEnBase = function(){
  return hightlightGroup(["blue", "green", "pink", "red", "yellow", "orange", "magenta", "purple", "gray", "black", "white", "cerulean", "maroon", "khaki", "cyan"], "enforce");
};
slHighEnObj = function(){
  return hightlightGroup(["cooper", "candy", "sky", "taupe", "carmine", "gold", "crimson", "crayola", "silver", "turquoise", "liver", "slate", "royal", "ruby", "puce", "coral", "sea", "salmon"], "enforce");
};
slHighEnFlower = function(){
  return hightlightGroup(["rose", "lavender", "violet", "fuchsia", "orchid", "indigo", "lime", "lemon", "raspberry", "peach", "mauve", "apple", "tangerine", "olive", "moss", "cerise", "lilac", "chestnut", "bud"], "enforce");
};
slHighEnAdj = function(){
  return hightlightGroup(["dark", "light", "deep", "medium", "pale", "rich", "bright", "old", "rich", "grey", "vivid", "golden", "antique"], "enforce");
};
slHighEnGeo = function(){
  return hightlightGroup(["french", "spanish", "persian", "tuscan", "english"], "enforce");
};
slHighEnIdea = function(){
  return hightlightGroup(["electric", "x", "mensell", "pastel", "html", "web", "pantone", "ryb"], "enforce");
};
exitChForce = function(){
  gnh.force.stop();
  d3.selectAll(".grpchforce").transition().style({
    "opacity": 0
  }).remove();
  return d3.selectAll(".chforce").remove();
};
exitslChEnHSLFxs = function(){
  d3.selectAll(".calldots").transition().duration(1000).attr({
    "r": 0
  }).remove();
  return svg.selectAll(".clrtitle").remove();
};
lsExplain = [
  {
    "exit": function(){},
    "enter": slBlank,
    "text": "Language represents our model of the world, knowing its limit helps us understand how our perception work.</br></br>I use the data from wikipedia color entry for different language. My assumption was: </br></br>\"Different language has different way to describ color.\" "
  }, {
    "exit": function(){},
    "enter": slChHSLFxS,
    "text": "The Chinese entry has 250+ different color. </br></br> The Hue-Saturation-Lightness (HSL) model is a 3D model that can be projected on a 2D space. </br></br> Using Hue as angle, we can either set Saturation to the radius, "
  }, {
    "exit": function(){},
    "enter": slChHSLFxL,
    "text": "or Lightness as the radius."
  }, {
    "exit": function(){},
    "enter": slEnHSLFxL,
    "text": "Here is the English Dataset, keeping Lightness as constant. "
  }, {
    "exit": function(){},
    "enter": slEnHSLFxS,
    "text": "Keeping Saturation as constant."
  }, {
    "exit": exitslChEnHSLFxs,
    "enter": slChEnHSLFxs,
    "text": "Comparing the two dataset, you can see that English has a richer entry of color names."
  }, {
    "exit": function(){},
    "enter": slChForce,
    "text": "A better visualization will be to split the name of the color, words by words. "
  }, {
    "exit": function(){},
    "enter": slHighChTop,
    "text": "Now we can see that in Chinese, the most popular base color is 紅 (red), following by 藍 (blue), and 綠 (green)."
  }, {
    "exit": function(){},
    "enter": slHighChAdj,
    "text": "There are frequent used word such as 暗 (dark) and 亮 (light), that is not a base color, but an adjective for color. "
  }, {
    "exit": function(){},
    "enter": slHighChObj,
    "text": "We also have object such as 鮭 (summon), 石 (stone), 松 (spine tree), where we have name of object."
  }, {
    "exit": exitChForce,
    "enter": slHighChMis,
    "text": "This visualization also solve a long-time problem, because in Chinese, we have this mysterious color called 青, that no ones really know what it represents. </br></br> Here are all the color with 青 in it."
  }, {
    "exit": function(){},
    "enter": slEnForce,
    "text": "Now let's see English. Remember that in Chinese the top three color is Red-Blue-Green."
  }, {
    "exit": function(){},
    "enter": slHighEnTop,
    "text": "In English, the top three colors are Blue, Green and  Pink."
  }, {
    "exit": function(){},
    "enter": slHighEnBase,
    "text": "You can also notice the same characteritics of using base color, "
  }, {
    "exit": function(){},
    "enter": slHighEnObj,
    "text": "association from object"
  }, {
    "exit": function(){},
    "enter": slHighEnFlower,
    "text": "from flowers and fruits"
  }, {
    "exit": function(){},
    "enter": slHighEnAdj,
    "text": "and with adjective."
  }, {
    "exit": function(){},
    "enter": slHighEnGeo,
    "text": "But some interesting naming convention in English, is using geolocation, "
  }, {
    "exit": function(){},
    "enter": slHighEnIdea,
    "text": "and concept. "
  }, {
    "exit": function(){},
    "enter": slBlank,
    "text": "This process represents some concepts that I believe in visualization: keep testing different model, and learn something new on your dataset. </br></br> There is a thinking that treats visualization as a magical process that prettifies the output. Yet the only way we can make meaningfull graph is when we discover something meaningfull during our research.</br></br> People are relying on us to see the world. Out of everyone, we are the one who needs to have these interesting tests/ models/ questions/ hypothesis at hands, because if we don't know the color 'red', our story will never have'red' in it. </br></br></br>By Muyueh Lee, </br>adapted from his talk \"Green Honey\" @#OpenDataWorkshop2013."
  }
];
ticking = function(i){
  if (i !== sld.hghidx) {
    if (sld.hghidx !== -1) {
      lsExplain[sld.hghidx].exit();
    }
    sld.hghidx = i;
    updtBlackIdxDots();
    return lsExplain[sld.hghidx].enter();
  }
};
scrollingTo = function(i){
  return $("body").scrollTop($(sld.dscrpts[i]).position().top);
};
scrolling = function(){
  return sld.dscrpts.map(function(it, i){
    var b, m, lm;
    b = it.getBoundingClientRect();
    m = b.top;
    lm = sld.screenh / 2;
    return d3.select(it).style("opacity", function(){
      if (m < lm) {
        if (m > 0) {
          ticking(i);
        }
        return m / 100;
      } else {
        return 1;
      }
    });
  });
};
initiateData = function(){
  var txt;
  txt = d3.selectAll(".txtholder").selectAll(".description").data(lsExplain).enter();
  txt.append("div").attr({
    "class": "description"
  }).append("h4").attr({
    "class": "descriptionH4"
  }).html(function(it){
    return it.text;
  });
  d3.selectAll(".idxholder").selectAll(".idx").data(lsExplain).enter().append("div").attr({
    "class": "idx"
  }).style({
    "cursor": "pointer"
  }).on("mousedown", function(d, i){
    return scrollingTo(i);
  });
  return sld.dscrpts = [].slice.call(document.getElementsByClassName("description"));
};