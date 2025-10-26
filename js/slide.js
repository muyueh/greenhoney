var sld, updtBlackIdxDots, slBk, slWiki, exitWiki, enter2upWiki, slChHSLFxS, slChHSLFxL, slEnHSLFxL, slEnHSLFxS, slChEnHSLFxs, slEnBar, slEnRect, slChForce, slHighChTop, slHighChAdj, slHighChObj, slHighChMis, slEnForce, slHighEnTop, slHighEnBase, slHighEnObj, slHighEnFlower, slHighEnAdj, slHighEnGeo, slHighEnIdea, exitForce, exitChForce, exitEnForce, exitslChEnHSLFxs, lsExplain, ticking, scrollingTo, scrolling, initiateData, setupslide;
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
slBk = function(){
  return console.log("do nothing");
};
slWiki = function(){
  return appendCircle().textload(true).data(gnh.clr["clr_ch"]).updateModel(buildList()).textModel(buildList().type("text"))();
};
exitWiki = function(){
  return d3.selectAll(".clrnm").transition().style({
    "opacity": 0
  });
};
enter2upWiki = function(){
  return d3.selectAll(".clrnm").transition().style({
    "opacity": 0.3
  });
};
slChHSLFxS = function(){
  return appendCircle().data(gnh.clr["clr_ch"]).updateModel(buildPallete())();
};
slChHSLFxL = function(){
  return appendCircle().lightload(true).data(gnh.clr["clr_ch"]).updateModel(buildPallete().mdlfx("l"))();
};
slEnHSLFxL = function(){
  return appendCircle().lightload(true).data(gnh.clr["clr_en"]).updateModel(buildPallete().mdlfx("l"))();
};
slEnHSLFxS = function(){
  return appendCircle().lightload(true).data(gnh.clr["clr_en"]).updateModel(buildPallete().mdlfx("s"))();
};
slChEnHSLFxs = function(){
  appendCircle().lightload(true).data(gnh.clr["clr_en"]).updateModel(buildPallete().mdlfx("s").cr(100).cx(120))();
  appendCircle().lightload(true).data(gnh.clr["clr_en"]).selector("encdatas").updateModel(buildPallete().mdlfx("l").cr(100).cx(120).cy(460))();
  appendCircle().lightload(true).data(gnh.clr["clr_ch"]).selector("chcdatas").updateModel(buildPallete().mdlfx("s").cr(100).cx(360))();
  appendCircle().lightload(true).data(gnh.clr["clr_ch"]).selector("chcdatal").updateModel(buildPallete().mdlfx("l").cr(100).cx(360).cy(460))();
  return svg.selectAll(".clrtitle").data(["English", "Chinese"]).enter().append("text").attr({
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
exitForce = function(it){
  gnh.force.stop();
  d3.selectAll(".grp" + it).transition().style({
    "opacity": 0
  }).remove();
  return d3.selectAll("." + it).remove();
};
exitChForce = function(){
  return exitForce("chforce");
};
exitEnForce = function(){
  return exitForce("enforce");
};
exitslChEnHSLFxs = function(){
  d3.selectAll(".calldots").transition().duration(1000).attr({
    "r": 0
  }).remove();
  return svg.selectAll(".clrtitle").remove();
};
lsExplain = [
  {
    "exit2up": function(){},
    "exit2down": exitWiki,
    "exit": function(){},
    "enter2up": enter2upWiki,
    "enter2down": slBk,
    "enter": slWiki,
    "text": "Language represents our view of the world, and knowing its limits helps us understand how our perception works.</br></br>I used the data from Wikipedia’s “Color” entry for different languages. My assumption was: </br></br>\"Different languages have different ways to describe color.”</br></br><strong>(Scroll Down to Start)</strong>"
  }, {
    "exit2up": function(){},
    "exit2down": function(){},
    "exit": function(){},
    "enter2up": slBk,
    "enter2down": slBk,
    "enter": slChHSLFxS,
    "text": "The Chinese entry has 250+ different colors. </br></br> The Hue-Saturation-Lightness (HSL) model is a 3D model that can be projected on a 2D space. </br></br> Using Hue as an angle, we can set either Saturation as the radius . . ."
  }, {
    "exit2up": function(){},
    "exit2down": function(){},
    "exit": function(){},
    "enter2up": slBk,
    "enter2down": slBk,
    "enter": slChHSLFxL,
    "text": "or Lightness as the radius."
  }, {
    "exit2up": function(){},
    "exit2down": function(){},
    "exit": function(){},
    "enter2up": slBk,
    "enter2down": slBk,
    "enter": slEnHSLFxL,
    "text": "Here is the English Dataset, keeping Lightness as a constant . . . "
  }, {
    "exit2up": function(){},
    "exit2down": function(){},
    "exit": function(){},
    "enter2up": slBk,
    "enter2down": slBk,
    "enter": slEnHSLFxS,
    "text": "or keeping Saturation as the constant."
  }, {
    "exit2up": function(){},
    "exit2down": function(){},
    "exit": exitslChEnHSLFxs,
    "enter2up": slBk,
    "enter2down": slBk,
    "enter": slChEnHSLFxs,
    "text": "Comparing the two datasets, you can see that English has a richer entry for color names."
  }, {
    "exit2up": exitChForce,
    "exit2down": function(){},
    "exit": function(){},
    "enter2up": slBk,
    "enter2down": slChForce,
    "enter": slBk,
    "text": "However, it's always worth asking: Is this the best model to represent our dataset?</br></br>Notice that the Chinese and English names for colors share a common structure of \"noun/adj + base color\": <ul><li>腥<span class='rd'>紅</span></li><li>鮭<span class='rd'>紅</span></li><li>暗鮭<span class='rd'>紅</span></li></ul> </br><ul><li>Android <span class='gn'>green</span></li><li>Apple <span class='gn'>green</span></li><li>Army <span class='gn'>green</span></li></ul></br>A better visualization will be to split the name of the color, word by word."
  }, {
    "exit2up": function(){},
    "exit2down": function(){},
    "exit": function(){},
    "enter2up": slBk,
    "enter2down": slBk,
    "enter": slHighChTop,
    "text": "Now we can see that in Chinese, the most popular base color is 紅 (red), followed by 藍 (blue), and 綠 (green)."
  }, {
    "exit2up": function(){},
    "exit2down": function(){},
    "exit": function(){},
    "enter2up": slBk,
    "enter2down": slBk,
    "enter": slHighChAdj,
    "text": "There are frequently used words, such as 暗 (dark) and 亮 (light), which are not base colors but rather adjectives for a color."
  }, {
    "exit2up": function(){},
    "exit2down": function(){},
    "exit": function(){},
    "enter2up": slBk,
    "enter2down": slBk,
    "enter": slHighChObj,
    "text": "There are also objects, such as 鮭 (salmon), 石 (stone), 松 (pine tree), where there is a name of an object."
  }, {
    "exit2up": function(){},
    "exit2down": exitChForce,
    "exit": function(){},
    "enter2up": slChForce,
    "enter2down": slBk,
    "enter": slHighChMis,
    "text": "This visualization also solves a longtime problem: In Chinese, we have this mysterious color called 青 but no one really knows what it represents. </br></br> Here are all the colors with 青 in their names."
  }, {
    "exit2up": exitEnForce,
    "exit2down": function(){},
    "exit": function(){},
    "enter2up": slBk,
    "enter2down": slEnForce,
    "enter": slBk,
    "text": "Now let's see English. Remember that in Chinese, the top three colors are Red, Blue, and Green."
  }, {
    "exit2up": function(){},
    "exit2down": function(){},
    "exit": function(){},
    "enter2up": slBk,
    "enter2down": slBk,
    "enter": slHighEnTop,
    "text": "In English, the top three colors are Blue, Green, and Pink."
  }, {
    "exit2up": function(){},
    "exit2down": function(){},
    "exit": function(){},
    "enter2up": slBk,
    "enter2down": slBk,
    "enter": slHighEnBase,
    "text": "You can also see the same characteristics of using a base color:"
  }, {
    "exit2up": function(){},
    "exit2down": function(){},
    "exit": function(){},
    "enter2up": slBk,
    "enter2down": slBk,
    "enter": slHighEnObj,
    "text": "association from object . . . "
  }, {
    "exit2up": function(){},
    "exit2down": function(){},
    "exit": function(){},
    "enter2up": slBk,
    "enter2down": slBk,
    "enter": slHighEnFlower,
    "text": "from flowers and fruits . . . "
  }, {
    "exit2up": function(){},
    "exit2down": function(){},
    "exit": function(){},
    "enter2up": slBk,
    "enter2down": slBk,
    "enter": slHighEnAdj,
    "text": "and with adjectives."
  }, {
    "exit2up": function(){},
    "exit2down": function(){},
    "exit": function(){},
    "enter2up": slBk,
    "enter2down": slBk,
    "enter": slHighEnGeo,
    "text": "But some interesting naming conventions in English use geolocation "
  }, {
    "exit2up": function(){},
    "exit2down": function(){},
    "exit": function(){},
    "enter2up": slBk,
    "enter2down": slBk,
    "enter": slHighEnIdea,
    "text": "and concepts."
  }, {
    "exit2up": function(){},
    "exit2down": function(){},
    "exit": function(){},
    "enter2up": slBk,
    "enter2down": slBk,
    "enter": slBk,
    "text": "This process represents some concepts that I believe are true in visualization: Keep testing different models and learn something new from your dataset. </br></br>  There is a way of thinking that treats visualization as a magical process that prettifies the output, yet the only way we can make a meaningful graph is when we discover something meaningful during our research.</br></br>  People are relying on us to see the world. Out of everyone, we are the ones who need to have these interesting tests / models / questions / hypotheses at hand because if we don't know the color “red,” our story will never have “red” in it. </br></br></br>By Muyueh Lee @muyueh, </br>adapted from his talk \"Green Honey\" @#OpenDataWorkshop2013."
  }
];
ticking = function(i){
  var d;
  if (i !== sld.hghidx) {
    d = sld.hghidx < i ? "d" : "u";
    if (sld.hghidx !== -1) {
      if (d === "d") {
        lsExplain[sld.hghidx].exit2down();
      } else {
        lsExplain[sld.hghidx].exit2up();
      }
      lsExplain[sld.hghidx].exit();
    }
    sld.hghidx = i;
    updtBlackIdxDots();
    if (d === "d") {
      lsExplain[sld.hghidx].enter2down();
    } else {
      lsExplain[sld.hghidx].enter2up();
    }
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
setupslide = function(){
  initBar();
  initiateData();
  scrolling();
  return $(window).scroll(function(){
    return scrolling();
  });
};
(function(){
  var wait;
  wait = gnh.lsfl.length;
  return gnh.lsfl.map(function(it){
    return d3.tsv("./data/" + it + ".tsv", function(err, colorTSV){
      if (colorTSV[0].name !== undefined) {
        colorTSV = colorTSV.filter(function(it){
          gnh.allclrls[cleanName(it.name)] = it.color;
          it.name = cleanPunc(it.name);
          return true;
        });
      }
      gnh.clr[it] = colorTSV;
      if (--wait === 0) {
        return setupslide();
      }
    });
  });
})();