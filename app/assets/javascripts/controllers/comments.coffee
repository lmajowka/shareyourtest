class Shareyourtest.Controllers.Comments

  @create: (commentable_type,commentable_id) ->
    comment = new Shareyourtest.Models.Comment(
      commentable_id: commentable_id,
      commentable_type: commentable_type,
      content: $('#comment-text-area').val()
    )

    comment.save(null,{
      success: ->
        location.href = location.href
    })
