class Shareyourtest.Models.Review extends Backbone.Model
  url: ->
    additional = if @get('id') then "/#{@get('id')}" else ""
    "#{@get('exam_id')}/reviews#{additional}"