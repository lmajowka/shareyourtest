class Shareyourtest.Views.Questions extends Backbone.View

  template: JST['questions/index']

  events: {'click .delete':'delete'}

  render: ->
    @$el.html @model.get('content') + "<div class='fr cp delete'>Delete</div>"
    @

  initialize: ->
    @model.on 'change', @render, @
    @model.on 'destroy', @remove, @

  delete: ->
    url_param = "#{@model.url()}/#{@model.get('id')}"
    @model.destroy(url: url_param)

  remove: ->
    @$el.remove()
