var sld, updtBlackIdxDots, slBlank, slChHSLFxS, slChHSLFxL, slEnHSLFxL, slEnHSLFxS, slChEnHSLFxs, slBatHSLFxs, exitslChEnHSLFxs, lsExplain, ticking, scrollingTo, scrolling, initiateData, setupslide;
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
  return builPalette().data(gnh.cdata["clr_ch"]).updateModel(buildModel())();
};
slChHSLFxL = function(){
  return builPalette().data(gnh.cdata["clr_ch"]).updateModel(buildModel().mdlfx("l"))();
};
slEnHSLFxL = function(){
  return builPalette().data(gnh.cdata["clr_en"]).updateModel(buildModel().mdlfx("l"))();
};
slEnHSLFxS = function(){
  return builPalette().data(gnh.cdata["clr_en"]).updateModel(buildModel().mdlfx("s"))();
};
slChEnHSLFxs = function(){
  builPalette().data(gnh.cdata["clr_en"]).updateModel(buildModel().mdlfx("s").cr(100).cx(120))();
  builPalette().data(gnh.cdata["clr_en"]).selector("encdatas").updateModel(buildModel().mdlfx("l").cr(100).cx(120).cy(460))();
  builPalette().data(gnh.cdata["clr_ch"]).selector("chcdatas").updateModel(buildModel().mdlfx("s").cr(100).cx(360))();
  return builPalette().data(gnh.cdata["clr_ch"]).selector("chcdatal").updateModel(buildModel().mdlfx("l").cr(100).cx(360).cy(460))();
};
slBatHSLFxs = function(){
  builPalette().data(gnh.cdata["bat_1"]).selector("bat_1").dtsr(1).updateModel(buildModel().mdlfx("l").cr(80).cx(100))();
  builPalette().data(gnh.cdata["bat_2"]).selector("bat_2").dtsr(1).updateModel(buildModel().mdlfx("l").cr(80).cx(300))();
  return builPalette().data(gnh.cdata["bat_3"]).selector("bat_3").dtsr(1).updateModel(buildModel().mdlfx("l").cr(80).cx(500))();
};
exitslChEnHSLFxs = function(){
  return d3.selectAll(".calldots").transition().duration(1000).attr({
    "r": 0
  }).remove();
};
lsExplain = [
  {
    "exit": function(){},
    "enter": slBlank,
    "text": "Language represents our model of the world, knowing its limit helps us understand how our perception work."
  }, {
    "exit": function(){},
    "enter": slBlank,
    "text": "I use the data from wikipedia color entry for different language. My assumption was: \"Different language has different interest for color.\" "
  }, {
    "exit": function(){},
    "enter": slChHSLFxS,
    "text": "The Chinese entry has 250+ different color. </br></br> The Hue-Saturation-Lightness (HSL) model is a 3D model that needs to be projected on a 2D space. </br></br> Using Hue as angle, we can either set Saturation to the radius, "
  }, {
    "exit": function(){},
    "enter": slChHSLFxL,
    "text": "or Lightness as the radius."
  }, {
    "exit": function(){},
    "enter": slBlank,
    "text": "You can notice that there are many white spaces, we usually use the adjacent name for these colors."
  }, {
    "exit": function(){},
    "enter": slEnHSLFxL,
    "text": "Here is the English Dataset (Keeping Lightness as constant)."
  }, {
    "exit": function(){},
    "enter": slEnHSLFxS,
    "text": "(Keeping Saturation as constant)."
  }, {
    "exit": exitslChEnHSLFxs,
    "enter": slChEnHSLFxs,
    "text": "Comparing the two dataset, you can see that English has a richer entry of color names."
  }, {
    "exit": exitslChEnHSLFxs,
    "enter": slBatHSLFxs,
    "text": "Using this model, we can also analysis different dataset, such as the color patern in the Batman triology. (Data Coustesy of )"
  }, {
    "exit": function(){},
    "enter": slChHSLFxS,
    "text": "A better visualization will be to split the name of the color, words by words. "
  }, {
    "exit": function(){},
    "enter": slBlank,
    "text": "Now we can see that in Chinese, the most popular base color is 紅 (red), following by 藍 (blue), and 綠 (green)."
  }, {
    "exit": function(){},
    "enter": slBlank,
    "text": "There are frequent used word such as 暗 (dark) and 亮 (light), that is not a base color, but an adjective. "
  }, {
    "exit": function(){},
    "enter": slBlank,
    "text": "We also have object such as 鮭 (summon), 石 (stone), 松 (spine tree), where we have name of object."
  }, {
    "exit": function(){},
    "enter": slBlank,
    "text": "This visualization also solve a long-time problem, because in Chinese, we have this mysterious color called 青, that no ones really know what it represents. </br></br> Here are all the color with 青 in it."
  }, {
    "exit": function(){},
    "enter": slBlank,
    "text": "How let's see English. Remember that in Chinese the top three color is Red-Blue-Green.</br></br> In English, the top three colors are Blue, Green, Pink and Red."
  }, {
    "exit": function(){},
    "enter": slBlank,
    "text": "You can also notice the same attribute of using object name and adjective."
  }, {
    "exit": function(){},
    "enter": slBlank,
    "text": "But one interesting naming convention in English, is that we use location name, such as French, Persian, Turkish and English. "
  }, {
    "exit": function(){},
    "enter": slBlank,
    "text": "This process really represents some main ideas I have on visualization: the process of building visualization is to keep testing different model on our dataset, different models reveals the different part of this dataset."
  }, {
    "exit": function(){},
    "enter": slBlank,
    "text": "Most importantly, this process makes you understand your data. There is a thinking that goes like this: we can throw some conclusions to our designers, and they will be able to prettify the output. </br></br> However, the only way you can tell interesting story, it's when you really know your data, learn something new from it, and share then you can share it with others."
  }
];
ticking = function(i){
  if (i !== sld.hghidx) {
    if (lsExplain[sld.hghidx] !== undefined) {
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
  txt.append("h4").attr({
    "class": "description"
  }).style({
    "text-shadow": "2px 2px 1px white"
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