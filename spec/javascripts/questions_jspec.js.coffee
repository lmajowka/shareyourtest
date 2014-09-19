describe 'Questions', ->

  describe 'Parser', ->
  example_content_1 = "How much is 2 + 2?
  a) 1
  b) 2"

  it 'Get content', ->
    parsedContent = Questions.getContent example_content_1
    expect(parsedContent).toEqual "How much is 2 + 2?"

  it 'Get first answer', ->
    parsedAnswer = Questions.getAlternative example_content_1, 1
    expect(parsedAnswer).toEqual "1"

  it 'Get second answer', ->
    parsedAnswer = Questions.getAlternative example_content_1, 2
    expect(parsedAnswer).toEqual "2"

  it 'Get null trying to get third answer', ->
    parsedAnswer = Questions.getAlternative example_content_1, 3
    expect(parsedAnswer).toBeNull()