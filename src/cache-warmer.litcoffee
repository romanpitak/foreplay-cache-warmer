# Cache warmer

### Reload iframe

Whenever an iframe finishes loading, mark the result on the dashboard
and pop a new url from the list to load + create a new line on the dashboard.

This function must be bound to the iframe load event later in the code.

TODO: What if there are no more urls to load?

TODO: New dashboard line should contain link to the loading page.

    iframeOnLoad = (event) ->
        element = jQuery(event.target)
        element.removeClass 'free'
        url = urls.shift()
        startTime = Date.now()
        out = jQuery 'table tbody'
        out.append jQuery '<tr id="' + startTime + '" class="loading"><td>' + url + '</td><td id="time"></td></li>'
        if 'undefined' != typeof element.data 'start'
            tr = jQuery('tr#' + element.data('start'), out)
            jQuery('#time', tr).text (startTime - element.data('start')) / 1000
            tr.removeClass 'loading'
        element.attr 'src', urls.shift()
        element.data 'start', startTime

### Create loader iframes

Based on the concurrency settings, create the iframes and bound their
load events to the iframeOnLoad function.

    createLoaderIframes = ->
        for i in [1..jQuery('form#parameters #concurrency').val()]
            iframe = jQuery '<iframe>'
            jQuery('body').append iframe
            iframe.addClass 'loader free'
            iframe.load iframeOnLoad

### Form

Bind form submit to hidden parameters

    formSubmitBind = ->
        jQuery('form#parameters button').click () ->
            jQuery('form#parameters #start').val 1

Set form fields based on URI GET query parameters

    setFormFieldsFromGet = ->
        for queryParts in window.location.search.substring(1).split('&')
            [paramId, paramValue] = queryParts.split '='
            if '' != paramId
                jQuery('form#parameters #' + paramId).val decodeURIComponent paramValue

### Sitemaps

Download sitemaps, put them into urls and init iframes.

TODO: load multiple sitemaps

    loadSitemaps = ->
        for sitemap in decodeURIComponent(jQuery('form#parameters #sitemaps').val()).split ' '
            jQuery.get sitemap, (data) ->
                jQuery('urlset url loc', data).each (i, e) ->
                    urls.push jQuery(e).html().replace(/^.*\/\/[^\/]+/, '')
                jQuery('iframe.free').each (i, e) -> jQuery(e).load()


## RUN

Run on page load

    urls = []
    jQuery ->
        formSubmitBind()
        setFormFieldsFromGet()
        if '1' == jQuery('form#parameters #start').val()
            createLoaderIframes()
            jQuery('table').removeClass 'hidden'
            loadSitemaps()
