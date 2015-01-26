
.PHONY: all sass jade coffee css html clean

all: html clean

sass:
	@if ! which sass > /dev/null; then echo "Sass not installed"; false; fi

jade:
	@if ! which jade > /dev/null; then echo "Jade not installed"; false; fi

coffee:
	@if ! which coffee > /dev/null; then echo "CoffeeScript not installed"; false; fi

css: sass src/cache-warmer.sass
	sass --unix-newlines --sourcemap=none src/cache-warmer.sass src/cache-warmer.css

html: css jade coffee src/cache-warmer.jade src/cache-warmer.coffee
	jade --pretty src
	mv src/cache-warmer.html http-cache-warmer.html

clean:
	rm src/cache-warmer.css
