
all: html clean

css: src/cache-warmer.sass
	sass --unix-newlines --sourcemap=none src/cache-warmer.sass src/cache-warmer.css

html: css src/cache-warmer.jade src/cache-warmer.coffee
	jade --pretty src
	mv src/cache-warmer.html http-cache-warmer.html

clean:
	rm src/cache-warmer.css
