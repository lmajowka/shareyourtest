describe 'Questions View', ->

  question = new Shareyourtest.Models.Question({
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