class TestPage extends Page

  @questions = null
  @test = null

  @saveEditedQuestion: ->
    return if not Shareyourtest.Views.Questions.validateQuestion() 

    @resetQuestionContext()    

  @resetQuestionContext: ->
    @updateQuestionView()
    Shareyourtest.Views.Questions.setAnswer false

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
      @selectMenu($("#menu-title"))
      @animate 'title-view', 60

    $("#menu-questions").click =>
      @selectMenu($("#menu-questions"))
      @animate 'questions-view', 180

    $("#menu-new-question").click =>
      @selectMenu($("#menu-new-question"))
      @animate 'new-question-view', 90

    $("#menu-settings").click =>
      @selectMenu($("#menu-settings"))
      @animate 'settings-view', 90

    $("#menu-publish").click =>
      @selectMenu($("#menu-publish"))
      @toggleStatus "published"

    $("#menu-unpublish").click =>
      @toggleStatus "draft"
    
    $("#menu-title").click()

  @selectMenu: (option) ->
    options =["menu-title","menu-questions","menu-new-question","menu-settings"]
    for opt in options
      $("##{opt}").removeClass 'menu-selected'
    option.addClass 'menu-selected'

  @toggleStatus: (status) ->
    Shareyourtest.TestPage.test.set('status',status)
    Shareyourtest.TestPage.test.save(null,{
      success: ->
        location.href = location.href
    })

  @displayMenuOptions: =>
    
    @moreThanOneQuestionFilter()      
    @publishedFilter()
    @unpublishedFilter()

    if Shareyourtest.TestPage.questions.length is 0
      $('#menu-publish').hide()

  @hideElements: (elements) ->
    for element in elements
        $(element).hide()    
      
  @showElements: (elements) ->
    for element in elements
        $(element).show()

  @publishedFilter: ->
    elements = ["#menu-new-question","#menu-publish","#new-question-view"]
    @showOrHide(Shareyourtest.TestPage.test.get('status') is "published", elements)
      
  @unpublishedFilter: ->
    elements = ["#menu-unpublish"]  
    @showOrHide(Shareyourtest.TestPage.test.get('status') is "draft", elements)

  @moreThanOneQuestionFilter: ->
    elements = ["#menu-questions","#menu-publish","#questions-view-title"]
    @showOrHide(Shareyourtest.TestPage.questions.length is 0, elements)    

  @showOrHide: (condition,elements) ->
    if condition  
      @hideElements elements 
    else 
      @showElements elements   

  @renderNumberQuestions: =>
    units = ['#number-questions','#menu-questions-number']
    for unit in units
      if numberQuestions = $ unit
        numberQuestions.html Shareyourtest.TestPage.questions.length;

    @displayMenuOptions()

  @getPerma = ->
    location.href.match(/\/tests\/(.*)/)?[0] || ""  

window.Shareyourtest.TestPage = TestPage