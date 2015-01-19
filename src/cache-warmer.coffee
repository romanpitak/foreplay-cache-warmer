urls = []
jQuery ->

    jQuery('form#parameters button').click () ->
        jQuery('form#parameters #start').val 1

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

    createIframe = () ->
        iframe = jQuery '<iframe>'
        jQuery('body').append iframe
        iframe.addClass 'loader free'
        iframe.load iframeOnLoad

    # Process parameters
    for queryParts in window.location.search.substring(1).split('&')
        [paramId, paramValue] = queryParts.split '='
        if '' != paramId
            jQuery('form#parameters #' + paramId).val decodeURIComponent paramValue

    # RUN
    if '1' == jQuery('form#parameters #start').val()

        # Create loader iframes
        for i in [1..jQuery('form#parameters #concurrency').val()]
            createIframe()

        # Show output table
        jQuery('table').removeClass 'hidden'

        # load sitemaps
        for sitemap in decodeURIComponent(jQuery('form#parameters #sitemaps').val()).split ' '
            jQuery.get sitemap, (data) ->
                jQuery('urlset url loc', data).each (i, e) -> urls.push jQuery(e).html().replace(/^.*\/\/[^\/]+/, '')
                jQuery('iframe.free').each (i, e) -> jQuery(e).load()
