class FeedAuthors

  constructor: ->
    @container = $('#author-list .row')
    @loading = $('.loading-progress')
    @url = API_URL + 'feed/authors'
    @current_page = 1
    @total_page = 1
    @loadPage()

  loadPage: =>
    @loading.show()
    get @url, @callback, { page: @current_page }

  callback: (response) =>
    @loading.hide()
    if response.success
      @total_page = response.data.total_page
      FeedAuthorsView.main.create response.data.authors
    else
      View.message.failed @container


FeedAuthors = new FeedAuthors
module.exports = FeedAuthors
