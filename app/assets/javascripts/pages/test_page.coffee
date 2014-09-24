class TestPage extends Page

  @questions = null

  @createQuestion: ->

    return if not @validateQuestion()

    question = @question()
    question.save()
    @questions.add question

    @answer = false
    @updateQuestionView()

  @validateQuestion: ->
    if Shareyourtest.Models.Question.answers.length < 2
      $('#create-question-error').html 'You need to write at least 2 answers and choose one before you submit your questions'
      return false

    if not Shareyourtest.Models.Question.answer
      $('#create-question-error').html 'You need to choose the right answer'
      return false

    true

  @updateQuestionView: ->
    $("#menu-questions").click()
    $("#question-content").val ""
    Questions.generatePreview ""


  @question: ->
    content = $('#question-content').val()


    question = new Shareyourtest.Models.Question(
      {
        content: Shareyourtest.Models.Question.getContent content
        answers: Shareyourtest.Models.Question.answers
        answer: @answer
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