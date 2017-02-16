require! { given, Spy, Control }

once = given class implements Spy
	!~>
		@watch <[ split wedge join-left join-right shift-left shift-right ]>

	keydown: !->
		@cancel = Control.keydown.call @, it

.with ->
	cancel: @cancel
	kind: @kind
	events: @events

module.exports =

	digit:

		'after alnum': once !->
			@kind = \alnum
			@keydown \6
		.expect { -cancel, kind: \alnum, events: [] }

		'after punct': once !->
			@kind = \punct
			@keydown \6
		.expect { -cancel, kind: \alnum, events: <[ wedge ]> }

	upper:

		'after alnum': once !->
			@kind = \alnum
			@keydown \F
		.expect { -cancel, kind: \alnum, events: [] }

		'after punct': once !->
			@kind = \punct
			@keydown \F
		.expect { -cancel, kind: \alnum, events: <[ wedge ]> }

	lower:

		'after alnum': once !->
			@kind = \alnum
			@keydown \b
		.expect { -cancel, kind: \alnum, events: [] }

		'after punct': once !->
			@kind = \punct
			@keydown \b
		.expect { -cancel, kind: \alnum, events: <[ wedge ]> }

	punct:

		'after alnum': once !->
			@kind = \alnum
			@keydown \!
		.expect { -cancel, kind: \punct, events: <[ wedge ]> }

		'after punct': once !->
			@kind = \punct
			@keydown \!
		.expect { -cancel, kind: \punct, events: [] }

	space:

		'before text': once !->
			@cursor = 0
			@keydown ' '
		.expect { +cancel, events: [] }

		'after text': once !->
			@cursor = 3
			@keydown ' '
		.expect { +cancel, events: <[ split ]> }

	backspace:

		'before empty': once !->
			@cursor = 0
			@length = 0
			@kind = ''
			@previous-kind = \alnum
			@keydown \Backspace
			delete @kind
		.expect { +cancel, events: <[ join-left ]> }

		'before text between like kinds': once !->
			@cursor = 0
			@length = 3
			@kind = \alnum
			@previous-kind = \alnum
			@keydown \Backspace
			delete @kind
		.expect { +cancel, events: <[ join-left ]> }

		'before text between different kinds': once !->
			@cursor = 0
			@length = 3
			@kind = \alnum
			@previous-kind = \punct
			@keydown \Backspace
			delete @kind
		.expect { +cancel, events: <[ shift-left ]> }

		'after text': once !->
			@cursor = 3
			@keydown \Backspace
		.expect { -cancel, events: [] }

	'arrow left':

		'before empty': once !->
			@cursor = 0
			@length = 0
			@keydown \ArrowLeft
		.expect { +cancel, events: <[ join-left ]> }

		'before text': once !->
			@cursor = 0
			@length = 3
			@keydown \ArrowLeft
		.expect { +cancel, events: <[ shift-left ]> }

		'after text': once !->
			@cursor = 3
			@length = 3
			@keydown \ArrowLeft
		.expect { -cancel, events: [] }

	'arrow right':

		'after empty': once !->
			@cursor = 0
			@length = 0
			@keydown \ArrowRight
		.expect { +cancel, events: <[ join-right ]> }

		'before text': once !->
			@cursor = 0
			@length = 3
			@keydown \ArrowRight
		.expect { -cancel, events: [] }

		'after text': once !->
			@cursor = 3
			@length = 3
			@keydown \ArrowRight
		.expect { +cancel, events: <[ shift-right ]> }
