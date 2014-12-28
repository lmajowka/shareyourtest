class AnswerPage

  @currentQuestion = null
  @currentQuestionNumber = null
  @userAnswers = []

  @finishScreenTemplate: JST['answers/finish_screen']  

  @init: ->
    @showQuestion 1
    @adjustScreenSize()
    @removeFinishButton()

  @addNewComment: (comment) ->
    Shareyourtest.AnswerPage.currentQuestion.comments.push comment.attributes
    Shareyourtest.AnswerPage.showComments()
    $('#comment-text-area').val("")


  @showComments: ->
    if purchase_status is "answered"
      $('#comment-form-container').show()
      $('#question-comments-container').html ""
      if @currentQuestion.comments.length == 0 then $('#question-comments').hide() else $('#question-comments').show()
      for comment in @currentQuestion.comments
        commentModel = new Shareyourtest.Models.Comment comment
        commentView = new Shareyourtest.Views.Comments(model: commentModel)
        $('#question-comments-container').append commentView.render().$el

  @removeFinishButton: ->
    if purchase_status is "answered"
      $('#finish-button').hide()
    else
      $('#close-button').hide()

  @adjustScreenSize: ->
    $('#blank-answer-area')[0].style.height = $(window).height() - 184 + 'px'
    $('#question-panel')[0].style.height = $(window).height() - 204 + 'px'

  @showQuestion: (number) ->
    @currentQuestionNumber = number
    questionIndex = number-1
    @currentQuestion = questions[questionIndex]
    
    $('#answer-question-number').html(number)
    $('#answer-question-content').html(@currentQuestion.content.replace(/\n/g,'<br/>'))
    answersHTML = ""
    index = 1
    for answer in @currentQuestion.answers
      if purchase_status is "answered" and @currentQuestion.answer is answer.position
        answersHTML += "<div class='right-answer-text'>"  
      answersHTML += Shareyourtest.Views.Answers.renderHTML(answer,index)
      if purchase_status is "answered" and @currentQuestion.answer is answer.position
        answersHTML += "</div>"
      index++ 	
    $('#answer-question-answers').html(answersHTML)
    
    if @userAnswers[@currentQuestionNumber] 
      @checkAnswer @userAnswers[@currentQuestionNumber].get('answer').position
    if userAnswers[questionIndex]
      @checkAnswer userAnswers[questionIndex].answer.position

    if purchase_status is "answered"
      $('input[type=radio]').each( (key,value) -> value.disabled = true ) 
      $('.preview-answer').removeClass('preview-answer')

    @setSquareCSS number
    @handleArrowsStatus number
    @questionNumberColor(questionIndex)
    @showComments()

  @questionNumberColor: (questionIndex) ->
    if purchase_status is "answered"
      if Shareyourtest.Models.UserAnswer.rightAnswer(questions[questionIndex])
        $('#answer-question-number').removeClass('wrong-answer-text')
        $('#answer-question-number').addClass('right-answer-text')
      else
        $('#answer-question-number').removeClass('right-answer-text')
        $('#answer-question-number').addClass('wrong-answer-text')
        

  @createUserAnswer: (index) ->
    @userAnswers[@currentQuestionNumber] = @userAnswers[@currentQuestionNumber] || new Shareyourtest.Models.UserAnswer(
      user_id: user_id
      purchase_id: purchase_id
      question_id: @currentQuestion.id
      seconds: 0  
    ) 
    @userAnswers[@currentQuestionNumber].set('answer_id',@currentQuestion.answers[index-1].id)
    @userAnswers[@currentQuestionNumber].save()

  @chooseAnswer: (index) ->
    @createUserAnswer index    
    @nextQuestion()    

  @checkAnswer: (index) ->
    $("#radio-answer-#{index}")[0].checked = true
    if purchase_status is "answered" and index isnt @currentQuestion.answer
      $("#content-answer-#{index}").addClass('wrong-answer-text')

  @nextQuestion: ->
    if @currentQuestionNumber < questions.length
      @showQuestion(@currentQuestionNumber+1)

  @prevQuestion: ->
    if @currentQuestionNumber > 1
      @showQuestion(@currentQuestionNumber-1)    
    
  @handleArrowsStatus: (number) ->
    if number is 1
      $('#arrow-prev').addClass("arrow-prev-question-disabled")
    else    
      $('#arrow-prev').removeClass("arrow-prev-question-disabled")

    if number is questions.length
      $('#arrow-next').addClass("arrow-next-question-disabled")
    else    
      $('#arrow-next').removeClass("arrow-next-question-disabled")      

  @setSquareCSS: (number) ->
    $.each($('.question-number-square'), (index,value) -> $(value).removeClass('question-number-square-current'))
    $('#question-number-square'+number).addClass('question-number-square-current')

  @preloadImages: (images) ->
    for image in images
      $("<img />").attr("src", image)

  @close: ->
    location.href = location.href.replace(/answers/,"tests").replace(/\/[0-9]+/,"")

  @finish: ->
    @purchase = new Shareyourtest.Models.Purchase(
      id: purchase_id
    )
    @purchase.set('status','answered')
    @purchase.on 'sync', @finishScreen
    @purchase.save()

  @finishScreen: ->
    $('#finish-button').hide()
    viewURL = location.href + "/" + purchase_id
    $('#blank-answer-area').html Shareyourtest.AnswerPage.finishScreenTemplate(
      viewURL: viewURL
      performance: (Shareyourtest.AnswerPage.purchase.get('performance') * 100)
      totalQuestions: questions.length
      rightQuestions: Shareyourtest.AnswerPage.userAnswers.filter( (userAnswer) -> userAnswer.get('status') == 'right' ).length
    )
    $('#user_star').raty(
      score: 0
      path: '/assets'
      click: (score, evt) ->
        $.ajax(
          url: '/ratings/'
          type: 'POST'
          data: { score: score , exam_id: exam_id}
        )
        $('#view-answers').show()
    )
    if rating
      $('#finish-screen-rating').hide()
      $('#view-answers').show()

window.Shareyourtest.AnswerPage = AnswerPage