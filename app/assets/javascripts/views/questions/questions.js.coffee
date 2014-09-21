class Shareyourtest.Views.Questions extends Backbone.View

  #template: JST['questions/index']

  render: ->
    @$el.html @model.get('content')
    @
