class Shareyourtest.Views.Answers extends Backbone.View

  template: JST['answers/index']

  className: 'fl ml20'

  render: ->
    @$el.html @template(@model.toJSON())
    @
