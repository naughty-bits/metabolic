const cdnjs = '//cdnjs.cloudflare.com/ajax/libs'

for ( const src of [
	'livescript/1.5.0/livescript-min.js',
	'systemjs/0.20.7/system.js'
] ) {
	const script = document.createElement( 'script' )
	script.src = `${cdnjs}/${src}`
	document.body.appendChild( script )
}

addEventListener( 'load', () => {
	LiveScript = require( 'livescript' )

	SystemJS.config({
		baseURL: '../lib',
		map: {
			mocha: `${cdnjs}/mocha/3.2.0/mocha.min.js`,
			jsdiff: `${cdnjs}/jsdiff/3.2.0/diff.min.js`,
			load: '../load.js',
			given: '../test/given',
			expect: '../test/expect',
			Mock: '../test/mock',
			Spy: '../test/spy',
			spec: '../spec',
			Metabolic: 'index'
		},
		meta: {
			mocha: { format: 'global', exports: 'mocha' },
			'*.ls': { loader: 'load' }
		},
		packages: {
			'../app': { defaultExtension: 'ls', main: 'index' },
			'../lib': { defaultExtension: 'ls', main: 'index' },
			'../spec': { defaultExtension: 'ls', main: 'index' },
			'../test': { defaultExtension: 'ls', main: 'index' }
		}
	})

	SystemJS.import( './index.ls' )
})
