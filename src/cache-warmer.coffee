urls = []
jQuery ->
    jQuery('iframe').load (event) ->
        element = jQuery(event.target)
        url = urls.shift();
        startTime = Date.now()
        out = jQuery 'table tbody'
        out.append jQuery '<tr id="' + startTime + '" class="loading"><td>' + url + '</td><td id="time"></td></li>'
        if 'undefined' != typeof element.data 'start'
            tr = jQuery('tr#' + element.data('start'), out)
            jQuery('#time', tr).text (startTime - element.data('start')) / 1000
            tr.removeClass 'loading'
        element.attr 'src', urls.shift()
        element.data 'start', startTime
    jQuery('#asdf').click ->
        jQuery.get '/sitemap.xml', (data) ->
            jQuery('urlset url loc', data).each (i, e) -> urls.push jQuery(e).html()
            jQuery('iframe').each (i, e) -> jQuery(e).load()
        false
