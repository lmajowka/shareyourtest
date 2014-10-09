window.Shareyourtest =
  Models: {}
  Collections: {}
  Controllers : {}
  Views: {}
  Routers: {}
  initialize: {}

$(document).ready ->
	Shareyourtest.signed_in = Boolean $.cookie("remember_token")

