{Str} = require "prelude-ls"


addClass = (array, className, it)->
	# array[0]  + "</span>" + "<div style='display:inline; color:" + gnh.allclrls[(cleanName it)] + ";' class='cl_" + (cleanName it) + "'>" + array[1] + "</div>"
	# array[0]  + "</span>" + "<div style='display:inline; color:" + gnh.allclrls[(cleanName it)] + ";' class='cl_" + (cleanName it) + "'>" + array[1] + "</div>"

# background-
# + "<span class='" + className + "'>" + array[1]

addColor = -> 
	"<div style='display:inline; background-color:" + gnh.allclrls[(cleanName it)] + ";' class=clrnmdots></div>"

enterStruct = ->

	lslsclrstruct = [
		["Android green" "Apple green" "Army green"].map ->
			it + (addColor it)
			# cl = (it.split " ")
			# addClass cl, "gn", it
		["腥紅" "鮭紅" "暗鮭紅"].map ->
			it + (addColor it)
			# l = it.length
			# cl = Str.split-at (l - 1), it 
			# addClass cl, "rd", it
	]


	struct = {}
	struct.fntsize = 50
	struct.top = 100
	struct.left = 100

	d3.select ".svgholder"
		.append "div"
		.attr {
			"class": "clrstructholder"
		}
		.style {
			"position": "fixed"
			"top": "100px"
			"left": "100px"
		}
		.selectAll ".clrstruct"
		.data lslsclrstruct
		.enter!
		.append "div"
		.attr {
			"top": (it, i)-> (i * 4 * struct.fntsize) + "px"
			"class": "clrstruct"
		}
		.selectAll "div"
		.data -> it
		.enter!
		.append "div"
		.attr {
			"left": (gnh.w / 2 + struct.left ) + "px"
			"top": (it, i)-> (100 + i * struct.fntsize) + struct.top + "px"
		}
		.style {
			"font-size": struct.fntsize + "px"
			"text-align": "right"
		}
		.html -> it

	d3.selectAll ".rd"
		.transition!
		.duration 1200
		.style {
			"color": "rgb(201, 0, 0)"
		}

	d3.selectAll ".gn"
		.transition!
		.duration 1200
		.style {
			"color": "green"
		}

exitStruct = ->
	d3.selectAll ".clrstructholder"
		.remove!
