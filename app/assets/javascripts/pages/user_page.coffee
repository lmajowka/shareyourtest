class Shareyourtest.Pages.UserPage extends Page
  @editBio: ->
    $("#bio-input").show()
    $("#save-button").show()
    $("#bio-input-text").hide()
    $("#pencil-bio").hide()