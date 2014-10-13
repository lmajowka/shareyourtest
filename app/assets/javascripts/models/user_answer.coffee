class Shareyourtest.Models.UserAnswer extends Backbone.Model
  url: ->
  	additional = if @get('id') then "/#{@get('id')}" else "" 
  	"/user_answers#{additional}"