{lists-to-obj } = require "prelude-ls"

buildForce = ->

	f = {}
	f.dtsr = 3
	f.data = []

	build = ->

		force = d3.layout.force!
			.nodes f.data
			.links []
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

					r = 2 * f.dtsr

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
				"class": "node"
				"r": f.dtsr
			}
			.style {
				"fill": -> it.color
			}
			.call force.drag

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
		# it.target.x = ifNaN (d3.hsl it.color).s * 5 + 200
		# it.target.x = ifNaN (d3.hsl it.color).s * 600
		# it.target.x = ifNaN (d3.hsl it.color).l * 600
		# it.target.x = ifNaN (d3.hcl it.color).l * 10

		it.target.x = 0
		it.target.y = 0
		clr = d3.hsl it.color

		it.target.x = 250 + Math.cos((ifNaN clr.h) * Math.PI / 180 ) * 250 * ifNaN clr.s
		it.target.y = 250 + Math.sin((ifNaN clr.h) * Math.PI / 180 ) * 250 * ifNaN clr.s

		# it.target.x = (ifNaN (d3.lab it.color).a + 100) * 2
		# it.target.y = (ifNaN (d3.lab it.color).b + 100) * 2


		# it.target.x = ifNaN (d3.hsl it.color).s * 400
		# 	# 100
		# it.target.y = ifNaN (d3.hsl it.color).h * 1.5
		# it.target.y = (d3.rgb it.color).r * 2 + 200
		# it.target.x = 100
		# 	# (d3.hsl it.color).l * 500
		# 	# 100
		# it.target.y = (d3.hsl it.color).s * 500
		true

	# dt = gnh.cdata.clr_en.filter ->
	# 	it.target = {}
	# 	it.target.x = 100
	# 	it.target.y = 100
	# 	true

	a = buildForce!.data dt
	a!