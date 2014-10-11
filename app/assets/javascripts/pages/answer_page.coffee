class AnswerPage

  @init: ->
  	@showQuestion(1)
  	@adjustScreenSize()

  @adjustScreenSize: ->
  	$('#blank-answer-area')[0].style.height = $(window).height() - 184 + 'px'

  @showQuestion: (number) ->
    $('#answer-question-number').html(number)
    $('#answer-question-content').html(questions[number-1].content)	
    @setSquareCSS number  
    
  @setSquareCSS: (number) ->
    $.each($('.question-number-square'), (index,value) -> $(value).removeClass('question-number-square-current'))
    $('#question-number-square'+number).addClass('question-number-square-current')

window.Shareyourtest.AnswerPage = AnswerPage