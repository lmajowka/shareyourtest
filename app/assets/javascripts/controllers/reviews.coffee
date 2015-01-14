class Shareyourtest.Controllers.Reviews

  @create: ->
    review = new Shareyourtest.Models.Review(
      exam_id: Shareyourtest.TestPage.test.get('id')
      content: $('.review-text-area').val()
    )

    ga('send', 'event', 'content_creation', 'review', 'created')
    review.save(null,{
      success: ->
        location.href = location.href
    })
