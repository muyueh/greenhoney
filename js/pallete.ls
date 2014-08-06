buildPallete = ->
	m = {}
	m.cx = 250
	m.cy = 250
	m.cr = 250
	m.mdl = -> d3.hsl it
	m.mdlfx = "s"
	m.lightload = false

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

	for let it of m
		build[it] = (v)-> 
			m[it] := v
			build

	build

