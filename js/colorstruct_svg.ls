{flatten, unique, sort} = require "prelude-ls"

fntsize = 35
lslsclrstruct = [
	["Android" "green"]
	["Apple" "green"]
	["Army" "green"]
	["腥" "紅"]
	["鮭" "紅"]
	["暗" "鮭" "紅"]
]

enterStruct = ->
	svg
		.selectAll ".cStrucGroup"
		.data lslsclrstruct
		.enter!
		.append "g"
		.attr {
			# "transform": (it, i)-> 
			# 	x = 300 + (if i < 3 then 0 else (3 - it.length) * fntsize + 40)
			# 	return "translate(" + x + "," + (100 + i * fntsize * 1.1 ) + ")"
			"class": "cStrucGroup"
		}
		.selectAll ".cStruc"
		.data -> it
		.enter!
		.append "text"
		.attr {
			"x": (it, i)-> return if it.length is 1 then i * fntsize else (i * fntsize * it.length / 1.8)
			"class": "cStruc"
		}
		.style {
			"font-size": fntsize
			"text-anchor": "end"
		}
		.text -> it


move = -> 

	# svg
	# 	.selectAll ".cStrucGroup"
	# 	.transition!
	# 	.delay (it, i)-> i * 300
	# 	.attr {
	# 		"transform": "translate(300,0)"
	# 	}
	
	console.log(lslsclrstruct |> flatten |> unique |> sort)

	flt = svg
		.selectAll ".cStruc"
		.data ["green" "Android" "Apple" "Army" "紅" "鮭" "腥" "暗"]
		.transition!
		.duration 1500
		.attr {
			"x": 300
			"y": (it, i)-> i * fntsize * 1.1
		}




exitStruct = ->





	# d3.selectAll ".clrstructholder"
	# 	.remove!