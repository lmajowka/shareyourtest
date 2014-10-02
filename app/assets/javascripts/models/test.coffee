class Shareyourtest.Models.Test extends Backbone.Model
  url: ->
    "#{@get('permalink')}"