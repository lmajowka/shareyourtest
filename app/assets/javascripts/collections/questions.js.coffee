class Shareyourtest.Collections.Questions extends Backbone.Collection
  model: Shareyourtest.Models.Question

  url: ->
    "#{Shareyourtest.TestPage.testId()}/questions"

  render: ->
    $('#questions-view').html ""
    @models.forEach @addOne, @

  addOne: (question) ->
    questionView = new Shareyourtest.Views.Questions({model: question})
    $('#questions-view').append questionView.render().el

