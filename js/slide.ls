# Idea spereration of concern; build this as a function; and feeed data inside; now we are still relying on global var to send data.

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
	# console.log gnh.clr["clr_ch"]
	do(appendCircle! .data gnh.clr["clr_ch"] .updateModel buildPallete!)
slChHSLFxL = -> do(appendCircle! .data gnh.clr["clr_ch"] .updateModel buildPallete!.mdlfx "l" )
slEnHSLFxL = -> do(appendCircle! .data gnh.clr["clr_en"] .updateModel buildPallete!.mdlfx "l" )
slEnHSLFxS = -> do(appendCircle! .data gnh.clr["clr_en"] .updateModel buildPallete!.mdlfx "s" )
slChEnHSLFxs = ->
	do(appendCircle! .data gnh.clr["clr_en"] .updateModel (buildPallete!.mdlfx("s").cr(100).cx(120)))
	do(appendCircle! .data gnh.clr["clr_en"] .selector "encdatas" .updateModel (buildPallete!.mdlfx("l").cr(100).cx(120).cy(460)))
	do(appendCircle! .data gnh.clr["clr_ch"] .selector "chcdatas" .updateModel (buildPallete!.mdlfx("s").cr(100).cx(360)))
	do(appendCircle! .data gnh.clr["clr_ch"] .selector "chcdatal" .updateModel (buildPallete!.mdlfx("l").cr(100).cx(360).cy(460)))

slBatHSLFxs = ->
	do(appendCircle! .data gnh.clr["bat_1"] .selector "bat_1" .dtsr(1).updateModel (buildPallete!.mdlfx "l" .cr(80).cx(100)))
	do(appendCircle! .data gnh.clr["bat_2"] .selector "bat_2" .dtsr(1).updateModel (buildPallete!.mdlfx "l" .cr(80).cx(300)))
	do(appendCircle! .data gnh.clr["bat_3"] .selector "bat_3" .dtsr(1).updateModel (buildPallete!.mdlfx "l" .cr(80).cx(500)))

slEnBar = ->
	do(appendCircle! .data gnh.clr["clr_ch"] .updateModel(buildBar!) )

slEnRect = -> 
	do(appendCircle! .data gnh.clr["clr_ch"] .updateModel(buildRect!) )


exitslChEnHSLFxs = ->
	d3.selectAll ".calldots" 
		.transition!
		.duration 1000
		.attr {
			"r": 0
		}
		.remove!

lsExplain = [
	{"exit": (-> ), "enter": slBlank, "text": "Language represents our model of the world, knowing its limit helps us understand how our perception work." },
	{"exit": (-> ), "enter": slBlank, "text": "I use the data from wikipedia color entry for different language. My assumption was: \"Different language has different interest for color.\" "},	
	{"exit": (-> ), "enter": slChHSLFxS, "text": "The Chinese entry has 250+ different color. </br></br> The Hue-Saturation-Lightness (HSL) model is a 3D model that needs to be projected on a 2D space. </br></br> Using Hue as angle, we can either set Saturation to the radius, "},
	{"exit": (-> ), "enter": slChHSLFxL, "text": "or Lightness as the radius."},
	{"exit": (-> ), "enter": slBlank, "text": "You can notice that there are many white spaces, we usually use the adjacent name for these colors."},
	{"exit": (-> ), "enter": slEnHSLFxL, "text": "Here is the English Dataset (Keeping Lightness as constant)."},
	{"exit": (-> ), "enter": slEnHSLFxS, "text": "(Keeping Saturation as constant)."},
	{"exit": exitslChEnHSLFxs, "enter": slChEnHSLFxs, "text": "Comparing the two dataset, you can see that English has a richer entry of color names."},
	# {"exit": exitslChEnHSLFxs, "enter": slBatHSLFxs, "text": "Using this model, we can also analysis different dataset, such as the color patern in the Batman triology. (Data Coustesy of )"},
	# {"exit": exitStruct, "enter": enterStruct, "text": "However, it's always worth asking: have we find the best model to represent our dataset? </br></br> For instance, there seems to be structure in the names of the colors: names share suffix."},
	{"exit": (-> ), "enter": slEnBar, "text": "A better visualization will be to split the name of the color, words by words. "},
	{"exit": (-> ), "enter": slEnRect, "text": "Now we can see that in Chinese, the most popular base color is 紅 (red), following by 藍 (blue), and 綠 (green)."},
	{"exit": (-> ), "enter": slBlank, "text": "There are frequent used word such as 暗 (dark) and 亮 (light), that is not a base color, but an adjective. "},
	{"exit": (-> ), "enter": slBlank, "text": "We also have object such as 鮭 (summon), 石 (stone), 松 (spine tree), where we have name of object."},
	{"exit": (-> ), "enter": slBlank, "text": "This visualization also solve a long-time problem, because in Chinese, we have this mysterious color called 青, that no ones really know what it represents. </br></br> Here are all the color with 青 in it."},
	{"exit": (-> ), "enter": slBlank, "text": "How let's see English. Remember that in Chinese the top three color is Red-Blue-Green.</br></br> In English, the top three colors are Blue, Green, Pink and Red."},
	{"exit": (-> ), "enter": slBlank, "text": "You can also notice the same attribute of using object name and adjective."},
	{"exit": (-> ), "enter": slBlank, "text": "But one interesting naming convention in English, is that we use location name, such as French, Persian, Turkish and English. "},
	{"exit": (-> ), "enter": slBlank, "text": "This process really represents some main ideas I have on visualization: the process of building visualization is to keep testing different model on our dataset, different models reveals the different part of this dataset."},
	{"exit": (-> ), "enter": slBlank, "text": "Most importantly, this process makes you understand your data. There is a thinking that goes like this: we can throw some conclusions to our designers, and they will be able to prettify the output. </br></br> However, the only way you can tell interesting story, it's when you really know your data, learn something new from it, and share then you can share it with others."},
	# {"enter": act-macro ,"text": "Also, getting back to the Alice-Bob model, Alice really need to have good model of the world, if 	 "},
]


ticking = (i)->	
	if i is not sld.hghidx
		if lsExplain[sld.hghidx] is not undefined then lsExplain[sld.hghidx].exit!
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
		.append "h4"
		.attr {
			"class": "description"
		}
		.style {
			"text-shadow": "2px 2px 1px white"
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