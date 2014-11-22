class Shareyourtest.Models.Comment extends Backbone.Model
  url: ->
    additional = if @get('id') then "/#{@get('id')}" else ""
    "/comments#{additional}"