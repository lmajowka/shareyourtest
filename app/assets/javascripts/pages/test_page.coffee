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
    $('html, body').animate({ scrollTop: $('.question-view-div').last().offset().top }, 800 )

  @displayRating:(id,rating) ->
    $(id).raty(
      readOnly: true
      score: rating
      path: '/assets'
    ) 

  @initialize: (id) ->
    $.cookie("last-test-page",location.href)
    @test = new Shareyourtest.Models.Test({id: id, permalink: @getPerma()})

    if myExam
      @questions = new Shareyourtest.Collections.Questions()
      events = ['sync','change','destroy']
      for event in events
        @questions.on event, Shareyourtest.TestPage.renderNumberQuestions
        @questions.on event, Shareyourtest.TestPage.questions.render
      @questions.fetch()

    @test.on 'sync', @displayMenuOptions

    @displayRating("#test-rating",averageRating)

    @test.fetch()

    if $('#question-content').length > 0
      $('#question-content')[0].style.height = $(window).height() - 284 + 'px'

    @menuTitle = []
    @menuTitle.push new Shareyourtest.MenuItem "#menu-title", 'title-view', 60, 'TestPage'
    @menuTitle.push new Shareyourtest.MenuItem "#menu-join-now", 'join-card', 60, 'TestPage'
    @menuTitle.push new Shareyourtest.MenuItem "#menu-example", 'example-card', 60, 'TestPage'
    @menuTitle.push new Shareyourtest.MenuItem "#menu-ranking", 'ranking-card', 60, 'TestPage'
    @menuTitle.push new Shareyourtest.MenuItem "#menu-reviews", 'reviews-card', 60, 'TestPage'
    @menuTitle.push new Shareyourtest.MenuItem "#menu-questions", 'questions-view', 175, 'TestPage'
    @menuTitle.push new Shareyourtest.MenuItem "#menu-new-question", 'new-question-view', 98, 'TestPage'
    @menuTitle.push new Shareyourtest.MenuItem "#menu-settings", 'settings-view', 90, 'TestPage'

    $("#menu-publish").click =>
      ga('send', 'event', 'finish', 'test', 'published')
      @toggleStatus "published"

    $("#menu-unpublish").click =>
      @toggleStatus "draft"
    
    $("#menu-title").click()

    $('#form-category select')[0]?.onchange = ->
      Shareyourtest.TestPage.setCategory $('#form-category select').val()

  @saveAndRefresh: (property,value) ->
    Shareyourtest.TestPage.test.set property, value
    Shareyourtest.TestPage.test.save(null,{
      success: ->
        location.href = location.href
    })

  @setCategory: (examCategoryId) ->
    @saveAndRefresh 'exam_category_id', examCategoryId

  @toggleStatus: (status) ->
    @saveAndRefresh 'status', status

  @displayMenuOptions: =>
    
    @moreThanOneQuestionFilter()      
    @publishedFilter()
    @unpublishedFilter()

    if not myExam or Shareyourtest.TestPage.questions.length is 0
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
    @showOrHide( myExam && Shareyourtest.TestPage.questions.length is 0, elements)

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
      $("#menu-join-now").click()    

  @viewAttempt: (id) ->
    location.href = location.href.replace(/tests/,"answers") + "/" + id

  @purchase: ->
    ga('send', 'event', 'answer', 'test', 'click_answer')
    $.ajax(
      type: "GET"
      url: "purchase?#{parseInt(Math.random()*1000000)}"
      data: { id: @test.get('id') }
    )
    .done( 
      ( return_msg ) ->  
        #if return_msg.status is "ok"
        location.href = location.href.replace(/tests/,"answers")
        #else
    )   #location.href = location.href.replace(/tests/,"purchases")


  @questionHelp: ->
    alert "Separate your questions using letters and parenthesis, Example:\n a) Answer 1 \n b) Answer 2 \n c) Answer 3"

window.Shareyourtest.TestPage = TestPage