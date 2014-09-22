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
    @questions.add question
    $("#menu-questions").click()
    $("#question-content").val ""
    Questions.generatePreview ""

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

    $("#menu-new-question").click =>
      @animate 'new-question-view', 60

    $("#menu-questions").click =>
      @animate 'questions-view', 120

  @animate: (viewId,offset) ->
    $('html, body').animate(
      {
        scrollTop: $("#"+viewId).offset().top - offset
      }
      800
    )

  @renderNumberQuestions: ->
    units = ['#number-questions','#menu-questions-number']
    for unit in units
      if numberQuestions = $ unit
        numberQuestions.html Shareyourtest.TestPage.questions.length;


window.Shareyourtest.TestPage = TestPage