{lists-to-obj} = require "prelude-ls"

ggl = {}

ggl.margin = {top: 10, left: 10, right: 20, bottom: 20}
ggl.w = 600 - ggl.margin.left - ggl.margin.right
ggl.h = 600 - ggl.margin.top - ggl.margin.bottom
ggl.r = 3

ggl.cx = 200
ggl.cy = 200
ggl.cr = 200

ggl.cmdl = -> d3.hsl it
ggl.cmdlfix = "s" #"l"

ggl.clrfl = "en"

ggl.cdata = {
	# "en": 
	# "ch": 
}


svg = d3.select "body"
	.append "svg"
	.attr {
		"width": ggl.w + ggl.margin.left + ggl.margin.right
		"height": ggl.h + ggl.margin.top + ggl.margin.bottom
	}
	.append "g"
	.attr {
		"transform": "translate(" + ggl.margin.left + "," + ggl.margin.right + ")"
	}

cleanName = (str)->
	str.replace(/,/g, "").replace(/"/g, "").replace(/\./g, "").replace(/'/g, "").replace(/-/g, "").toLowerCase!


changeColor = ->
	ggl.cmdlfix := "l"
	svg.selectAll ".cdots"
		.transition!
		.duration 1500
		.call updateModel


changeColor2 = ->
	# ggl.cmdlfix := "l"
	ggl.clrfl = "ch"
	updateColor!

	svg.selectAll ".cdots"
		.transition!
		.duration 1500
		.call updateModel


updateModel = ->
	it
		.each -> 
			clr = ggl.cmdl it.color
			for attr of clr
				if isNaN clr[attr] then clr[attr] = 0
			# console.log clr
			it.x = ggl.cx + Math.cos(clr.h * Math.PI / 180 ) * ggl.cr * clr[ggl.cmdlfix]
			it.y = ggl.cy + Math.sin(clr.h * Math.PI / 180 ) * ggl.cr * clr[ggl.cmdlfix]
		.attr {
			"cx": (it, i)-> it.x
			"cy": (it, i)-> it.y
		}


updateColor = ->
	c = svg
		.selectAll ".cdots"
		.data ggl.cdata[ggl.clrfl]

	c
		.enter!
		.append "circle"
		.attr {
			"fill": (it, i)-> it.color
			"class": (it, i)-> "cdots c" + cleanName it.color
			"r": -> ggl.r
			}
		.call updateModel

	c
		.transition!
		.call updateModel

	c
		.exit!
		.remove!


["en" "ch"].map -> 
	err, colorTSV <- d3.tsv "./data/colorname_" + it + ".tsv"
	ggl.cdata[it] := colorTSV





