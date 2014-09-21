class Shareyourtest.Collections.Questions extends Backbone.Collection
  url: ->
    "#{Shareyourtest.TestPage.testId()}/questions"

  render: ->
    $('#questions-view').html ""
    @models.forEach @addOne, @

  addOne: (question) ->
    questionView = new Shareyourtest.Views.Questions({model: question})
    $('#questions-view').append questionView.render().el

  model: Shareyourtest.Models.Question