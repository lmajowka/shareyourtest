class Shareyourtest.Models.Purchase extends Backbone.Model
  url: ->
  	additional = if @get('id') then "/#{@get('id')}" else "" 
  	"/users/#{user_id}/purchases#{additional}"