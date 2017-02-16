require! { given, Mock }

{ code } = Mock

once = given Mock

.with ->
	html: @input.parent-node.inner-HTML
	cursor: @cursor

module.exports =

	split:

		'after text': once !->
			@html code \alnum \foo on
			@cursor = 3
			@split!
			delete @cursor
		.expect { html: ( code \alnum \foo ) ++ ( code '' '' on ) }

		'in between': once !->
			@html code \alnum \foobuzz on
			@cursor = 3
			@split!
			delete @cursor
		.expect { html: ( code \alnum \foo ) ++ ( code \alnum \buzz on ) }

	wedge:

		'before text': once !->
			@html ( code \alnum \foo ) ++ ( code \alnum \buzz on )
			@cursor = 0
			@wedge!
			delete @cursor
		.expect { html: ( code \alnum \foo ) ++ ( code '' '' on ) ++ ( code \alnum \buzz ) }

		'after text': once !->
			@html code \alnum \foo on
			@cursor = 3
			@wedge!
			delete @cursor
		.expect { html: ( code \alnum \foo ) ++ ( code '' '' on ) }

		'in between': once !->
			@html code \alnum \foobuzz on
			@cursor = 3
			@wedge!
			delete @cursor
		.expect { html: ( code \alnum \foo ) ++ ( code '' '' on ) ++ ( code \alnum \buzz ) }

	'join left':

		'at top': once !->
			@html code \alnum \foo on
			@join-left!
		.expect { html: code \alnum \foo on }

		'before empty': once !->
			@html ( code \alnum \foo ) ++ ( code '' '' on )
			@join-left!
		.expect { html: ( code \alnum \foo on ), cursor: 3 }

		'in between': once !->
			@html ( code \alnum \foo ) ++ ( code \alnum \buzz on )
			@join-left!
		.expect { html: ( code \alnum \foobuzz on ), cursor: 3 }

	'join right':

		'at bottom': once !->
			@html code \alnum \foo on
			@cursor = 3
			@join-right!
		.expect { html: ( code \alnum \foo on ), cursor: 3 }

		'after empty': once !->
			@html ( code '' '' on ) ++ ( code \alnum \foo )
			@join-right!
		.expect { html: ( code \alnum \foo on ), cursor: 0 }

		'in between': once !->
			@html ( code \alnum \foo on ) ++ ( code \alnum \buzz )
			@join-right!
		.expect { html: ( code \alnum \foobuzz on ), cursor: 3 }

	'shift left':

		'at top': once !->
			@html code \alnum \foo on
			@cursor = 0
			@shift-left!
		.expect { html: ( code \alnum \foo on ), cursor: 0 }

		/* NOTE: make sure tokens start with different lengths */
		'in between': once !->
			@html ( code \alnum \foo ) ++ ( code \alnum \buzz on )
			@shift-left!
		.expect { html: ( code \alnum \foo on ) ++ ( code \alnum \buzz ), cursor: 3 }

	'shift right':

		/* NOTE: make sure tokens start with different lengths */
		'in between': once !->
			@html ( code \alnum \foo on ) ++ ( code \alnum \buzz )
			@shift-right!
		.expect { html: ( code \alnum \foo ) ++ ( code \alnum \buzz on ), cursor: 0 }

		'at bottom': once !->
			@html code \alnum \foo on
			@cursor = 3
			@shift-right!
		.expect { html: ( code \alnum \foo on ), cursor: 3 }
