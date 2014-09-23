class Shareyourtest.Views.Answers extends Backbone.View

  template: JST['answers/index']

  render: ->
    @$el.html @template(@model.toJSON())
    @
