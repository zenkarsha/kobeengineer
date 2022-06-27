class PostReportView

  post:
    parent: $('#post')
    create: (post, view = '') ->
      post.content = @handleContent post
      view += @__post post
      @parent.html view
    handleContent: (post, content = '') ->
      post.title = @__postTitle post
      if post.reply_to isnt undefined then content += @__replyTo post.reply_to
      if post.type in ['text', 'link', 'code'] then content += post.content
      if post.hashtag isnt undefined then content += '<br />' + post.hashtag
      if post.type in ['image'] then content += @__postImage post.image
      if post.type in ['code'] then content += @__postCode post.code
      content
    handleState: (state) ->
      return TEXT.published if state is 'published'
      return TEXT.unpublished if state is 'unpublished'
      return TEXT.denied if state is 'denied'
      return TEXT.pending if state is 'pending'
      return TEXT.analysing if state is 'analysing'
      return TEXT.queuing if state is 'queuing'
      return TEXT.failed if state is 'failed'
    __replyTo: (id) ->
      """
        RE: <a href="/post/#{ id }/">##{ PAGE_NAME }#{ id }</a>&nbsp;
      """
    __postImage: (url) ->
      """
        <div style="margin-top: 24px;"><img src="#{ url }" class="img-responsive" /></div>
      """
    __postCode: (code) ->
      """
        <pre style="margin-top: 24px;">#{ code }</pre>
      """
    __postTitle: (data) ->
      title = if data.id isnt undefined then PAGE_NAME + data.id else data.key
      """
        <strong>
          <mark>##{ title }</mark>
        </strong><br />
      """
    __post: (data) ->
      """
        <div class="post old-school-scroll" style="background: red;">
          <div class="content">
            <div class="text-center">
              <br />
              #{ MESSAGE.report_this }
              <hr />
            </div>
            <ul>
              <li>
                #{ data.title }
                <span class="post-content">#{ data.content }</span>
              </li>
            </ul>
          </div>
        </div>
      """

  post_report:
    parent: $('#post-report')
    success: ->
      view = @__success()
      @parent.html view
    __success: ->
      """
        <div class="alert alert-danger alert-block user-view text-center">
          <h2>#{ MESSAGE.report_success }<h2>
        </div>
      """


global.PostReportView = new PostReportView
module.exports = PostReportView
