describe 'Questions', ->

  describe 'Parser', ->
  example_content_1 = "How much is 2 + 2?
  a) 1
  b) 2"

  it 'Get content', ->
    parsedContent = Shareyourtest.Models.Question.getContent example_content_1
    expect(parsedContent).toEqual "How much is 2 + 2?"

  it 'Get first answer', ->
    parsedAnswer = Shareyourtest.Models.Question.getAlternative example_content_1, 1
    expect(parsedAnswer).toEqual "1"

  it 'Get second answer', ->
    parsedAnswer = Shareyourtest.Models.Question.getAlternative example_content_1, 2
    expect(parsedAnswer).toEqual "2"

  it 'Get null trying to get third answer', ->
    parsedAnswer = Shareyourtest.Models.Question.getAlternative example_content_1, 3
    expect(parsedAnswer).toBeNull()

  example_content_2 = "How much is 1 + 1? A)7"

  describe 'Uppercase letters', ->

    it 'Get content', ->
      parsedContent = Shareyourtest.Models.Question.getContent example_content_2
      expect(parsedContent).toEqual "How much is 1 + 1?"

    it 'Get first answer', ->
      parsedAnswer = Shareyourtest.Models.Question.getAlternative example_content_2, 1
      expect(parsedAnswer).toEqual "7"

    it 'Get null trying to get third answer', ->
      parsedAnswer = Shareyourtest.Models.Question.getAlternative example_content_2, 2
      expect(parsedAnswer).toBeNull()

  describe '#newQuestion', ->

    it 'should return false when called from an existing question', ->
      existingQuestion = new Shareyourtest.Models.Question({content:'Why I am an old question?'})
      expect(existingQuestion.newQuestion()).toBe false

    it 'should return true when called from a new question', ->
      setFixtures '<div id="question-content"></div>'
      newQuestion = new Shareyourtest.Models.Question()
      expect(newQuestion.newQuestion()).toBe true