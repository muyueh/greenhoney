{lists-to-obj, join, flatten, is-type, take} = require "prelude-ls"

gnh.force = null
	
buildForce = ->

	# console.log "heelo"
	f = {}
	f.dtsr = 3
	f.data = []
	f.size = 800
	f.grpnm = []
	f.margin = 1.5
	f.targetFunc = ->
		it.target = {}
		it.target.x = f.posX it.grpidx
		it.target.y = f.posY it.grpidx
		true

	col = 9
	### This should be augmented to other func
	f.posX = -> (it % (col + 1) + 0.5) * (gnh.w / (col + 1))
	f.posY = -> (~~(it / (col + 1)) + 0.25) * (gnh.w / (col + 1))

	f.selector = "cdots"

	node = []


	


	function tick (it)
		# console.log it.alpha
		k = 1 * it.alpha

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
				"cx": -> ifNaN it.x
				"cy": -> ifNaN it.y
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

	build = ->
		# console.log f.data
		
		f.data := f.data.filter f.targetFunc

		gnh.force := d3.layout.force!
			.nodes f.data
			.links []
			.gravity 0
			.charge 0
			.size [f.size, f.size]
			.on "tick", tick


# TODO selector
		node := svg.selectAll "." + f.selector
			.data f.data
			.call gnh.force.drag

		svg.selectAll ".grp" + f.selector
			.data take 100 f.grpnm
			.enter!
			.append "text"
			.attr {
				"x": (it, i)-> f.posX i
				"y": (it, i)-> if i <= col then (f.posY i) + 55 else (f.posY i) + 40
				"class": -> "grp" + f.selector + " grp" + it
			}	
			.style {
				"text-anchor": "middle"
			}
			.text -> it

		gnh.force.start!
		gnh.force.stop!
		gnh.force.alpha 0.01 #use a much slower alpha

		
		


	for let it of f
		build[it] = (v)->  
			f[it] := v
			build

	build

# selector without class dots
hightlightGroup = (name, selector)->
	selector = selector or ".cdots"
	if is-type "String" name
		d3.selectAll "." + selector + ":not(.prm" + name + "), .grp" + selector +  ":not(.grp" + name + ")"
			.transition!
			.style {
				"opacity": 0.2
			}

		d3.selectAll ".prm" + name + ", .grp" + name
			.transition!
			.style {
				"opacity": 1
			}

	else if is-type "Array" name
		d3.selectAll ("." + selector + join "" (name.map -> ":not(.prm" + it + ")")) + (",.grp" + selector + (join "" (name.map -> ":not(.grp" + it + ")")))
			.transition!
			.style {
				"opacity": 0.2
			}

		d3.selectAll (join "," (name.map -> ".prm" + it)) + ", " + (join "," (name.map -> ".grp" + it))
			.transition!
			.style {
				"opacity": 1
			}

slideDown = ->
	svg
		.transition!
		.duration 1000
		.attr {
			"transform": "translate(" + gnh.margin.left + "," + -1000 + ")"
		}