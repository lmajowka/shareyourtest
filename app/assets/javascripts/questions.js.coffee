class Questions

  _getContentRegex = /([\s\S]*)\W(A|a) ?\)/
  _getAlternativeRegex = /(A|a) ?\)([\s\S]*)/


  @generatePreview: (content) ->

    $('#preview-question-content').html @htmlize(@getContent(content))

    previewAnswers = ""
    index = 1
    while @getAlternative(content,index).length > 0
      previewAnswers += @radialize @getAlternative(content,index)
      index++

    $('#preview-answers').html previewAnswers

  #Private

  @getContent = (content) ->
    content.match(_getContentRegex)?[1] || content

  @getAlternative = (content, index) ->
     content.match(@alternativeRegEx(index))?[2] || content.match(@alternativeRegEx(index,true))?[2] || ""

  @alternativeRegEx: (index,full) ->
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

  @radialize = (content) ->
    if content.length > 0
      "<div><input type='radio'/> #{content}</div>"
    else
      ""

window.Questions = Questions