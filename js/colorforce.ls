{lists-to-obj } = require "prelude-ls"

buildForce = ->

	f = {}
	f.dtsr = 3
	f.data = []
	f.size = 800
	f.margin = 1.5
	f.targetFunc = ->
		it.target = {}
		it.target.x = 300
		it.target.y = 300

		true

	# console.log "hi"

	build = ->

		f.data := f.data.filter f.targetFunc

		console.log f.data.filter f.targetFunc

		force = d3.layout.force!
			.nodes f.data
			.links []
			.gravity 0
			.charge 0
			.size [f.size, f.size]
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

					r = 2 * f.dtsr + f.margin

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

	for let it of f
		build[it] = (v)-> 
			f[it] := v
			build


	build




# go = ->
# 	dt = gnh.clr.clr_en.filter ->
# 		it.target = {}
# 		# it.target.x = ifNaN (d3.hsl it.color).s * 5 + 200
# 		# it.target.x = ifNaN (d3.hsl it.color).s * 600

# 		# it.target.x = ifNaN (d3.hcl it.color).l * 10

# 		# it.target.x = ifNaN (d3.hsl it.color).h
# 		# it.target.y = ifNaN (d3.hsl it.color).s * 600

# 		# it.target.x = ifNaN (d3.hsl it.color).l * 600
# 		# it.target.y = ifNaN (d3.hsl it.color).s * 600

# 		it.target.x = ifNaN (d3.hsl it.color).l * 600
# 		it.target.y = ifNaN (d3.hsl it.color).h

# 		# it.target.x = ifNaN (d3.hsl it.color).l * 600
# 		# it.target.y = ifNaN (d3.hsl it.color).s * 600

# 		# it.target.x = ifNaN (d3.hsl it.color).l * 600
# 		# it.target.y = 100
# 			# 

# 		# it.target.x = 0
# 		# it.target.y = 0
	

# 		# clr = d3.hsl it.color
# 		# it.target.x = 250 + Math.cos((ifNaN clr.h) * Math.PI / 180 ) * 250 * ifNaN clr.l
# 		# it.target.y = 250 + Math.sin((ifNaN clr.h) * Math.PI / 180 ) * 250 * ifNaN clr.l

# 		# clr = d3.rgb it.color
# 		# it.target.x = clr.g * 1 + 50
# 		# it.target.y = clr.b * 1 + 50
# 		# 100


# 		# it.target.x = (ifNaN (d3.lab it.color).a + 100) * 2
# 		# it.target.y = (ifNaN (d3.lab it.color).b + 100) * 2


# 		# it.target.x = ifNaN (d3.hsl it.color).s * 400
# 		# 	# 100
# 		# it.target.y = ifNaN (d3.hsl it.color).h * 1.5
# 		# it.target.y = (d3.rgb it.color).r * 2 + 200
# 		# it.target.x = 100
# 		# 	# (d3.hsl it.color).l * 500
# 		# 	# 100
# 		# it.target.y = (d3.hsl it.color).s * 500
# 		true

# 	# dt = gnh.clr.clr_en.filter ->
# 	# 	it.target = {}
# 	# 	it.target.x = 100
# 	# 	it.target.y = 100
# 	# 	true

# 	a = buildForce!.data dt
# 	a!