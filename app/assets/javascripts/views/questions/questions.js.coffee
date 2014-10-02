class Shareyourtest.Views.Questions extends Backbone.View

  template: JST['questions/index']

  events: {'click .delete':'delete'}

  className: 'question-view-div w100'

  index = 1

  @answers = []
  @answer = false

  render: ->
    elementContent = @template(@model.toJSON())
    
    rightAnswer = @.model.get 'answer'
    answers = @model.get 'answers'
    answersIndex = 1
    for answer in answers
      answerModel = new Shareyourtest.Models.Answer({content:answer.content})
      answerView = new Shareyourtest.Views.Answers({model:answerModel})
      
      elementContent += '<b>' if answersIndex == rightAnswer
      elementContent += answerView.render().el.outerHTML
      elementContent += '</b>' if answersIndex == rightAnswer
      
      answersIndex++ 

    elementContent += "<div class='cb'></div>"

    @$el.html elementContent
    @

  initialize: ->
    @model.on 'change', @render, @
    @model.on 'destroy', @remove, @

  delete: ->
    url_param = "#{@model.url()}/#{@model.get('id')}"
    @model.destroy(url: url_param)

  remove: ->
    @$el.remove()

  @setAnswer: (answer)->
    @answer = answer

  @validateQuestion: ->
    if @answers.length < 2
      $('#create-question-error').html 'You need to write at least 2 answers and choose one before you submit your questions'
      return false

    if not @answer
      $('#create-question-error').html 'You need to choose the right answer'
      return false

    true

  @generatePreview: (content) ->

    $('#preview-question-content').html @htmlize(Shareyourtest.Models.Question.getContent(content))
    $('#question-content').val content.replace(/[^\n]a\)/,"\n\na\)")

    @answers = []
    previewAnswers = ""
    index = 1

    while alternative = Shareyourtest.Models.Question.getAlternative(content,index)
      previewAnswers += @radialize alternative
      answerObject = {content:alternative}
      @answers.push answerObject
      index++

    $('#preview-answers').html previewAnswers

  @htmlize = (content) ->
    content.replace(/\n/g,'<br>')

  @radioTemplate: JST['answers/radio']

  @radialize = (content) ->
    if content.length > 0
      @radioTemplate(
        {
          content: content
          index: index
        }
      )
    else
      ""