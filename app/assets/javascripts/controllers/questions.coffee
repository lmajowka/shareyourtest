class Questions

  @updatingQuestion = null

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

  @update: =>
    content = $('#question-content').val()

    @updatingQuestion.set 'content', Shareyourtest.Models.Question.getContent content
    @updatingQuestion.set 'answers', Shareyourtest.Views.Questions.answers
    @updatingQuestion.set 'answer', Shareyourtest.Views.Questions.answer 

    return if not @updatingQuestion.valid() 

    @updatingQuestion.save()
    Shareyourtest.TestPage.resetQuestionContext()

window.Shareyourtest.Controllers.Questions = Questions