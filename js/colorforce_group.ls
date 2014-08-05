{lists-to-obj, join, flatten, is-type} = require "prelude-ls"




buildForce = ->

	f = {}
	f.dtsr = 3
	f.data = []
	f.grpnm = []

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
				"class": -> it.name + " node " + it.group
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

		groupName = svg.selectAll ".groupName"
			.data f.grpnm
			.enter!
			.append "text"
			.attr {
				"x": -> it.x
				"y": -> it.y
				"class": -> "grpname grp" + it.name
			}
			.style {
				"text-anchor": "middle"
			}
			.text -> it.name


		force.start!

	for let it of f
		build[it] = (v)->  
			f[it] := v
			build


	build


go = ->

	col = 7
	posX = -> (it % (col + 1) + 0.5) * (gnh.w / (col + 1))
	posY = -> (~~(it / (col + 1)) + 0.5) * (gnh.w / (col + 1))

	grpnm = []
	dt = flatten(gnh.grpclr.clr_en.map (it, i)-> 
			grpnm.push {
				name: it.key
				x: (posX i)
				y: (posY i) + 50
			}

			r = it.value.map (c, j)->
				tmpc = {}
	
				for attr of c
					tmpc[attr]	= c[attr]
				
				tmpc.group = it.key
				tmpc.target = {}
				tmpc.target.x = posX i
				tmpc.target.y = posY i
	
				tmpc
	
			r)


	a = buildForce!.data dt .grpnm grpnm
	a!

hightlightGroup = (name)->
	if is-type "String" name
		d3.selectAll ".node:not(." + name + "), .grpname:not(.grp" + name + ")"
			.transition!
			.style {
				"opacity": 0.2
			}

		d3.selectAll "." + name + ", .grp" + name
			.transition!
			.style {
				"opacity": 1
			}

	else if is-type "Array" name
		d3.selectAll (".node" + join "" (name.map -> ":not(." + it + ")")) + (", .grpname" + (join "" (name.map -> ":not(.grp" + it + ")")))
			.transition!
			.style {
				"opacity": 0.2
			}

		d3.selectAll (join "," (name.map -> "." + it)) + ", " + (join "," (name.map -> ".grp" + it))
			.transition!
			.style {
				"opacity": 1
			}

move = ->
	svg
		.transition!
		.duration 1000
		.attr {
			"transform": "translate(" + gnh.margin.left + "," + -1000 + ")"
		}