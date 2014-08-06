# Idea spereration of concern; build this as a function; and feeed data inside; now we are still relying on global var to send data.

# munsell color system
sld = {}
sld.screenh = $ window .height!
sld.hghidx = -1

updtBlackIdxDots = ->	
	d3.selectAll ".idx"
		.style {
			"background-color": (it, i)-> if i is sld.hghidx then "black" else "white"
		}

slBlank = -> console.log "do nothing"


slChHSLFxS = -> 
	do(appendCircle! .data gnh.clr["clr_ch"] .updateModel buildPallete!)
slChHSLFxL = -> do(appendCircle! .data gnh.clr["clr_ch"] .updateModel buildPallete!.mdlfx "l" )
slEnHSLFxL = -> do(appendCircle! .data gnh.clr["clr_en"] .updateModel buildPallete!.mdlfx "l" )
slEnHSLFxS = -> do(appendCircle! .data gnh.clr["clr_en"] .updateModel buildPallete!.mdlfx "s" )
slChEnHSLFxs = ->
	do(appendCircle! .data gnh.clr["clr_en"] .updateModel (buildPallete!.mdlfx("s").cr(100).cx(120)))
	do(appendCircle! .lightload true .data gnh.clr["clr_en"] .selector "encdatas" .updateModel (buildPallete!.mdlfx("l").cr(100).cx(120).cy(460)))
	do(appendCircle! .lightload true .data gnh.clr["clr_ch"] .selector "chcdatas" .updateModel (buildPallete!.mdlfx("s").cr(100).cx(360)))
	do(appendCircle! .lightload true .data gnh.clr["clr_ch"] .selector "chcdatal" .updateModel (buildPallete!.mdlfx("l").cr(100).cx(360).cy(460)))

	svg
		.selectAll "text"
		.data ["English", "Chinese"]
		.enter!
		.append "text"
		.attr {
			"y": 370
			"x": (it, i)-> if i is 0 then 100 else 330
			"class": "clrtitle"
		}
		.text -> it



slBatHSLFxs = ->
	do(appendCircle! .data gnh.clr["bat_1"] .selector "bat_1" .dtsr(1).updateModel (buildPallete!.mdlfx "l" .cr(80).cx(100)))
	do(appendCircle! .data gnh.clr["bat_2"] .selector "bat_2" .dtsr(1).updateModel (buildPallete!.mdlfx "l" .cr(80).cx(300)))
	do(appendCircle! .data gnh.clr["bat_3"] .selector "bat_3" .dtsr(1).updateModel (buildPallete!.mdlfx "l" .cr(80).cx(500)))

slEnBar = ->
	do(appendCircle! .data gnh.clr["clr_en"] .updateModel(buildBar!) )

slEnRect = -> 
	do(appendCircle! .data gnh.clr["clr_en"] .updateModel(buildRect!) )

slChForce = -> 
	do(appendCircle! .data gnh.clr["clr_ch"] .updateModel(buildForce!.data gnh.clr["clr_ch"] .grpnm (gnh.grpclr["clr_en"].map -> it.key) ) )

slEnForce = -> 
	do(appendCircle! .data gnh.clr["clr_en"] .updateModel(buildForce!.data gnh.clr["clr_en"] .grpnm (gnh.grpclr["clr_en"].map -> it.key) ) )

slHighEnTop = ->
	hightlightGroup ["blue" "green" "pink"]
slHighEnBase = ->
	hightlightGroup ["blue" "green" "pink" "red" "yellow" "orange" "magenta" "purple" "gray" "black" "white" "cerulean" "maroon" "khaki" "cyan"]
slHighEnObj = ->
	hightlightGroup ["cooper" "candy" "sky" "taupe" "carmine" "gold" "crimson" "crayola" "silver" "turquoise" "liver" "slate" "royal" "ruby" "puce" "coral" "sea" "salmon"]
slHighEnFlower = ->
	hightlightGroup ["rose" "lavender" "violet" "fuchsia" "orchid" "indigo" "lime" "lemon" "raspberry" "peach" "mauve" "apple" "tangerine" "olive" "moss" "cerise" "lilac" "chestnut" "bud"]
slHighEnAdj = ->
	hightlightGroup ["dark" "light" "deep" "medium" "pale" "rich" "bright" "old" "rich" "grey" "vivid" "golden" "antique"]
slHighEnGeo = ->
	hightlightGroup ["french" "spanish" "persian" "tuscan" "english"]
slHighEnIdea = ->
	hightlightGroup ["electric" "x" "mensell" "pastel" "html" "web" "pantone" "ryb"]


exitForce = ->
	gnh.force.stop!

	d3.selectAll ".grpname"
		.transition!
		.style {
			"opacity": 0
		}
		.remove!

exitslChEnHSLFxs = ->
	d3.selectAll ".calldots" 
		.transition!
		.duration 1000
		.attr {
			"r": 0
		}
		.remove!

	svg.selectAll ".clrtitle"
		.remove!


