class Shareyourtest.TestIndexPage extends Page

  @goSearch: (event) ->
    if event.which == 13 || event.keyCode == 13
      search_string = $('#search-input').val().toLowerCase().replace(/[ ]+/g,'-').replace(/[^\w-]+/g,'')
      location.href = "/tests-search/#{search_string}"