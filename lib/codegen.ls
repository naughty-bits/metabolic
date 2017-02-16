module.exports =

	evaluate: ( text, ...values ) ->
		prefix = ( text ) -> ->*
			yield text
			yield from values.0!

		infix = ( text ) -> ->*
			yield from values.0!
			yield text
			yield from values.1!

		switch text
		case \not
			prefix \!
		case \|
			infix \||
		case \&
			infix \&&
		case \=
			infix \===
		else
			->* yield that
