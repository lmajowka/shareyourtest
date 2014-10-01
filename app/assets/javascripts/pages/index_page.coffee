class IndexPage extends Page

  @initialize: ->
    $('a[href="/"]')[0].onclick = -> 
      Shareyourtest.IndexPage.slideTo("frame-index")
    $('a[href="/tests"]')[0].onclick = -> 
      Shareyourtest.IndexPage.slideTo("frame-answer")
    $('a[href="/tests/new"]')[0].onclick = -> 
      Shareyourtest.IndexPage.slideTo("frame-share")
    $('a[href="/frame-money"]')[0].onclick = -> 
      Shareyourtest.IndexPage.slideTo("frame-money")

    $('a[href="/"]')[0].href = '#'
    $('a[href="/tests"]')[0].href = '#'
    $('a[href="/tests/new"]')[0].href = '#'
    $('a[href="/frame-money"]')[0].href = '#'

  @slideTo: (frameId) ->
    @animate frameId , 0

window.Shareyourtest.IndexPage = IndexPage