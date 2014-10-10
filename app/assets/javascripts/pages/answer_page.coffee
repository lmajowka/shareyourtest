class AnswerPage

  @init: ->
  	@showQuestion(1)

  @showQuestion: (number) ->
    $('#answer-question-number').html(number)
    $('#answer-question-content').html(questions[number-1].content)	
    $.each($('.question-number-square'), (index,value) -> $(value).removeClass('question-number-square-current'))
    $('#question-number-square'+number).addClass('question-number-square-current')
    

window.Shareyourtest.AnswerPage = AnswerPage