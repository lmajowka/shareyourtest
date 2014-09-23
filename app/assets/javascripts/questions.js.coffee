class Questions

  _getContentRegex = /([\s\S]*)\W(A|a) ?\)/
  _getAlternativeRegex = /(A|a) ?\)([\s\S]*)/


  @generatePreview: (content) ->

    $('#preview-question-content').html @htmlize(@getContent(content))
    $('#question-content').val content.replace(/[^\n]a\)/,"\n\na\)")

    previewAnswers = ""
    index = 1
    while alternative = @getAlternative(content,index)
      previewAnswers += @radialize alternative
      index++

    $('#preview-answers').html previewAnswers

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
      @radioTemplate(content)
    else
      ""

window.Questions = Questions