lsExplain = [
	{"exit": (-> ), "enter": slBlank, "text": "Language represents our model of the world, knowing its limit helps us understand how our perception work." },
	{"exit": (-> ), "enter": slBlank, "text": "I use the data from wikipedia color entry for different language. My assumption was: \"Different language has different interest for color.\" "},	
	{"exit": (-> ), "enter": slChHSLFxS, "text": "The Chinese entry has 250+ different color. </br></br> The Hue-Saturation-Lightness (HSL) model is a 3D model that needs to be projected on a 2D space. </br></br> Using Hue as angle, we can either set Saturation to the radius, "},
	{"exit": (-> ), "enter": slChHSLFxL, "text": "or Lightness as the radius."},
	{"exit": (-> ), "enter": slBlank, "text": "You can notice that there are many white spaces, we usually use the adjacent name for these colors."},
	{"exit": (-> ), "enter": slEnHSLFxL, "text": "Here is the English Dataset, keeping Lightness as constant. "},
	{"exit": (-> ), "enter": slEnHSLFxS, "text": "Keeping Saturation as constant."},
	{"exit": exitslChEnHSLFxs, "enter": slChEnHSLFxs, "text": "Comparing the two dataset, you can see that English has a richer entry of color names."},
	# {"exit": exitslChEnHSLFxs, "enter": slBatHSLFxs, "text": "Using this model, we can also analysis different dataset, such as the color patern in the Batman triology. (Data Coustesy of )"},
	{"exit": exitStruct, "enter": enterStruct, "text": "However, it's always worth asking: have we find the best model to represent our dataset? </br></br> For instance, there seems to be structure in the names of the colors: names share suffix."},
	{"exit": (-> ), "enter": slEnBar, "text": "A better visualization will be to split the name of the color, words by words. "},
	{"exit": (-> ), "enter": slEnRect, "text": "Now we can see that in Chinese, the most popular base color is 紅 (red), following by 藍 (blue), and 綠 (green)."},
	{"exit": exitForce, "enter": slEnForce, "text": "There are frequent used word such as 暗 (dark) and 亮 (light), that is not a base color, but an adjective. "},
	{"exit": (-> ), "enter": slBlank, "text": "We also have object such as 鮭 (summon), 石 (stone), 松 (spine tree), where we have name of object."},
	{"exit": (-> ), "enter": slBlank, "text": "This visualization also solve a long-time problem, because in Chinese, we have this mysterious color called 青, that no ones really know what it represents. </br></br> Here are all the color with 青 in it."},
	{"exit": exitForce, "enter": slEnForce, "text": "Now let's see English. Remember that in Chinese the top three color is Red-Blue-Green."},
	{"exit": exitForce, "enter": slHighEnTop, "text": "In English, the top three colors are Blue, Green and  Pink."},
	{"exit": (-> ), "enter": slHighEnBase, "text": "You can also notice the same characteritics of using base color, "},
	{"exit": (-> ), "enter": slHighEnObj, "text": "association from object"},
	{"exit": (-> ), "enter": slHighEnFlower, "text": "from flowers and fruits"},
	{"exit": (-> ), "enter": slHighEnAdj, "text": "and with adjective."},
	{"exit": (-> ), "enter": slHighEnGeo, "text": "But some interesting naming convention in English, is using geolocation, "},
	{"exit": (-> ), "enter": slHighEnIdea, "text": "and concept. "},
	{"exit": (-> ), "enter": slBlank, "text": "This process represents some concepts that I believe in visualization: keep testing different model, and learn something new on your dataset. </br></br> 
	There is a thinking that treats visualization as a magical process that prettifies the output. Yet the only way we can make meaningfull graph is when we discover something meaningfull during our research.</br></br> 
	People are relying on us to see the world. Out of everyone, we are the one who needs to have these interesting tests/ models/ questions/ hypothesis at hands, because if we don't know the color 'red', our story will never have'red' in it. </br></br></br>
	By Muyueh Lee, </br>adapted from his talk \"Green Honey\" @\#OpenDataWorkshop2013."},
	# {"enter": act-macro ,"text": "Also, getting back to the Alice-Bob model, Alice really need to have good model of the world, if 	 "},
]


ticking = (i)->	
	if i is not sld.hghidx
		if sld.hghidx is not -1 then lsExplain[sld.hghidx].exit!
		sld.hghidx := i
		updtBlackIdxDots!
		lsExplain[sld.hghidx].enter!

scrollingTo = (i)->
	$("body").scrollTop($ sld.dscrpts[i] .position!.top)


scrolling = -> 
	sld.dscrpts.map (it, i)->
		b = it.getBoundingClientRect()
		m = b.top
		lm = sld.screenh / 2

		d3.select it .style "opacity", -> 
			if m < lm
				if m > 0 then ticking i
				# if m < 100 then (d3.selectAll ".scroll-down" .transition!.style "display", "none")
				m / 100
			else
				1		

initiate-data = ->
	txt = d3.selectAll ".txtholder"
		.selectAll ".description"
		.data lsExplain
		.enter!

	txt
		.append "div"
		.attr {
			"class": "description"	
		}
		.append "h4"
		.attr {
			"class": "descriptionH4"
		}
		.html -> it.text



	d3.selectAll ".idxholder"
		.selectAll ".idx"
		.data lsExplain
		.enter!
		.append "div"
		.attr {
			"class": "idx"
		}
		.style {
			"cursor": "pointer"
		}
		.on "mousedown" (d,i)-> scrollingTo i

	sld.dscrpts := [].slice.call document.getElementsByClassName("description") # HTMLcollection to list


setupslide = -> 
	initBar!
	initiate-data!
	scrolling!

	$ window .scroll ->
		scrolling!