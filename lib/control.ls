module.exports =

	keydown: ->
		switch it
		case ' '
			if @cursor > 0
				@split!
			true

		case [ \0 to \9 ], [ \A to \Z ], [ \a to \z ]
			if @kind is \punct
				@wedge!
			@kind = \alnum
			false

		case [ \! to \~ ]
			if @kind is \alnum
				@wedge!
			@kind = \punct
			false

		case \Backspace
			if @cursor is 0
				if @length is 0 or @kind is @previous-kind
					@join-left!
				else
					@shift-left!
				true
			else false

		case \ArrowLeft
			if @cursor is 0
				if @length is 0
					@join-left!
				else
					@shift-left!
				true
			else false

		case \ArrowRight
			if @cursor is @length
				if @length is 0
					@join-right!
				else
					@shift-right!
				true
			else false
