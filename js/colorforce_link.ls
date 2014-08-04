{lists-to-obj, join} = require "prelude-ls"

buildForce = ->

	f = {}
	f.dtsr = 3
	f.data = []
	# f.link = [
	# 	{source: 0, target: 1}
	# 	{source: 0, target: 2}
	# 	{source: 0, target: 3}
	# 	{source: 0, target: 4}
	# 	{source: 0, target: 5}
	# 	{source: 0, target: 6}
	# ]

	build = ->

		force = d3.layout.force!
			.nodes f.data
			.links []
			# f.link
			.gravity 0
			.charge 0
			.size [500, 500]
			.on "tick", tick

		function tick (it)
			k = 0.1 * it.alpha

			f.data.forEach (o, i)->
				o.y += (o.target.y - o.y) * k
				o.x += (o.target.x - o.x) * k

			q = d3.geom.quadtree f.data
			i = 0
			n = f.data.length

			while ++i < n
				q.visit collide f.data[i]

			node
				.attr {
					"cx": -> it.x
					"cy": -> it.y
				}

			# link
			# 	.attr {
			# 		"x1" : -> it.source.x
			# 		"y1" : -> it.source.y
			# 		"x2" : -> it.target.x
			# 		"y2" : -> it.target.y
			# 	}

		collide = ->
			r = f.dtsr
			nx1 = it.x - r
			nx2 = it.x + r
			ny1 = it.y - r
			ny2 = it.y + r

			(quad, x1, y1, x2, y2)->
				if quad.point && (quad.point is not it)
					x = it.x - quad.point.x
					y = it.y - quad.point.y
					l = Math.sqrt(x * x + y * y) 

					r = 2.5 * f.dtsr

					if l < r
						l = (l - r) / l * 0.5
						it.x -= x *= l
						it.y -= y *= l
						quad.point.x += x
						quad.point.y += y

				x1 > nx2 || x2 < nx1 || y1 > ny2 || y2 < ny1

		node = svg.selectAll "circle"
			.data f.data
			.enter!
			.append "circle"
			.attr {
				"class": -> it.name + " node"
				"r": f.dtsr
			}
			.style {
				"fill": -> it.color
			}
			.call force.drag
			.on "mouseenter", ->
			# 	# console.log "click"
				d3.selectAll join "," (it.name.split " ").map -> "." + it
					.transition!
					.duration 100
					.attr {
						"r": 10
					}
			.on "mouseout", -> 
				d3.selectAll join "," (it.name.split " ").map -> "." + it
					.transition!
					.duration 10
					.attr {
						"r": 3
					}


		# link = svg.selectAll "line"
		# 	.data f.link
		# 	.enter!
		# 	.append "line"
		# 	.attr {
		# 		"x1" : -> it.source.x
		# 		"y1" : -> it.source.y
		# 		"x2" : -> it.target.x
		# 		"y2" : -> it.target.y
		# 	}
		# 	.style {
		# 		"stroke": "red"
		# 	}

		force.start!

	["data" "dtsr"].map ->
		build[it]	:= (v)->  
			f[it] := v
			build


	build


ifNaN = -> if isNaN it then 0 else it

go = ->
	dt = gnh.cdata.clr_en.filter ->
		it.target = {}

		it.target.x = ifNaN (d3.hsl it.color).l * 600
		it.target.y = ifNaN (d3.hsl it.color).h


		true

	a = buildForce!.data dt
	a!