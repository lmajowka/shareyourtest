class Shareyourtest.Models.UserAnswer extends Backbone.Model
  url: ->
  	additional = if @get('id') then "/#{@get('id')}" else "" 
  	"/user_answers#{additional}"

  @rightAnswer: (question) ->
     question.answer is userAnswers[question.position-1].answer.position	