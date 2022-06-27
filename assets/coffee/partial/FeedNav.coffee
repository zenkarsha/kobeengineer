class FeedNav

  constructor: ->
    @container = $('#feed')
    @sort = inputGet('sort')
    @author = inputGet('author')
    if @sort is '' then @sort = 'newest'
    if FEED.sorting[@sort] is undefined then @sort = 'newest'
    @initial()

  initial: =>
    FeedView.feed_nav.create FEED.sorting, @sort

FeedNav = new FeedNav
module.exports = FeedNav
