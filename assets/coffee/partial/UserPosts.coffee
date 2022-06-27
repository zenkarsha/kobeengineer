class UserPosts

  constructor: ->
    @container = $('#posts-table tbody')
    @url = API_URL + 'me/posts'
    @current_page = inputGet('page', 1)
    @initial()

  initial: =>
    get @url, @callback, { page: @current_page, token: ACCESS_TOKEN }
    @bind()

  callback: (response) =>
    if response.success
      if response.data.total is 0
        View.message.null_table @container, 5, '<a href="/">Create new post</a>'
      else
        return redirect '/me/posts/' if @current_page > response.data.total_page
        UserView.user_posts.create response.data.posts
        UserView.user_posts_pagination.create response.data
    else
      View.message.failed_table @container, 5

  handlePostDelete: (event) =>
    if confirm(MESSAGE.are_you_sure)
      element = $(event.currentTarget)
      parent = element.parents('tr')
      key = parent.data 'key'
      post API_URL + 'me/post/delete', ((response) ->
        if response.success
          parent.remove()
        else
          alert MESSAGE.something_wrong
      ).bind(@), { key: key }, true

  bind: ->
    bind '.button-post-delete', 'click', @handlePostDelete


UserPosts = new UserPosts
module.exports = UserPosts
