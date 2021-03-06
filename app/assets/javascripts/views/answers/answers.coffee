class Shareyourtest.Views.Answers extends Backbone.View

  template: JST['answers/index']
  @radioTemplate: JST['answers/radio']
  

  className: 'fl ml20 mt20 red'

  render: ->
    @$el.html @template(@model.toJSON())
    @

  @renderHTML: (answer,index) ->
    if answer.content.length > 0
      @radioTemplate(
        {
          content: answer.content
          index: index
          callback: "Shareyourtest.AnswerPage.chooseAnswer(#{index})"
        }
      )
    else
      ""  
