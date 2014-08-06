{flatten} = require "prelude-ls"

buildBar = ->
	m = {}
	m.dtsr = 3
	m.margin = 1

	build = ->
		it
			.each (it, i)->
				it.x = it.ingrpidx * 2 * (m.dtsr + m.margin)
				it.y = it.grpidx * 2 * (m.dtsr + m.margin)
			.attr {
				"cx": -> it.x
				"cy": -> it.y
			}

	for let it of m
		build[it] = (v)-> 
			m[it] := v
			build

	build




buildRect = ->
	m = {}
	m.dtsr = 3
	m.margin = 1
	m.rectWidth = 50

	build = ->
		#  use this instead of directly calculating; so that this won't be affected by force layout
		it
			.each (it, i)->
				it.x = (it.ttlidx % m.rectWidth) * 2 * (m.dtsr + m.margin)
				it.y = ~~(it.ttlidx / m.rectWidth) * 2 * (m.dtsr + m.margin)
			.attr {
				"cx": -> it.x
				"cy": -> it.y
			}

	for let it of m
		build[it] = (v)-> 
			m[it] := v
			build

	build

