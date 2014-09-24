class IndexPage extends Page

  @initialize: ->
    $('a[href="/"]')[0].href = 'javascript:Shareyourtest.IndexPage.slideTo("frame-index");'
    $('a[href="/tests"]')[0].href = 'javascript:Shareyourtest.IndexPage.slideTo("frame-answer")'
    $('a[href="/tests/new"]')[0].href = 'javascript:Shareyourtest.IndexPage.slideTo("frame-share");'
    Shareyourtest.IndexPage.slideTo("frame-index")


  @slideTo: (frameId) ->
    @animate frameId , 0

window.Shareyourtest.IndexPage = IndexPage