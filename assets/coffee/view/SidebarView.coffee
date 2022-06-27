class SidebarView

  main:
    parent: $('#recently-posts')
    create: (posts, view = '') ->
      for post in posts
        post.content = @handleContent post
        view += @__post post
      @parent.html view
      @parent.linkify()
    handleContent: (post, content = '') ->
      if post.reply_to isnt undefined then content += @__replyTo post.reply_to
      if post.type in ['text', 'link', 'code'] then content += post.content
      if post.hashtag isnt undefined then content += '<br />' + post.hashtag
      if post.type in ['image'] then content += @__postImage post
      content
    __replyTo: (id) ->
      """
        RE: <a href="/post/#{ id }/">##{ PAGE_NAME }#{ id }</a>&nbsp;
      """
    __postImage: (data) ->
      """
        <a href="/post/?id=#{ data.id }">
          <img src="#{ data.image }" class="img-responsive" />
        </a>
      """
    __post: (data) ->
      """
        <li>
          <strong>
            <a href="/post/?id=#{ data.id }"><mark>##{ PAGE_NAME }#{ data.id }</mark></a>
          </strong><br />
          <small style="font-size:10px;">#{ data.published_at }</small>
          <div class="post-content">
            <a href="/post/?id=#{ data.id }">#{ data.content }</a>
          </div>
        </li>
      """


global.SidebarView = new SidebarView
module.exports = SidebarView
