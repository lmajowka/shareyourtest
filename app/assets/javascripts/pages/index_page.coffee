class IndexPage

  @initialize: ->
    $('a[href="/"]')[0].href = 'javascript:Shareyourtest.IndexPage.slideTo("frame-index");'
    $('a[href="/tests"]')[0].href = 'javascript:Shareyourtest.IndexPage.slideTo("frame-answer")'
    $('a[href="/tests/new"]')[0].href = 'javascript:Shareyourtest.IndexPage.slideTo("frame-share");'


  @slideTo: (frameId) ->
    @animate frameId , 0

  @animate: (viewId,offset) ->
    $('html, body').animate(
      {
        scrollTop: $("#"+viewId).offset().top - offset
      }
      800
    )

window.Shareyourtest.IndexPage = IndexPage