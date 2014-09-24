class Page

  @animate: (viewId,offset) ->
    $('html, body').animate(
      {
        scrollTop: $("#"+viewId).offset().top - offset
      }
      800
    )

window.Page = Page