class AnswerPage

  @currentQuestion = null

  @init: ->
  	@showQuestion 1
  	@adjustScreenSize()
    
  @adjustScreenSize: ->
    $('#blank-answer-area')[0].style.height = $(window).height() - 184 + 'px'
    $('#question-panel')[0].style.height = $(window).height() - 144 + 'px'

  @showQuestion: (number) ->
    @currentQuestion = number
    $('#answer-question-number').html(number)
    $('#answer-question-content').html(questions[number-1].content)	
    answersHTML = ""
    for answer in questions[number-1].answers
      answersHTML += Shareyourtest.Views.Answers.renderHTML(answer) 	
    $('#answer-question-answers').html(answersHTML)
    @setSquareCSS number
    @handleArrowsStatus number

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
      console.log image
      #$("<img />").attr("src", image)

window.Shareyourtest.AnswerPage = AnswerPage