module.exports = {
	locate ( it ) {
		it.address = it.address.toLowerCase()
	},

	translate ( it ) {
		it.source = LiveScript.compile( it.source, {
			bare: true,
			header: false,
			const: true
		})
	}
}
