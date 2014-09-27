class Shareyourtest.Models.Question extends Backbone.Model

  _getContentRegex = /([\s\S]*)\W(A|a) ?\)/
  _getAlternativeRegex = /(A|a) ?\)([\s\S]*)/
  index = 1

  @answers = []
  @answer = false


  initialize: ->
    if @newQuestion()
      content = $('#question-content').val()
      @set 'content', Shareyourtest.Models.Question.getContent content
      @set 'answers', Shareyourtest.Models.Question.answers
      @set 'answer', Shareyourtest.Models.Question.answer

  url: ->
    "#{Shareyourtest.TestPage.testId()}/questions"

  newQuestion: ->
    return true if not @get('content')

  @generatePreview: (content) ->

    $('#preview-question-content').html @htmlize(@getContent(content))
    $('#question-content').val content.replace(/[^\n]a\)/,"\n\na\)")

    @answers = []
    previewAnswers = ""
    index = 1

    while alternative = @getAlternative(content,index)
      previewAnswers += @radialize alternative
      answerObject = {content:alternative}
      @answers.push answerObject
      index++

    $('#preview-answers').html previewAnswers

  @setAnswer: (answer)->
    @answer = answer

  #Private

  @getContent = (content) ->
    content.match(_getContentRegex)?[1] || content

  @getAlternative = (content, index) ->
    content.match(@alternativeRegEx(index))?[2].trim() || content.match(@alternativeRegEx(index,true))?[2].trim() || null

  @alternativeRegEx = (index,full) ->
    lowerCaseLetter = String.fromCharCode(96 + index)
    upperCaseLetter = String.fromCharCode(64 + index)
    nextLower = String.fromCharCode(97 + index)
    nextUpper = String.fromCharCode(65 + index)
    additional = if full then '|$' else ""
    new RegExp(@optionsRegEx(upperCaseLetter,lowerCaseLetter)+'([\\s\\S]*)('+ @optionsRegEx(nextUpper,nextLower)+additional+')')

  @optionsRegEx = (upperCaseLetter,lowerCaseLetter) ->
    '('+upperCaseLetter+'|'+lowerCaseLetter+')'+' ?\\)'

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

