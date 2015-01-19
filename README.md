# Http Cache Warmer

(c) 2015 Roman Piták, http://pitak.net <roman@pitak.net>

Universal **one-file cache warmer** (full-page sitemap crawler). Runs in the browser of your choice (JavaScript support required). 

- **one-file** container
- **one-button** interface
- **full page loading** (image cache warm-up)
- platform independent (runs in browser)

## Installation and usage

1. Copy the [http-cache-warmer.html](https://github.com/romanpitak/http-cache-warmer/blob/master/http-cache-warmer.html) file into your web project and run the url in the browser. 
2. Click the `/sitemap.xml` button 
3. Profit

### Local installation

If you don't want to or can't pollute your web with the extra file, you can setup [Nginx](http://nginx.com/) 
to act as a local proxy server. You only need the 
[http-cache-warmer.html](https://github.com/romanpitak/http-cache-warmer/blob/master/http-cache-warmer.html)
file and Nginx to make this work. 

```nginx
server {
    listen 54321;
    server_name localhost;
    root /path/to/http/cache/warmer;

    location / { try_files $uri $uri/ @backend; }

    location @backend { proxy_pass http://example.net; }
}
```

The http-cache-warmer will be available on http://localhost:54321/http-cache-warmer.html

## About

The script downloads the `/sitemap.xml` file from your server and loads all the urls in iframes until tender. 

Written in [jade](http://jade-lang.com/), [CoffeeScript](http://coffeescript.org/) and [Sass](http://sass-lang.com/).
