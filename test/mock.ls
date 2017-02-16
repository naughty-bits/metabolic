require! { Token }

/* TODO: add spy or mock for cursor property instead */
delete Token::cursor

module.exports = class extends Token
	!~> super do
		document.create-document-fragment!
			.append-child document.create-element \main

	keydown: -> false

	html: !->
		@input.parent-node
			..inner-HTML = it
			@input = ..parent-node.query-selector '[contenteditable]'

	@code = ( kind, text, edit ) ->
		"<code class=\"#kind\"#{
			if edit then ' contenteditable="true"' else ''
		}>#text</code>"
