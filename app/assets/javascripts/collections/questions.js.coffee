class Shareyourtest.Collections.Questions extends Backbone.Collection
  url: ->
    "#{Shareyourtest.TestPage.testId()}/questions"

  model: Shareyourtest.Models.Question