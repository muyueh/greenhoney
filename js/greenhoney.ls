{lists-to-obj} = require "prelude-ls"

gnh = {}

gnh.margin = {top: 10, left: 10, right: 20, bottom: 20}
gnh.w = 800 - gnh.margin.left - gnh.margin.right
gnh.h = 800 - gnh.margin.top - gnh.margin.bottom


gnh.lsfl = ["clr_en" "clr_ch" "clr_fr" "bat_1" "bat_2" "bat_3"]
gnh.cdata = {
	# "clr_en": 
	# "clr_ch": 
}

gnh.lsclr = {
	# parsed name: hrex
	# "red": #00d
	# "pink": #00d
}

gnh.barclr = {
	# "clr_en": [
		# {
			# key: "blue"
			# value: [{color: #C9FFE5, name: aero blue}]	
		# }
	# ]
}

svg = d3.select "body"
	.select ".svgholder"
	.append "svg"
	.attr {
		"width": gnh.w + gnh.margin.left + gnh.margin.right
		"height": gnh.h + gnh.margin.top + gnh.margin.bottom
	}
	.append "g"
	.attr {
		"transform": "translate(" + gnh.margin.left + "," + gnh.margin.right + ")"
	}


cleanName = (str)-> 
	str.replace(/,/g, "").replace(/"/g, "").replace(/\./g, "").replace(/'/g, "").replace(/-/g, "").replace(/ /g, "").toLowerCase!

cleanPunc = (str)->  str.replace(/-/g, " ").replace(/\//g, " ").replace(/\(/g, "").replace(/\)/g, "").replace(/&/g, "").replace(/[1]/g, " ").replace(/  /g, " ").trim!.toLowerCase!




buildModel = ->
	m = {}
	m.cx = 250
	m.cy = 250
	m.cr = 250
	m.mdl = -> d3.hsl it
	m.mdlfx = "s"

	build = ->
		it
			.each -> 
				clr = m.mdl it.color
				for attr of clr
					if isNaN clr[attr] then clr[attr] = 0
				it.x = m.cx + Math.cos(clr.h * Math.PI / 180 ) * m.cr * clr[m.mdlfx]
				it.y = m.cy + Math.sin(clr.h * Math.PI / 180 ) * m.cr * clr[m.mdlfx]
			.attr {
				"cx": (it, i)-> it.x
				"cy": (it, i)-> it.y
			}

	["cx" "cy" "cr" "mdl" "mdlfx"].map ->
		build[it]	:= (v)-> 
			m[it] := v
			build

	build


builPalette = ->
	p = {}
	p.selector = "cdots"
	p.data = []
	p.updateModel = (->)
	p.dtsr = 3

	build = ->
		c = svg
			.selectAll "." + p.selector
			.data p.data, -> (cleanName it.color)

		c
			.transition!
			.duration 1200
			.call p.updateModel

		c
			.enter!
			.append "circle"
			.attr {
				"fill": (it, i)-> it.color
				"class": (it, i)-> "calldots c" + (cleanName it.color) + " " + p.selector
				"r": 0
			}
			.transition!
			.duration 1200
			.attr {
				"r": p.dtsr	
			}
			.call p.updateModel

		c
			.exit!
			.transition!
			.attr {
				"r": 0
			}
			.remove!


	["selector" "data" "updateModel" "dtsr"].map ->
		build[it]	:= (v)-> 
			p[it] := v
			build

	build


do ->
	wait = gnh.lsfl.length 
	gnh.lsfl.map ->
		err, colorTSV <- d3.tsv "./data/" + it + ".tsv"

		if colorTSV[0].name is not undefined
			colorTSV = colorTSV.filter ->
				gnh.lsclr[cleanName it.name] := it.color
				it.name = cleanPunc it.name

				true

		gnh.cdata[it] := colorTSV

		

		if --wait is 0 then setupslide!



