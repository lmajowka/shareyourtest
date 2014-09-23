class Shareyourtest.Views.Questions extends Backbone.View

  template: JST['questions/index']

  events: {'click .delete':'delete'}

  render: ->
    @$el.html @template(@model.toJSON())

    answers = @model.get 'answers'
    for answer in answers
      span = document.createElement 'span'
      answerModel = new Shareyourtest.Models.Answer({content:answer.content})
      answerView = new Shareyourtest.Views.Answers({model:answerModel, el:span})
      @$el.append answerView.render().el
    @

  initialize: ->
    @model.on 'change', @render, @
    @model.on 'destroy', @remove, @

  delete: ->
    url_param = "#{@model.url()}/#{@model.get('id')}"
    @model.destroy(url: url_param)

  remove: ->
    @$el.remove()
