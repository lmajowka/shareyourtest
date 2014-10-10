window.Shareyourtest =
  Models: {}
  Collections: {}
  Controllers : {}
  Views: {}
  Routers: {}
  initialize: {}

$(document).ready ->
	Shareyourtest.signedIn = Boolean $.cookie("remember_token")

