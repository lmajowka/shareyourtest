class TestsPage

  @createQuestion: ->
    question = new Shareyourtest.Models.Question(
      {
        content:$('#question-content').val()
      }
    )
    question.save()

window.Shareyourtest.TestsPage = TestsPage