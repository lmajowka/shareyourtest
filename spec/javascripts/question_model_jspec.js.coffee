describe 'Question Model', ->

  example_content_1 = "How much is 2 + 2?
      a) 1
      b) 2"

  describe '#getContent', ->

    it 'get the right content', ->
      parsedContent = Shareyourtest.Models.Question.getContent example_content_1
      expect(parsedContent).toEqual "How much is 2 + 2?"

  describe '#getAlternative', ->

    it 'get first answer', ->
      parsedAnswer = Shareyourtest.Models.Question.getAlternative example_content_1, 1
      expect(parsedAnswer).toEqual "1"

    it 'get second answer', ->
      parsedAnswer = Shareyourtest.Models.Question.getAlternative example_content_1, 2
      expect(parsedAnswer).toEqual "2"

    it 'get null trying to get third answer', ->
      parsedAnswer = Shareyourtest.Models.Question.getAlternative example_content_1, 3
      expect(parsedAnswer).toBeNull()

  describe 'Context - With uppercase letters', ->

    example_content_2 = "How much is 1 + 1? A)7"

    it '#getContent', ->
      parsedContent = Shareyourtest.Models.Question.getContent example_content_2
      expect(parsedContent).toEqual "How much is 1 + 1?"

    it '#getAlternative - get first answer', ->
      parsedAnswer = Shareyourtest.Models.Question.getAlternative example_content_2, 1
      expect(parsedAnswer).toEqual "7"

    it '#getAlternative - get null trying to get third answer', ->
      parsedAnswer = Shareyourtest.Models.Question.getAlternative example_content_2, 2
      expect(parsedAnswer).toBeNull()

  describe '#newQuestion', ->

    it 'should return false when called from an existing question', ->
      existingQuestion = new Shareyourtest.Models.Question({content:'Why I am an old question?'})
      expect(existingQuestion.newQuestion()).toBe false

    it 'should return true when called from a new question', ->
      setFixtures '<div id="question-content"></div>'
      test = new Shareyourtest.Models.Test({id:1})
      Shareyourtest.TestPage.test = test
      newQuestion = new Shareyourtest.Models.Question()
      expect(newQuestion.newQuestion()).toBe true


  describe '#valid', ->

    question = new Shareyourtest.Models.Question()

    it 'should return false for both invalid fields', ->
      expect(question.valid()).toBe false

     it 'should return false without the answers', ->
       question.set 'answer',1
       expect(question.valid()).toBe false

     it 'should return false without only 1 answer', ->
       question.set 'answers' , [{content:"a"}]
       expect(question.valid()).toBe false

     it 'should return true for valid fields', ->
       question.set 'answers' , [{content:"a"},{content:"b"}]
       question.set 'content', 'am I a valid question?'
       expect(question.valid()).toBe true    