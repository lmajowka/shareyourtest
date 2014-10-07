class Questions

  @create: ->

    content = $('#question-content').val()

    question = new Shareyourtest.Models.Question(
      content: Shareyourtest.Models.Question.getContent content
      answers: Shareyourtest.Views.Questions.answers
      answer: Shareyourtest.Views.Questions.answer
      exam_id: Shareyourtest.TestPage.test.get('id')
    )

    if question.valid()
      $('#create-question-error').html ""
    else
      $('#create-question-error').html question.validationError
      return false  

    question.save()
    Shareyourtest.TestPage.questions.add question
    Shareyourtest.TestPage.resetQuestionContext()	

  @update: ->
    return if not Shareyourtest.Views.Questions.validateQuestion() 

    @resetQuestionContext() 

window.Shareyourtest.Controllers.Questions = Questions