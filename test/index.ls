require! { mocha, spec }

mocha
	..setup \exports
	..suite.emit \require, spec
	..run!
