class Shareyourtest.Models.UserAnswer extends Backbone.Model
  url: ->
  	additional = if @get('id') then "/#{@get('id')}" else "" 
  	"/user_answers#{additional}"

  @rightAnswer: (question) ->
     return false if not userAnswers[question.position-1]
     question.answer is userAnswers[question.position-1].answer.position	