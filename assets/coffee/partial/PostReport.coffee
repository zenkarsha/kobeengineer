class PostReport

  constructor: ->
    @container = $('#post')
    @post_id = inputGet('id')
    @url = API_URL + 'post'
    @report_url = API_URL + 'report/' + @post_id
    @loadPost()
    @bind()

  bind: ->
    bind '#button-report', 'click', @handlePostReport

  loadPost: =>
    if @post_id isnt ''
      get @url, @loadPostCallback, { id: @post_id }
    else
      redirect '/'

  loadPostCallback: (response) =>
    if response.success and response.data.post isnt undefined
      PostReportView.post.create response.data.post
    else
      View.message.page_not_found @container

  handlePostReport: (event) =>
    post @report_url, ((response) ->
      if response.success
        PostReportView.post_report.success()
      else
        alert MESSAGE.something_wrong
    ).bind(@), {}, true

global.PostReport = new PostReport
module.exports = PostReport
