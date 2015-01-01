window.Shareyourtest =
  Models: {}
  Collections: {}
  Controllers : {}
  Views: {}
  Routers: {}
  Pages: {}
  initialize: {}

$(document).ready ->
  Shareyourtest.signedIn = Boolean $.cookie("remember_token")
  Turbolinks.enableTransitionCache()
  Turbolinks.enableProgressBar()
  Shareyourtest.Utils.checkEvents()