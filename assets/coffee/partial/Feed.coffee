class Feed

  constructor: ->
    @container = $('#feed')
    @loading = $('.loading-progress')
    @url = API_URL + 'feed'
    @author_url = API_URL + 'feed/author'
    @sort = inputGet('sort', 'newest')
    if FEED.sorting[@sort] is undefined then @sort = 'newest'
    @author = inputGet('author')
    @current_page = 1
    @total_page = 1
    @ranking_count = 1
    @loadPage()
    @bind()

  loadPage: =>
    @loading.show()
    if @author isnt ''
      get @author_url, @callback, { author: @author, page: @current_page }
    else
      get @url, @callback, { sort: @sort, page: @current_page }

  callback: (response) =>
    @loading.hide()
    if response.success
      @total_page = response.data.total_page
      if @author isnt ''
        FeedView.feed.create response.data.posts, @author
      else
        if @sort is 'newest'
          FeedView.feed.create response.data.posts
        else
          FeedView.feed.create_ranking response.data.posts, @ranking_count
          @ranking_count += response.data.posts.length
    else
      View.message.failed @container

  bind: =>
    $(window).scroll =>
      if $(window).scrollTop() + $(window).height() == $(document).height()
        if @current_page < @total_page
          @current_page++
          @loadPage()


Feed = new Feed
module.exports = Feed
