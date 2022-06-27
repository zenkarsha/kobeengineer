class Post

  constructor: ->
    @container = $('#post')
    @url = API_URL + 'post'
    @post_id = inputGet('id')
    @post_key = inputGet('key')
    @post_pid = undefined
    @loadPost()

  loadPost: =>
    if @post_id isnt ''
      @setBreadcrumb(PAGE_NAME + @post_id)
      get @url, @callback, { id: @post_id, token: ACCESS_TOKEN}
    else if @post_key isnt ''
      @setBreadcrumb(@post_key)
      get @url, @callback, { key: @post_key }
    else
      redirect '/'

  callback: (response) =>
    if response.success and response.data.post isnt undefined
      if @post_id is '' and response.data.post.id isnt undefined
        redirect '/post/?id=' + response.data.post.id
      else
        PostView.main.create response.data.post
        if response.data.post.facebook_pid isnt undefined
          @post_pid = response.data.post.facebook_pid
          @loadFacebookComments()
    else
      View.message.page_not_found @container

  setBreadcrumb: (text) ->
    $('#breadcrumb-current').text('#' + text)

  loadFacebookComments: (after = '') =>
    data =
      pid: @post_pid
    if after isnt ''
      data['after'] = after
    get @url + '/comments', @loadFacebookCommentsCallback, data

  loadFacebookCommentsCallback: (response) =>
    if response.success and response.data.comments isnt undefined
      PostFacebookCommentView.main.create response.data

global.Post = new Post
module.exports = Post
