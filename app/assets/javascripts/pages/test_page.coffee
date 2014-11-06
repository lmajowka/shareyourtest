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

  @displayRating:(id,rating) ->
    $(id).raty(
      readOnly: true
      score: rating
      path: '/assets'
    ) 

  @initialize: (id) ->
    $.cookie("last-test-page",location.href)
    @questions = new Shareyourtest.Collections.Questions()
    @test = new Shareyourtest.Models.Test({id: id, permalink: @getPerma()})
    
    events = ['sync','change','destroy']
    for event in events
      @questions.on event, Shareyourtest.TestPage.renderNumberQuestions
      @questions.on event, Shareyourtest.TestPage.questions.render

    @test.on 'sync', @displayMenuOptions

    @displayRating("#test-rating",averageRating)

    @questions.fetch()
    @test.fetch()

    if $('#question-content').length > 0
      $('#question-content')[0].style.height = $(window).height() - 284 + 'px'

    @menuTitle = []
    @menuTitle.push new MenuItem "#menu-title", 'title-view', 60
    @menuTitle.push new MenuItem "#menu-join-now", 'join-card', 60
    @menuTitle.push new MenuItem "#menu-example", 'example-card', 60
    @menuTitle.push new MenuItem "#menu-ranking", 'ranking-card', 60
    @menuTitle.push new MenuItem "#menu-questions", 'questions-view', 175
    @menuTitle.push new MenuItem "#menu-new-question", 'new-question-view', 98
    @menuTitle.push new MenuItem "#menu-settings", 'settings-view', 90

    $("#menu-publish").click =>
      @toggleStatus "published"

    $("#menu-unpublish").click =>
      @toggleStatus "draft"
    
    $("#menu-title").click()

  @saveAndRefresh: (property,value) ->
    Shareyourtest.TestPage.test.set property, value
    Shareyourtest.TestPage.test.save(null,{
      success: ->
        #location.href = location.href
    })

  @setCategory: (examCategoryId) ->
    @saveAndRefresh 'exam_category_id', examCategoryId

  @toggleStatus: (status) ->
    @saveAndRefresh 'status', status

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
      $("#menu-join-now").click()    

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
    
   
class MenuItem

  constructor: (@menuItemId, @cardId, @offset) ->   
    $(@menuItemId).click =>
      MenuItem.selectMenu $(@menuItemId)
      TestPage.animate @cardId, @offset

  @selectMenu: (option) ->
    options = Shareyourtest.TestPage.menuTitle.map((item) -> item.menuItemId)
    for opt in options
      $("#{opt}").removeClass 'menu-selected'
    option.addClass 'menu-selected'

window.Shareyourtest.TestPage = TestPage