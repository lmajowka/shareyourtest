class TestPage extends Page

  @questions = null
  @test = null

  @createQuestion: ->

    return if not Shareyourtest.Views.Questions.validateQuestion()

    question = new Shareyourtest.Models.Question()
    question.save()

    @questions.add question

    @answer = false
    @updateQuestionView()

  @updateQuestionView: ->
    $("#menu-questions").click()
    $("#question-content").val ""
    Shareyourtest.Views.Questions.generatePreview ""

  @initialize: (id) ->
    @questions = new Shareyourtest.Collections.Questions()
    @test = new Shareyourtest.Models.Test({id: id, permalink: @getPerma()})
    
    events = ['sync','change','destroy']
    for event in events
      @questions.on event, Shareyourtest.TestPage.renderNumberQuestions
      @questions.on event, Shareyourtest.TestPage.questions.render

    @test.on 'sync', @displayMenuOptions

    @questions.fetch()
    @test.fetch()

    if $('#question-content').length > 0
      $('#question-content')[0].style.height = $(window).height() - 300 + 'px'

    $("#menu-title").click =>
      @animate 'title-view', 60

    $("#menu-new-question").click =>
      @animate 'new-question-view', 90

    $("#menu-questions").click =>
      @animate 'questions-view', 160

    $("#menu-settings").click =>
      @animate 'settings-view', 90

    $("#menu-publish").click =>
      Shareyourtest.TestPage.test.set('status',"published")
      Shareyourtest.TestPage.test.save(null,{
        success: ->
          location.href = location.href
      })

    

  @displayMenuOptions: ->
    elements = ["#menu-questions","#menu-publish","#questions-view-title"]
    if Shareyourtest.TestPage.questions.length is 0
      for element in elements
        $(element).hide()
    else
      for element in elements
        $(element).show()

    statusElements =  ["#menu-new-question","#menu-publish"]
    if Shareyourtest.TestPage.test.get('status') is "published"
      for element in statusElements
        $(element).hide()
    else
      for element in statusElements
        $(element).show()

    if Shareyourtest.TestPage.questions.length is 0
      $('#menu-publish').hide()

  @renderNumberQuestions: =>
    units = ['#number-questions','#menu-questions-number']
    for unit in units
      if numberQuestions = $ unit
        numberQuestions.html Shareyourtest.TestPage.questions.length;

    @displayMenuOptions()

  @getPerma = ->
    location.href.match(/\/tests\/(.*)/)?[0] || ""  

window.Shareyourtest.TestPage = TestPage