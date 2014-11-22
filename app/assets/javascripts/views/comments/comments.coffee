class Shareyourtest.Views.Comments extends Backbone.View
  template: JST['comments/index']

  render: ->
    @$el.html @template(@model.toJSON())
    @