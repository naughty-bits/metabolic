insert = ( parent, next ) ->
	parent.insert-before ( document.create-element \code ), next

module.exports = class
	!~>
		@input = insert it
			..content-editable = true
			..focus!

		add-event-listener \keydown !~>
			if @keydown it.key
				it.prevent-default!

	length:~
		-> @input.text-content.length

	kind:~
		-> @input.class-name
		( it ) !->
			@input.class-name = it

	previous-kind:~
		-> @input.previous-sibling.class-name

	cursor:~
		-> get-selection! .get-range-at 0 .start-offset
		( it ) !->
			get-selection!
				..remove-all-ranges!
				..add-range do
					with document.create-range!
						..set-start @input.first-child, it

	insert: ( next, kind, text ) !->
		insert @input.parent-node, next
			..text-content = text
			..class-name = kind

	split: !->
		@input
			@insert .., @kind, ..text-content.slice 0 @cursor
			..text-content = ..text-content.slice @cursor
			if @length is 0
				..class-name = ''

	wedge: !->
		@input
			if @cursor > 0
				@insert .., @kind, ..text-content.slice 0 @cursor
			if @cursor < @length
				@insert ..next-sibling, @kind, ..text-content.slice @cursor
			..text-content = ''
			..class-name = ''

	/* TODO: a bit funky in that one node gets passed in twice, but a simple option for now */
	join: ( that, left, right ) !->
		@input
			cursor = left.text-content.length
			..text-content = left.text-content ++ right.text-content
			..class-name = that.class-name
			..parent-node.remove-child that
			@cursor = cursor

	join-left: !->
		@input
			if ..previous-sibling?
				@join that, that, ..

	join-right: !->
		@input
			if ..next-sibling?
				@join that, .., that

	shift: ( that, cursor ) !->
		@input.content-editable = \inherit
		@input = that
			..content-editable = true
		@cursor = cursor

	shift-left: !->
		if @input.previous-sibling?
			@shift that, that.text-content.length

	shift-right: !->
		if @input.next-sibling?
			@shift that, 0
