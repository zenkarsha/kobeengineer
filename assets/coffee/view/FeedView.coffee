class FeedView

  feed:
    parent: $('#feed')
    create: (posts, author = '', view = '') ->
      if author isnt '' and $('#author-header').length is 0 then view += @__header author
      for post in posts
        post.content = @handleContent post
        view += @__post post
      @parent.append view
      @parent.linkify()
    create_ranking: (posts, count = 1, view = '') ->
      for post in posts
        post.content = @handleContent post
        ranking = 'TOP' + count
        view += @__post post, ranking
        count++
      @parent.append view
      @parent.linkify()
    handleContent: (post, content = '') ->
      if post.reply_to isnt undefined then content += @__replyTo post.reply_to
      if post.type in ['text', 'link', 'code'] then content += post.content
      if post.hashtag isnt undefined then content += '<br />' + post.hashtag
      if post.type in ['image'] then content += @__postImage post
      if post.type in ['code'] then content += @__postCode post.code
      content
    __replyTo: (id) ->
      """
        RE: <a href="/post/#{ id }/">##{ PAGE_NAME }#{ id }</a>&nbsp;
      """
    __postImage: (data) ->
      """
        <div>
          <a href="/post/?id=#{ data.id }">
            <img src="#{ data.image }" class="img-responsive" />
          </a>
        </div>
      """
    __postCode: (code)->
      """
        <pre>#{ code }</pre>
      """
    __header: (author)->
      """
        <div class="alert alert-block" id="author-header">
          <img class="pull-left" src="/images/old/mchammer.gif" width="40" style="margin-right:10px;">
          <h2 style="color: black;">#{ author } 的發文</h2>
        </div>
      """
    __post: (data, ranking = '') ->
      """
        <div class="post old-school-scroll">
          <div class="content">
            <ul>
              <li>
                <strong>
                  #{ ranking }
                  <a href="/post/?id=#{ data.id }"><mark>##{ PAGE_NAME }#{ data.id }</mark></a>
                </strong><br />
                <small style="font-size:14px;">Published at #{ data.published_at }</small><br />
                <div class="post-content">#{ data.content }</div>
                <div>
                  <br />
                  #{ View.like_button.create(data) }
                </div>
              </li>
            </ul>
          </div>
        </div>
      """

  feed_nav:
    parent: $('#feed-nav')
    create: (options, sort, view = '') ->
      view += @__header 'Feed filter'
      for key of options
        active = if key is sort and ROUTE is '/feed/' then 'active' else ''
        view += @__li key, options[key], active
      @parent.html view
    __header: (name) ->
      """
        <li class="nav-header">#{ name }</li>
      """
    __li: (value, name, active = '') ->
      """
        <li class="#{ active }"><a href="/feed/?sort=#{ value }">+ #{ name }</a></li>
      """

global.FeedView = new FeedView
module.exports = FeedView
