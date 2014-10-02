class Shareyourtest.Views.Answers extends Backbone.View

  template: JST['answers/index']

  className: 'fl ml20 red'

  render: ->
    @$el.html @template(@model.toJSON())
    @
