{lists-to-obj, join} = require "prelude-ls"

gnh = {}

gnh.margin = {top: 10, left: 10, right: 20, bottom: 20}
gnh.w = 1000 - gnh.margin.left - gnh.margin.right
gnh.h = 850 - gnh.margin.top - gnh.margin.bottom


gnh.lsfl = ["clr_en" "clr_ch" "clr_fr" "bat_1" "bat_2" "bat_3"]
gnh.clr = {
	# "clr_en": 
	# "clr_ch": 
}

gnh.allclrls = {
	# parsed name: hrex
	# "red": #00d
	# "pink": #00d
}

gnh.grpclr = {
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


cleanName = (str)-> str.replace(/,/g, "").replace(/"/g, "").replace(/\./g, "").replace(/'/g, "").replace(/-/g, "").replace(/ /g, "").toLowerCase!
cleanPunc = (str)->  str.replace(/-/g, " ").replace(/\//g, " ").replace(/\(/g, "").replace(/\)/g, "").replace(/&/g, "").replace(/[1]/g, " ").replace(/  /g, " ").replace(/	 /g, " ").trim!.toLowerCase!

ifNaN = -> if isNaN it then 0 else it



clone = (obj)->
	JSON.parse JSON.stringify obj
	# newobj = {}
	# for attr of obj
	# 	newobj[attr] = obj[attr]
	# newobj

countColor = (list, splitFunc)->
	freq = {}
	
	list.filter (clr)-> 
		clr.grp = (splitFunc clr.name)

		clr.grp.map (nmtoken)-> 
			if freq[nmtoken] is undefined then freq[nmtoken] := []
			freq[nmtoken].push clone clr

		true

	rslt = d3.entries freq .sort (a,b)-> b.value.length - a.value.length

	
	ttlidx = -1	
	### list also augmenting itself w/ a clrclass + clridx
	list = flatten rslt.map (grp, grpidx)->
		return grp.value.map (clr, ingrpidx)->
			cclr = clr
			 # clone clr

			cclr.grpidx = grpidx
			cclr.ingrpidx = ingrpidx
			cclr.ttlidx = ++ttlidx
			cclr.primclr = grp.key

			return cclr

	return {
		"clr": list
		"grpclr": rslt
	}
	

	
	
initBar = -> 
	delRule = [
		{name: "clr_en", del: " "}
		{name: "clr_ch", del: ""}
		{name: "clr_fr", del: " "}
	]

	delRule.map (fl)-> 
		rslt = countColor gnh.clr[fl.name], (-> it.split fl.del )

		["grpclr", "clr"].map (attr)->
			gnh[attr][fl.name] := rslt[attr]


appendCircle = ->
	m = {}
	m.selector = "cdots"
	m.data = []
	m.updateModel = (->)
	m.dtsr = 3
	m.lightload = false

	build = ->
		# console.log m.data
		if m.lightload
			c = svg
				.selectAll "." + m.selector
				.data m.data , -> (cleanName it.color) # remove duplicate
		else 
			c = svg
				.selectAll "." + m.selector
				.data m.data
				# , -> it.primclr + (cleanName it.color)
				
		c
			.transition!
			.duration 1200
			.attr {
				"r": m.dtsr	
			}
			.call m.updateModel

		c
			.enter!
			.append "circle"
			.attr {
				"fill": (it, i)-> it.color
				"class": (it, i)-> "calldots c" + (cleanName it.color) + " " + m.selector + " " + (join " cgr", it.grp) + " prm" + it.primclr
				"r": 0
			}
			.transition!
			.duration 1200
			.attr {
				"r": m.dtsr	
			}
			.call m.updateModel

		c
			.exit!
			.transition!
			.attr {
				"r": 0
			}
			.remove!

	for let it of m
		build[it] = (v)-> 
			m[it] := v
			build

	build



setupslide = ->
	initBar!
	initiate-data!
	scrolling!

	$ window .scroll ->
		scrolling!

do ->
	wait = gnh.lsfl.length 
	gnh.lsfl.map ->
		err, colorTSV <- d3.tsv "./data/" + it + ".tsv"

		if colorTSV[0].name is not undefined
			colorTSV = colorTSV.filter ->
				gnh.allclrls[cleanName it.name] := it.color
				it.name = cleanPunc it.name

				true

		gnh.clr[it] := colorTSV

		if --wait is 0 then setupslide!
