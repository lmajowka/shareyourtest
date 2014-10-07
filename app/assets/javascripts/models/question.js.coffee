class Shareyourtest.Models.Question extends Backbone.Model

  _getContentRegex = /([\s\S]*)\W(A|a) ?\)/
  _getAlternativeRegex = /(A|a) ?\)([\s\S]*)/
  @validationError = ''

  initialize: ->

  url: ->
    additional = if @get('id') then "/#{@get('id')}" else "" 
    "#{@get('exam_id')}/questions#{additional}"

  newQuestion: ->
    if @get('content') then false else true

  valid: ->
    if not @get('content')
      @validationError = 'You need to write your question inside the box'
      return false

    if @get('answers').length < 2
      @validationError = 'You need to write at least 2 answers and choose one before you submit your questions'
      return false

    if not @get('answer')
      @validationError = 'You need to choose the right answer'
      return false

    @validationError = ""
    true

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



