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

