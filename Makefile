
.PHONY: all sass jade coffee js css html clean

all: html clean

sass:
	@if ! which sass > /dev/null; then echo "Sass not installed"; false; fi

jade:
	@if ! which jade > /dev/null; then echo "Jade not installed"; false; fi

coffee:
	@if ! which coffee > /dev/null; then echo "CoffeeScript not installed"; false; fi

js: coffee src/cache-warmer.litcoffee
	coffee --compile --no-header src/cache-warmer.litcoffee

css: sass src/cache-warmer.sass
	sass --unix-newlines --sourcemap=none src/cache-warmer.sass src/cache-warmer.css

html: js css jade src/cache-warmer.jade
	jade --pretty src
	mv src/cache-warmer.html http-cache-warmer.html

clean:
	rm src/cache-warmer.css src/cache-warmer.js
