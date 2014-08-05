{flatten} = require "prelude-ls"


countColor = (list, splitFunc)->
	freq = {}

	list.map -> 
		(splitFunc it.name).map (nmtoken)-> 
			if freq[nmtoken] is undefined then freq[nmtoken] := []
			freq[nmtoken].push it

	d3.entries freq .sort (a,b)-> b.value.length - a.value.length


b = {}
b.data = gnh.barclr["clr_en"] # []
b.selector = "encdatas"
b.dtsr = 3

	
initBar = -> 
	lsNmToken = [
		{name: "clr_en", del: " "}
		{name: "clr_ch", del: ""}
		{name: "clr_fr", del: " "}
	]

	lsNmToken.map (clr)-> 
		gnh.barclr[clr.name] := countColor gnh.cdata[clr.name], (-> it.split clr.del )

	b.data := gnh.barclr["clr_en"]
	#TOBEREMOVED



barXY = -> 
	it
		.attr {
			"cx": (it, i)-> it.barx
			"cy": (it, i)-> it.bary
		}


rectXY = -> 
	rw = 25
	it
		.attr { 
			"cx": (it, i)-> ~~(i % rw)  * 2 * (b.dtsr + 1)
			"cy": (it, i)-> ~~(i / rw)  * 2 * (b.dtsr + 1)
		}

buildBar = ->

	data = b.data.map (n, i)->
		n.value.map (c, j)-> 
			{
				"barx": j * 2 * (b.dtsr + 1)
				"bary": i * 2 * (b.dtsr + 1)
				"nm": c.name
				"color": c.color
			}

	svg
	.selectAll "." + b.selector
		.data flatten data
		.enter!
		.append "circle"
		.attr {
			
			"r": b.dtsr
			"class": b.selector
		}
		.style {
			"fill": -> it.color
		}
		.call barXY

toCircle = ->
	svg.selectAll "." + b.selector
		.transition!
		# .duration 1200
		.delay (it, i)-> i * 1
		.call buildModel!

toBar = ->
	svg.selectAll "." + b.selector
		.transition!
		# .duration 1200
		.delay (it, i)-> i * 1
		.call barXY

toRect = ->
	svg.selectAll "." + b.selector
		.transition!
		.duration 1200
		# .delay (it, i)-> i * 1
		.call rectXY

sortRect = -> 
	svg.selectAll "." + b.selector
		.sort (a, b)-> (d3.hsl a.color).l - (d3.hsl b.color).l
		.transition!
		.duration 1200
		# .delay (it, i)-> i * 1
		.call rectXY

		