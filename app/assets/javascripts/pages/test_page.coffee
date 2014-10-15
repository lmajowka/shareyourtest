class TestPage extends Page

  @questions = null
  @test = null   

  @resetQuestionContext: ->
    @updateQuestionView()
    Shareyourtest.Views.Questions.setAnswer false

  @updateQuestionView: ->
    $("#question-content").val ""
    Shareyourtest.Views.Questions.generatePreview ""
    $('#new-question-title').html "New question"
    $('#create-question-button').html "CREATE"
    $('#create-question-button')[0].onclick = Shareyourtest.Controllers.Questions.create

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
      $('#question-content')[0].style.height = $(window).height() - 284 + 'px'

    $("#menu-title").click =>
      @selectMenu($("#menu-title"))
      @animate 'title-view', 60

    $("#menu-questions").click =>
      @selectMenu($("#menu-questions"))
      @animate 'questions-view', 175

    $("#menu-new-question").click =>
      @selectMenu($("#menu-new-question"))
      @animate 'new-question-view', 98

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
    elements = ["#menu-new-question","#menu-publish","#new-question-card"]
    @showOrHide(Shareyourtest.TestPage.test.get('status') is "published", elements)
      
  @unpublishedFilter: ->
    elements = ["#menu-unpublish"]  
    @showOrHide(Shareyourtest.TestPage.test.get('status') is "draft", elements)

  @moreThanOneQuestionFilter: ->
    elements = ["#menu-questions","#menu-publish","#questions-view-card"]
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
        numberQuestions.html Shareyourtest.TestPage.questions.length

    @displayMenuOptions()

  @getPerma = ->
    location.href.match(/\/tests\/(.*)/)?[0] || ""  

  @answer: ->
    if Shareyourtest.signedIn
      @purchase()
    else 
      alert "To be developed"    

  @viewAttempt: (id) ->
    location.href = location.href.replace(/tests/,"answers") + "/" + id

  @purchase: ->
    $.ajax(
      type: "GET"
      url: "purchase"
      data: { id: @test.get('id') }
    )
    .done( 
      ( return_msg ) ->  
        if return_msg.status is "ok"
          location.href = location.href.replace(/tests/,"answers")
    )
    
   

window.Shareyourtest.TestPage = TestPage