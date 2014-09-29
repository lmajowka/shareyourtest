describe 'Questions View', ->

  beforeEach ->
    jasmine.Ajax.install()

  afterEach ->
    jasmine.Ajax.uninstall()

  question = new Shareyourtest.Models.Question({
    id: 1
    exam_id: 4
    content:"What is a sample question?"
    answers:[{content:"a"},{content:"b"}]
    position:1
  })
  questionView = new Shareyourtest.Views.Questions(model:question)
  renderedContent = questionView.render().el.innerHTML

  describe '#render', ->

    it 'should render position number', ->
      expect(renderedContent).toMatch(/question-number">1</)

    it 'should render content', ->
      expect(renderedContent).toMatch(/What is a sample question?/)

    it 'should render answers', ->
      expect(renderedContent).toMatch(/>a/)
      expect(renderedContent).toMatch(/>b/)

  describe '#delete', ->

    it 'should destroy the model', ->

      question.save()
      questionView.delete()

      expect(jasmine.Ajax.requests.mostRecent().url).toBe '4/questions/1'

  describe '#validateQuestion', ->

    it 'should return false for both invalid fields', ->
      expect(Shareyourtest.Views.Questions.validateQuestion()).toBe false

    it 'should return false without the answers', ->
      Shareyourtest.Views.Questions.answer = 1
      expect(Shareyourtest.Views.Questions.validateQuestion()).toBe false

    it 'should return false without only 1 answer', ->
      Shareyourtest.Views.Questions.answers = [{content:"a"}]
      expect(Shareyourtest.Views.Questions.validateQuestion()).toBe false

    it 'should return true for valid fields', ->
      Shareyourtest.Views.Questions.answer = 1
      Shareyourtest.Views.Questions.answers.push {content:"b"}

      expect(Shareyourtest.Views.Questions.validateQuestion()).toBe true
