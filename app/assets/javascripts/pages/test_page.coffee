class TestPage extends Page

  @questions = null

  @createQuestion: ->

    @question.save()

    @questions.add @question

    @updateQuestionView()

  @updateQuestionView: ->
    $("#menu-questions").click()
    $("#question-content").val ""
    Questions.generatePreview ""

  @question: ->
    content = $('#question-content').val()

    answers = []

    index = 1
    while alternative = Questions.getAlternative(content,index)
      answerObject = {content:alternative}
      answers.push answerObject
      index++

    question = new Shareyourtest.Models.Question(
      {
        content: Questions.getContent content
        answers: answers
        answer: 1
      }
    )

  @testId: ->
    location.href.match(/tests\/([0-9]+)/)?[1] || null

  @initialize: ->
    @questions = new Shareyourtest.Collections.Questions()

    events = ['sync','change','destroy']
    for event in events
      @questions.on event, Shareyourtest.TestPage.renderNumberQuestions
      @questions.on event, Shareyourtest.TestPage.questions.render

    Shareyourtest.TestPage.questions.fetch()
    $('#question-content')[0].style.height = $(window).height() - 300 + 'px'

    $("#menu-title").click =>
      @animate 'title-view', 60

    $("#menu-new-question").click =>
      @animate 'new-question-view', 60

    $("#menu-questions").click =>
      @animate 'questions-view', 160

    $("#menu-title").click()

  @displayMenuOptions: ->
    elements = ["#menu-questions","#menu-publish","#questions-view-title"]
    if Shareyourtest.TestPage.questions.length is 0
      for element in elements
        $(element).hide()
    else
      for element in elements
        $(element).show()

  @renderNumberQuestions: =>
    units = ['#number-questions','#menu-questions-number']
    for unit in units
      if numberQuestions = $ unit
        numberQuestions.html Shareyourtest.TestPage.questions.length;

    @displayMenuOptions()


window.Shareyourtest.TestPage = TestPage