class Shareyourtest.Models.Question extends Backbone.Model
  url: ->
    "#{Shareyourtest.TestPage.testId()}/questions"

