{flatten} = require "prelude-ls"

buildList = ->
	m = {}
	m.dtsr = 3
	m.margin = 5
	m.type = "circle" #text

	m.limit = 300
	m.colw = 100

	build = ->

		if m.type is "circle"
			it
				.attr {
					"cx": (it, i)-> (m.colw / 3) + ~~(i / m.limit) * m.colw
					"cy": (it, i)-> (i % m.limit) * 2 * (m.dtsr + m.margin)
				}

		else if m.type is "text"
			it
				.attr {
					"x": (it, i)-> (m.colw / 3) + 10 + ~~(i / m.limit) * m.colw
					"y": (it, i)-> (i % m.limit) * 2 * (m.dtsr + m.margin) + 6
				}
				.style {
					"opacity": (it, i)-> if ~~((i + 1) / m.limit) < 5 then 0.3 else 0
				}


	for let it of m
		build[it] = (v)-> 
			m[it] := v
			build

	build