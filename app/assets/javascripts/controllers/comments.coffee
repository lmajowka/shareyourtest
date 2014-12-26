class Shareyourtest.Controllers.Comments

  @create: (commentable_type,commentable_id, callback) ->

    if $('#comment-text-area').val().length == 0
      $('#comment-error').html "Please, write down your comment"
      return

    @callback = callback
    comment = new Shareyourtest.Models.Comment(
      commentable_id: commentable_id,
      commentable_type: commentable_type,
      content: $('#comment-text-area').val()
    )

    comment.save(null,{
      success: (response) =>
        @callback(response)
    })
