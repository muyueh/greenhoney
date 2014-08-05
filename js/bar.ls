{flatten} = require "prelude-ls"

buildBar = ->
	m = {}
	m.dtsr = 3
	m.margin = 0.5

	build = ->
		it
			.attr {
				"cx": (it, i)-> it.ingrpidx * 2 * (m.dtsr + m.margin)
				"cy": (it, i)-> it.grpidx * 2 * (m.dtsr + m.margin)
			}

	for let it of m
		build[it] = (v)-> 
			m[it] := v
			build

	build




buildRect = ->
	m = {}
	m.dtsr = 3
	m.margin = 0.5
	m.rectWidth = 50

	build = ->
		it
			.attr {
				"cx": (it, i)-> (it.ttlidx % m.rectWidth) * 2 * (m.dtsr + m.margin)
				"cy": (it, i)-> ~~(it.ttlidx / m.rectWidth) * 2 * (m.dtsr + m.margin)
			}

	for let it of m
		build[it] = (v)-> 
			m[it] := v
			build

	build

