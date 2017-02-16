require! { given, Mock, Spy, Parse }

{ code } = Mock

once = given class extends Mock implements Spy, Parse
	!~>
		super!
		@watch <[ evaluate ]>

		@evaluate
			@evaluate = ->
				.. ...
				&0

.with ->
	events: @events

module.exports =

	translate:

		'constant': once !->
			@html code \alnum \foo on
			@translate!
		.expect { events: <[ evaluate(foo,) ]> }

		'prefixed constant': once !->
			@html ( code \alnum \foo ) ++ ( code \alnum \buzz on )
			@translate!
		.expect { events: <[ evaluate(buzz,) evaluate(foo,buzz) ]> }

		'infixed constants': once !->
			@html ( code \alnum \foo ) ++ ( code \punct \= ) + ( code \alnum \buzz on )
			@translate!
		.expect { events: <[ evaluate(foo,) evaluate(buzz,) evaluate(=,foo,buzz) ]> }
