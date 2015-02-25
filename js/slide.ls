#TODO detect scrolling direction; implement different type of transition

# Idea spereration of concern; build this as a function; and feeed data inside; now we are still relying on global var to send data.

# munsell color system
# font problem
sld = {}
sld.screenh = $ window .height!
sld.hghidx = -1

updtBlackIdxDots = ->	
	d3.selectAll ".idx"
		.style {
			"background-color": (it, i)-> if i is sld.hghidx then "black" else "white"
		}

slBk = -> console.log "do nothing"


slWiki = -> 
	do(appendCircle! .textload true .data gnh.clr["clr_ch"] .updateModel buildList! .textModel buildList!.type "text")

exitWiki = ->
	d3.selectAll ".clrnm"
		.transition!
		.style {
			"opacity": 0
		}

enter2upWiki = ->
	d3.selectAll ".clrnm"
		.transition!
		.style {
			"opacity": 0.3
		}

slChHSLFxS = -> 
	do(appendCircle! .data gnh.clr["clr_ch"] .updateModel buildPallete!)
slChHSLFxL = -> do(appendCircle!.lightload true .data gnh.clr["clr_ch"] .updateModel buildPallete!.mdlfx "l" )
slEnHSLFxL = -> do(appendCircle!.lightload true .data gnh.clr["clr_en"] .updateModel buildPallete!.mdlfx "l" )
slEnHSLFxS = -> do(appendCircle!.lightload true .data gnh.clr["clr_en"] .updateModel buildPallete!.mdlfx "s" )
slChEnHSLFxs = ->
	do(appendCircle!.lightload true .data gnh.clr["clr_en"] .updateModel (buildPallete!.mdlfx("s").cr(100).cx(120)))
	do(appendCircle!.lightload true .data gnh.clr["clr_en"] .selector "encdatas" .updateModel (buildPallete!.mdlfx("l").cr(100).cx(120).cy(460)))
	do(appendCircle!.lightload true .data gnh.clr["clr_ch"] .selector "chcdatas" .updateModel (buildPallete!.mdlfx("s").cr(100).cx(360)))
	do(appendCircle!.lightload true .data gnh.clr["clr_ch"] .selector "chcdatal" .updateModel (buildPallete!.mdlfx("l").cr(100).cx(360).cy(460)))

	svg
		.selectAll ".clrtitle"
		.data ["English", "Chinese"]
		.enter!
		.append "text"
		.attr {
			"y": 370
			"x": (it, i)-> if i is 0 then 100 else 330
			"class": "clrtitle"
		}
		.text -> it


# slForceEnHSLFxS = -> 
# 	do(appendCircle!.lightload true .data gnh.clr["clr_en"] .updateModel (buildForce!.data gnh.clr["clr_en"] .targetFunc targetCenter) )

# slBatHSLFxs = ->
# 	do(appendCircle! .data gnh.clr["bat_1"] .selector "bat_1" .dtsr(1).updateModel (buildPallete!.mdlfx "l" .cr(80).cx(100)))
# 	do(appendCircle! .data gnh.clr["bat_2"] .selector "bat_2" .dtsr(1).updateModel (buildPallete!.mdlfx "l" .cr(80).cx(300)))
# 	do(appendCircle! .data gnh.clr["bat_3"] .selector "bat_3" .dtsr(1).updateModel (buildPallete!.mdlfx "l" .cr(80).cx(500)))

slEnBar = ->
	do(appendCircle! .data gnh.clr["clr_en"] .updateModel(buildBar!) )

slEnRect = -> 
	do(appendCircle! .data gnh.clr["clr_en"] .updateModel(buildRect!) )


slChForce = -> 
	do(appendCircle! .data gnh.clr["clr_ch"] .selector "chforce" .updateModel(buildForce! .selector "chforce" .data gnh.clr["clr_ch"] .grpnm (gnh.grpclr["clr_ch"].map -> it.key) ) )

slHighChTop = ->
	hightlightGroup ["紅" "藍" "綠"], "chforce"

slHighChAdj = ->
	hightlightGroup ["暗" "亮"], "chforce"

slHighChObj = ->
	hightlightGroup ["鮭" "石" "松"], "chforce"

slHighChMis = ->
	hightlightGroup ["青"], "chforce"

slEnForce = -> 
	do(appendCircle! .data gnh.clr["clr_en"] .selector "enforce" .updateModel(buildForce!.selector "enforce" .data gnh.clr["clr_en"] .grpnm (gnh.grpclr["clr_en"].map -> it.key) ) )


slHighEnTop = ->
	hightlightGroup ["blue" "green" "pink"], "enforce"
slHighEnBase = ->
	hightlightGroup ["blue" "green" "pink" "red" "yellow" "orange" "magenta" "purple" "gray" "black" "white" "cerulean" "maroon" "khaki" "cyan"], "enforce"
slHighEnObj = ->
	hightlightGroup ["cooper" "candy" "sky" "taupe" "carmine" "gold" "crimson" "crayola" "silver" "turquoise" "liver" "slate" "royal" "ruby" "puce" "coral" "sea" "salmon"], "enforce"
