class TestsPage

  @createQuestion: ->
    question = new Shareyourtest.Models.Question(
      {
        content:$('#question-content').val()
        answer: 1
      }
    )
    question.save()
#    question.render()

window.Shareyourtest.TestsPage = TestsPage