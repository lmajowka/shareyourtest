class AnswerPage

  @currentQuestion = null
  @userAnswers = []

  @init: ->
  	@showQuestion 1
  	@adjustScreenSize()
    
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
    if userAnswers[@currentQuestion-1]
      @checkAnswer userAnswers[@currentQuestion-1].answer.position
    @setSquareCSS number
    @handleArrowsStatus number

  @createUserAnswer: (index) ->
    QuestionIndex = @currentQuestion-1
    @userAnswers[@currentQuestion] = @userAnswers[@currentQuestion] || new Shareyourtest.Models.UserAnswer(
      user_id: user_id
      purchase_id: purchase_id
      question_id: questions[QuestionIndex].id
      answer_id : questions[@currentQuestion-1].answers[index-1].id
      seconds: 0  
    ) 
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

window.Shareyourtest.AnswerPage = AnswerPage