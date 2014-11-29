class Shareyourtest.MenuItem

  constructor: (@menuItemId, @cardId, @offset, @pageClass) ->
    $(@menuItemId).click =>
      Shareyourtest.MenuItem.selectMenu $(@menuItemId), @pageClass
      Shareyourtest[@pageClass].animate @cardId, @offset

  @selectMenu: (option, pageClass) ->
    options = Shareyourtest[pageClass].menuTitle.map((item) -> item.menuItemId)
    for opt in options
      $("#{opt}").removeClass 'menu-selected'
    option.addClass 'menu-selected'