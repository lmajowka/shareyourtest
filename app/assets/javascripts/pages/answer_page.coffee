class AnswerPage

  @currentQuestion = null
  @userAnswers = []

  @finishScreenTemplate: JST['answers/finish_screen']  

  @init: ->
    @showQuestion 1
    @adjustScreenSize()
    @removeFinishButton()
    
  @removeFinishButton: ->
    if purchase_status is "answered"
      $('#finish-button').hide()

  @adjustScreenSize: ->
    $('#blank-answer-area')[0].style.height = $(window).height() - 184 + 'px'
    $('#question-panel')[0].style.height = $(window).height() - 144 + 'px'

  @showQuestion: (number) ->
    @currentQuestion = number
    QuestionIndex = number-1
    $('#answer-question-number').html(number)
    $('#answer-question-content').html(questions[QuestionIndex].content)	
    answersHTML = ""
    index = 1
    for answer in questions[QuestionIndex].answers
      answersHTML += Shareyourtest.Views.Answers.renderHTML(answer,index)
      index++ 	
    $('#answer-question-answers').html(answersHTML)
    if @userAnswers[@currentQuestion] 
      @checkAnswer @userAnswers[@currentQuestion].get('answer').position
    if userAnswers[QuestionIndex]
      @checkAnswer userAnswers[QuestionIndex].answer.position
    @setSquareCSS number
    @handleArrowsStatus number

  @createUserAnswer: (index) ->
    QuestionIndex = @currentQuestion-1
    @userAnswers[@currentQuestion] = @userAnswers[@currentQuestion] || new Shareyourtest.Models.UserAnswer(
      user_id: user_id
      purchase_id: purchase_id
      question_id: questions[QuestionIndex].id
      seconds: 0  
    ) 
    @userAnswers[@currentQuestion].set('answer_id',questions[@currentQuestion-1].answers[index-1].id)
    @userAnswers[@currentQuestion].save()

  @chooseAnswer: (index) ->
    @createUserAnswer index    
    @nextQuestion()    

  @checkAnswer: (index) ->
    $("#radio-answer-#{index}")[0].checked = true

  @nextQuestion: ->
    if @currentQuestion < questions.length
      @showQuestion(@currentQuestion+1)

  @prevQuestion: ->
    if @currentQuestion > 1
      @showQuestion(@currentQuestion-1)    
    
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

  @finish: ->
    purchase = new Shareyourtest.Models.Purchase(
      id: purchase_id
    )
    purchase.set('status','answered')
    purchase.on 'change', @finishScreen()
    purchase.save()

  @finishScreen: ->
    $('#finish-button').hide()
    viewURL = location.href + "/" + purchase_id
    $('#blank-answer-area').html @finishScreenTemplate(
      viewURL: viewURL
    )
    

window.Shareyourtest.AnswerPage = AnswerPage