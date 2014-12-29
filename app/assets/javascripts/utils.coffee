class Shareyourtest.Utils

  @timeSince: (date) ->
    seconds = Math.floor((new Date() - date) / 1000)
    interval = Math.floor(seconds / 31536000)

    if interval > 1
      return interval + " years"

    interval = Math.floor(seconds / 2592000)
    if interval > 1
      return interval + " months"

    interval = Math.floor(seconds / 86400)
    if interval > 1
      return interval + " days"

    interval = Math.floor(seconds / 3600)
    if interval > 1
      return interval + " hours"

    interval = Math.floor(seconds / 60)
    if interval > 1
      return interval + " minutes"

    Math.floor(seconds) + " seconds"


   @checkEvents: ->

     if $.cookie("new-user") is "true"
       ga('send', 'event', 'registration', 'user', 'registered')
       $.removeCookie('new-user', { path: '/' })

       #Facebook Conversion Code for registration
       (->
         _fbq = window._fbq || (window._fbq = [])
         if not _fbq.loaded
           fbds = document.createElement('script')
           fbds.async = true
           fbds.src = '//connect.facebook.net/en_US/fbds.js'
           s = document.getElementsByTagName('script')[0]
           s.parentNode.insertBefore(fbds, s)
           _fbq.loaded = true
       )()
       window._fbq = window._fbq || []
       window._fbq.push(['track', '6019982278768', {'value':'0.00','currency':'ILS'}])


     if $.cookie("new-test") is "true"
       ga('send', 'event', 'content_creation', 'test', 'created')
       $.removeCookie('new-test', { path: '/' })

     if $.cookie("new-question") is "true"
       ga('send', 'event', 'content_creation', 'question', 'created')
       $.removeCookie('new-question', { path: '/' })