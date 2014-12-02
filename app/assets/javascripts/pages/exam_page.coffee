class Shareyourtest.ExamPage extends Page
  @initialize: ->
    @menuTitle = []
    @menuTitle.push new Shareyourtest.MenuItem "#menu-title", 'title-view', 90, 'ExamPage'
    @menuTitle.push new Shareyourtest.MenuItem "#menu-tests", 'tests-view', 60, 'ExamPage'
    @menuTitle.push new Shareyourtest.MenuItem "#menu-info", 'info-view', 60, 'ExamPage'
    @menuTitle.push new Shareyourtest.MenuItem "#menu-sample", 'sample-view', 60, 'ExamPage'
    @menuTitle.push new Shareyourtest.MenuItem "#menu-calendar", 'calendar-view', 60, 'ExamPage'

    $("#menu-title").click()