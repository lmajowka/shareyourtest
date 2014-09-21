class TestPage

  @questions = null

  @createQuestion: ->
    question = new Shareyourtest.Models.Question(
      {
        content:$('#question-content').val()
        answer: 1
      }
    )
    question.save()
#    question.render()

  @testId: ->
    location.href.match(/tests\/([0-9]+)/)?[1] || null

  @initialize: ->
    @questions = new Shareyourtest.Collections.Questions()

    events = ['sync','change']
    for event in events
      @questions.on event, Shareyourtest.TestPage.renderNumberQuestions

    Shareyourtest.TestPage.questions.fetch()

  @renderNumberQuestions: ->
    units = ['#number-questions','#menu-questions-number']
    for unit in units
      if numberQuestions = $ unit
        numberQuestions.html Shareyourtest.TestPage.questions.length;


window.Shareyourtest.TestPage = TestPage