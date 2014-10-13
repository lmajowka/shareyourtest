class Shareyourtest.Views.Questions extends Backbone.View

  template: JST['questions/index']

  events: {
    'click .delete':'delete'
    'click .edit':'edit'
  }
  

  className: 'question-view-div w100'

  index = 1

  @answers = []
  @answer = false
  @updatingQuestion = null

  render: ->
    elementContent = @template(@model.toJSON())
    
    rightAnswer = @.model.get 'answer'
    answers = @model.get 'answers'
    answersIndex = 1
    for answer in answers
      answerModel = new Shareyourtest.Models.Answer({content:answer.content})
      answerView = new Shareyourtest.Views.Answers({model:answerModel})
      
      elementContent += '<span class="right-answer">' if answersIndex == rightAnswer
      elementContent += answerView.render().el.outerHTML
      elementContent += '</span>' if answersIndex == rightAnswer
      
      answersIndex++   

    elementContent += "<div class='cb'></div>"

    @$el.html elementContent
    @

  initialize: ->
    @model.on 'change', @render, @
    @model.on 'destroy', @remove, @

  delete: ->
    @model.destroy()

  edit: ->
    $('#new-question-view').show()
    $('#new-question-title').html "Edit question"
    $("#menu-new-question").click()
    $("#question-content").val @renderContent()  
    $('#create-question-error').html ""
    Shareyourtest.Views.Questions.generatePreview $("#question-content").val()
    $('#create-question-button').html "Save" 
    $('#create-question-button')[0].onclick =  Shareyourtest.Controllers.Questions.update
    Shareyourtest.Controllers.Questions.updatingQuestion = @model
    @checkAnswer @model.get('answer')
    Shareyourtest.Views.Questions.setAnswer @model.get('answer')

  checkAnswer: (answer) ->
    for radio in $('#preview-answers input')
      if radio.attributes['data-position'].value is answer.toString()
        radio.checked = true

  finishEditing: ->   
    $('#new-question-title').html "Create question"

  renderContent: ->
    content = @model.get 'content' 
    answers = @model.get 'answers'
    answersIndex = 1
    for answer in answers
      content += "\n" + String.fromCharCode(96 + answersIndex) + ")"
      content += answer.content
      answersIndex++
    content

  remove: ->
    @$el.remove()

  @setAnswer: (answer)->
    @answer = answer

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
    @setAnswer false
    $('#create-question-error').html ""

  @htmlize = (content) ->
    content.replace(/\n/g,'<br>')

  @radioTemplate: JST['answers/radio']

  @radialize = (content) ->
    if content.length > 0
      @radioTemplate(
        {
          content: content
          index: index
          callback: "Shareyourtest.Views.Questions.setAnswer(#{index})"
        }
      )
    else
      ""