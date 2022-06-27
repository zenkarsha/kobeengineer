class PostView

  main:
    parent: $('#post')
    reloaded: inputGet('r', 0)
    create: (post, view = '') ->
      post.content = @handleContent post
      if post.id is undefined then view += @__postInfo post
      view += @__post post
      if post.id isnt undefined then view += @__postLiks post
      if post.state is 'published' then view += @__socialCount post
      @parent.html view
      @parent.linkify()
      if post.state is 'queuing'
        $("#countdown").xxcountdown({
          "callback": =>
            if @reloaded is 0
              $(location).attr 'href', '/post/?key=' + post.key + '&r=1'
            else
              $('#post-state').text TEXT.failed
              $('#countdown').text MESSAGE.countdown_failed
              document.title = MESSAGE.countdown_failed
        })
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
    handleCountDown: (post, view = '') ->
      if post.state is 'queuing'
        view = @__countDown(post.countdown)
      return view
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
      datetime = if data.id isnt undefined then @__datetime(data.published_at) else ''
      """
        <strong>
          <mark>##{ title }</mark>
        </strong><br />#{ datetime }<br />
      """
    __datetime: (datetime) ->
      """
        <small style="font-size:14px;">Published at #{ datetime }</small>
      """
    __postInfo: (data) ->
      """
        <div class="alert alert-block" id="post-info">
          <p>
            #{ TEXT.state }: <span id="post-state">#{ this.handleState(data.state) }</span><br />
            #{ TEXT.created_at }: #{ data.created_at }
            #{ this.handleCountDown(data) }
          </p>
        </div>
      """
    __postLiks: (data, links = '') ->
      for key, value of data.links
        links += @__link key, value
        links += '&nbsp;'
      """
        <div class="alert alert-success alert-block" id="post-links">
          <h4 class="alert-heading">Post links</h4>
          <hr />
          <p>#{ links }</p>
        </div>
      """
    __link: (name, url) ->
      """
        <a class="btn btn-link" href="#{ url }" target="_blank">
          <i class="fa fa-external-link-square" aria-hidden="true"></i> #{ ucfirst(name) }
        </a>
      """
    __post: (data) ->
      like_button = if data.state is 'published' then View.like_button.create(data) else ''
      """
        <div class="post old-school-scroll">
          <div class="content">
            <ul>
              <li>
                #{ data.title }
                <span class="post-content">#{ data.content }</span>
                <br />
                #{ like_button }
              </li>
            </ul>
          </div>
        </div>
      """
    __socialCount: (data) ->
      """
        <div class="alert alert-block alert-info">
          <h4 class="alert-heading">Facebook reaction counts</h4>
          <hr />
          <div class="fb-social-count">
            <br />
            <img src="/images/old/like.gif" /> #{ data.fb_likes }
            <img src="/images/old/comment.gif" /> #{ data.fb_comments }
            <img src="/images/old/share.gif" /> #{ data.fb_shares }
          </div>
        </div>
      """
    __countDown: (timestamp) ->
      """
        <br />#{ TEXT.publish_countdown }: <span id="countdown" data-timestamp="#{ timestamp }"></span>
      """


global.PostView = new PostView
module.exports = PostView
