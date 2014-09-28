class Shareyourtest.Models.Question extends Backbone.Model

  _getContentRegex = /([\s\S]*)\W(A|a) ?\)/
  _getAlternativeRegex = /(A|a) ?\)([\s\S]*)/

  initialize: ->
    if @newQuestion()
      content = $('#question-content').val()
      @set 'content', Shareyourtest.Models.Question.getContent content
      @set 'answers', Shareyourtest.Views.Questions.answers
      @set 'answer', Shareyourtest.Views.Questions.answer
      @set 'exam_id', Shareyourtest.TestPage.test.get('id')

  url: ->
    "#{@get('exam_id')}/questions"

  newQuestion: ->
    if @get('content') then false else true

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



