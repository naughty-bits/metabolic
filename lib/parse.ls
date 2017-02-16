module.exports =

	translate: ( it = @input.parent-node.first-child ) !->
		lhs = @translate-term it
		it.next-sibling
			if ..? and ..class-name is \punct
				@evaluate ..text-content, lhs, @translate-term ..next-sibling

	translate-term: ->
		if not it?
				return

		if it.class-name is \alnum
			@evaluate it.text-content, @translate-term it.next-sibling
