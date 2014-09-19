class Questions

  _getContentRegex = /([\s\S]*)\W(A|a) ?\)/

  @generatePreview: (content) ->
    $('#preview-question-content').html @htmlize(@getContent(content))

  @getContent = (content) ->
    content.match(_getContentRegex)?[1] || content

  @htmlize = (content) ->
    content.replace(/\n/g,'<br>')


window.Questions = Questions