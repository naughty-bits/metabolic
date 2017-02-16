module.exports =

	watch: !->
		@events = []

		for let name in it
			@[ name.replace /-./g -> it.1.to-upper-case! ] = !->
				@events.push "#name#{
					if &length > 0 then "(#{
						Array::slice.call & .to-string!
					})" else ''
				}"
