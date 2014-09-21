class TestPage

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


window.Shareyourtest.TestPage = TestPage