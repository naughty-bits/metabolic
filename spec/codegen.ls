require! { given, CodeGen }

once = given class
	!~>

	evaluate: !->
		@values = ( CodeGen.evaluate ... )!

.with ->
	values: until ( next = @values.next! ).done
		next.value

yielded = ( text ) ->
	->* yield text

module.exports =

	evaluate:

		boolean:

			'false': once !->
				@evaluate \false
			.expect { values: <[ false ]> }

			'true': once !->
				@evaluate \true
			.expect { values: <[ true ]> }

			'negate': once !->
				@evaluate \not yielded \true
			.expect { values: <[ ! true ]> }

			'disjoin': once !->
				@evaluate \| ( yielded \false ), ( yielded \true )
			.expect { values: <[ false || true ]> }

			'conjoin': once !->
				@evaluate \& ( yielded \false ), ( yielded \true )
			.expect { values: <[ false && true ]> }

		compare:

			'equal': once !->
				@evaluate \= ( yielded \false ), ( yielded \true )
			.expect { values: <[ false === true ]> }
