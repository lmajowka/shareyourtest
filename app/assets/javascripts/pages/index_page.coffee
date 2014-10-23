class IndexPage extends Page

  @initialize: ->
    $('#sign-up-now-button')[0].onclick = ->
      Shareyourtest.IndexPage.slideTo("background-hp4")
    $('#practice-button')[0].onclick = ->
      Shareyourtest.IndexPage.slideTo("background-hp3")


    $('a[href="/"]')[0].removeAttribute 'href'

  @slideTo: (frameId) ->
    @animate frameId , 0

window.Shareyourtest.IndexPage = IndexPage