slHighEnFlower = ->
	hightlightGroup ["rose" "lavender" "violet" "fuchsia" "orchid" "indigo" "lime" "lemon" "raspberry" "peach" "mauve" "apple" "tangerine" "olive" "moss" "cerise" "lilac" "chestnut" "bud"], "enforce"
slHighEnAdj = ->
	hightlightGroup ["dark" "light" "deep" "medium" "pale" "rich" "bright" "old" "rich" "grey" "vivid" "golden" "antique"], "enforce"
slHighEnGeo = ->
	hightlightGroup ["french" "spanish" "persian" "tuscan" "english"], "enforce"
slHighEnIdea = ->
	hightlightGroup ["electric" "x" "mensell" "pastel" "html" "web" "pantone" "ryb"], "enforce"


exitForce = ->
	gnh.force.stop!

	d3.selectAll ".grp" + it
		.transition!
		.style {
			"opacity": 0
		}
		.remove!

	d3.selectAll "." + it 
		.remove!

exitChForce = ->
	exitForce "chforce"

exitEnForce = ->
	exitForce "enforce"

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
# slEnBar
# slEnRect

## enter2down and enter2up are used to avoid extra comptation needed when only using enter
lsExplain = [
	{"exit2up": (->), "exit2down": exitWiki, "exit": (-> ), "enter2up": enter2upWiki, "enter2down": slBk, "enter": slWiki, "text": "Language represents our view of the world, and knowing its limits helps us understand how our perception works.</br></br>I used the data from Wikipedia’s “Color” entry for different languages. My assumption was: </br></br>\"Different languages have different ways to describe color.”</br></br><strong>(Scroll Down to Start)</strong>" },
	{"exit2up": (->), "exit2down": (->), "exit": (-> ), "enter2up": slBk, "enter2down": slBk, "enter": slChHSLFxS, "text": "The Chinese entry has 250+ different colors. </br></br> The Hue-Saturation-Lightness (HSL) model is a 3D model that can be projected on a 2D space. </br></br> Using Hue as an angle, we can set either Saturation as the radius . . ."},
	{"exit2up": (->), "exit2down": (->), "exit": (-> ), "enter2up": slBk, "enter2down": slBk, "enter": slChHSLFxL, "text": "or Lightness as the radius."},
	# {"exit2up": (->), "exit2down": (->), "exit": (-> ), "enter2up": slBk, "enter2down": slBk, "enter": slBk, "text": "You can notice that there are many white spaces, we usually use the adjacent name for these colors."},
	{"exit2up": (->), "exit2down": (->), "exit": (-> ), "enter2up": slBk, "enter2down": slBk, "enter": slEnHSLFxL, "text": "Here is the English Dataset, keeping Lightness as a constant . . . "},
	{"exit2up": (->), "exit2down": (->), "exit": (-> ), "enter2up": slBk, "enter2down": slBk, "enter": slEnHSLFxS, "text": "or keeping Saturation as the constant."},
	{"exit2up": (->), "exit2down": (->), "exit": exitslChEnHSLFxs, "enter2up": slBk, "enter2down": slBk, "enter": slChEnHSLFxs, "text": "Comparing the two datasets, you can see that English has a richer entry for color names."},
	# {"exit2up": (->), "exit2down": (->), "exit": exitslChEnHSLFxs, "enter2up": slBk, "enter2down": slBk, "enter": slBatHSLFxs, "text": "Using this model, we can also analysis different dataset, such as the color patern in the Batman triology. (Data Coustesy of )"},
	# {"exit2up": (->), "exit2down": (->), "exit": (-> ), "enter2up": slBk, "enter2down": slBk, "enter": , "text": "However, it's always worth asking: have we find the best model to represent our dataset? </br></br> For instance, there seems to be structure in the names of the colors: names share suffix."},

	# {"exit2up": (->), "exit2down": (->), "exit": (-> ), "enter2up": slBk, "enter2down": slForceEnHSLFxS, "enter": slBk, "text": "However, it's always worth asking: is this the best model to represent our dataset?</br></br>Let's play around a bit."},
	# {"exit2up": (->), "exit2down": (->), "exit": (-> ), "enter2up": slBk, "enter2down": slBk, "enter": slBk, "text": "We need to play around f"},
	# {"exit2up": (->), "exit2down": (->), "exit": (-> ), "enter2up": slBk, "enter2down": slBk, "enter": slBk, "text": "However, it's always worth asking: have we find the best model to represent our dataset?"},
	
	{"exit2up": exitChForce, "exit2down": (->), "exit": (-> ), "enter2up": slBk, "enter2down": slChForce, "enter": slBk, "text": "However, it's always worth asking: Is this the best model to represent our dataset?</br></br>Notice that the Chinese and English names for colors share a common structure of \"noun/adj + base color\": <ul><li>腥<span class='rd'>紅</span></li><li>鮭<span class='rd'>紅</span></li><li>暗鮭<span class='rd'>紅</span></li></ul> </br><ul><li>Android <span class='gn'>green</span></li><li>Apple <span class='gn'>green</span></li><li>Army <span class='gn'>green</span></li></ul></br>A better visualization will be to split the name of the color, word by word."},
	{"exit2up": (->), "exit2down": (->), "exit": (-> ), "enter2up": slBk, "enter2down": slBk, "enter": slHighChTop, "text": "Now we can see that in Chinese, the most popular base color is 紅 (red), followed by 藍 (blue), and 綠 (green)."},
	
	{"exit2up": (->), "exit2down": (->), "exit": (-> ), "enter2up": slBk, "enter2down": slBk, "enter": slHighChAdj , "text": "There are frequently used words, such as 暗 (dark) and 亮 (light), which are not base colors but rather adjectives for a color."},
	{"exit2up": (->), "exit2down": (->), "exit": (-> ), "enter2up": slBk, "enter2down": slBk, "enter": slHighChObj, "text": "There are also objects, such as 鮭 (salmon), 石 (stone), 松 (pine tree), where there is a name of an object."},
	{"exit2up": (->), "exit2down": exitChForce, "exit": (-> ), "enter2up": slChForce, "enter2down": slBk, "enter": slHighChMis, "text": "This visualization also solves a longtime problem: In Chinese, we have this mysterious color called 青 but no one really knows what it represents. </br></br> Here are all the colors with 青 in their names."},
	
	{"exit2up": exitEnForce, "exit2down": (->), "exit": (-> ), "enter2up": slBk, "enter2down": slEnForce, "enter": slBk, "text": "Now let's see English. Remember that in Chinese, the top three colors are Red, Blue, and Green."},
	{"exit2up": (->), "exit2down": (->), "exit": (-> ), "enter2up": slBk, "enter2down": slBk, "enter": slHighEnTop, "text": "In English, the top three colors are Blue, Green, and Pink."},
	{"exit2up": (->), "exit2down": (->), "exit": (-> ), "enter2up": slBk, "enter2down": slBk, "enter": slHighEnBase, "text": "You can also see the same characteristics of using a base color:"},
	{"exit2up": (->), "exit2down": (->), "exit": (-> ), "enter2up": slBk, "enter2down": slBk, "enter": slHighEnObj, "text": "association from object . . . "},
	{"exit2up": (->), "exit2down": (->), "exit": (-> ), "enter2up": slBk, "enter2down": slBk, "enter": slHighEnFlower, "text": "from flowers and fruits . . . "},
	{"exit2up": (->), "exit2down": (->), "exit": (-> ), "enter2up": slBk, "enter2down": slBk, "enter": slHighEnAdj, "text": "and with adjectives."},
	{"exit2up": (->), "exit2down": (->), "exit": (-> ), "enter2up": slBk, "enter2down": slBk, "enter": slHighEnGeo, "text": "But some interesting naming conventions in English use geolocation "},
	{"exit2up": (->), "exit2down": (->), "exit": (-> ), "enter2up": slBk, "enter2down": slBk, "enter": slHighEnIdea, "text": "and concepts."},
	{"exit2up": (->), "exit2down": (->), "exit": (-> ), "enter2up": slBk, "enter2down": slBk, "enter": slBk, "text": "This process represents some concepts that I believe are true in visualization: Keep testing different models and learn something new from your dataset. </br></br>  
	There is a way of thinking that treats visualization as a magical process that prettifies the output, yet the only way we can make a meaningful graph is when we discover something meaningful during our research.</br></br>  
	People are relying on us to see the world. Out of everyone, we are the ones who need to have these interesting tests / models / questions / hypotheses at hand because if we don't know the color “red,” our story will never have “red” in it. </br></br></br>
	By Muyueh Lee @muyueh, </br>adapted from his talk \"Green Honey\" @\#OpenDataWorkshop2013."},
	# {"enter": act-macro ,"text": "Also, getting back to the Alice-Bob model, Alice really need to have good model of the world, if 	 "},
]


ticking = (i)->	
	
	if i is not sld.hghidx
		d = if sld.hghidx < i then "d" else "u"
		
		if sld.hghidx is not -1
			if d is "d" then lsExplain[sld.hghidx].exit2down! else lsExplain[sld.hghidx].exit2up!
			lsExplain[sld.hghidx].exit!

		sld.hghidx := i
		updtBlackIdxDots!
		if d is "d" then lsExplain[sld.hghidx].enter2down! else lsExplain[sld.hghidx].enter2up!
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

do ->
	wait = gnh.lsfl.length 
	gnh.lsfl.map ->

		err, colorTSV <- d3.tsv "http://d3gwo6jloocu32.cloudfront.net/greenhoney/data/" + it + ".tsv?v=3"
		# err, colorTSV <- d3.tsv "./data/" + it + ".tsv?v=3"

		if colorTSV[0].name is not undefined
			colorTSV = colorTSV.filter ->
				gnh.allclrls[cleanName it.name] := it.color
				it.name = cleanPunc it.name

				true

		gnh.clr[it] := colorTSV

		if --wait is 0 then setupslide!
