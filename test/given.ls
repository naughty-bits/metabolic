require! { jsdiff: { diff-chars } }

class AssertionError extends Error
	!~>

module.exports = ( factory ) ->
	with: ( capture ) -> ( action ) ->
		expect: ( expected ) -> !->
			factory!
				action.call ..

				diff-chars ( JSON.stringify expected ), ( JSON.stringify capture.call .. )
					return if ..length is 1 and not ..0.added and not ..0.removed

					throw AssertionError! <<<
						html-message: ( * '' ) <| ..reduce ( html, it ) ->
							html
								..push "<span style=\"color: #{
									switch
									| it.added => \limegreen
									| it.removed => \red
									else \lightgrey
								}\">#{
									it.value .replace /</g, '&lt;' .replace />/g, '&gt;'
								}</span>"

						, []
