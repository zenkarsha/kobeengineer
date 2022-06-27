class FeedAuthorsView

  main:
    parent: $('#author-list .row')
    create: (authors, view = '') ->
      for key of authors
        author_post = @handleContent authors[key]['post']
        view += @__author authors[key], author_post
      @parent.append view
    handleContent: (post, content = '') ->
      if post.reply_to isnt undefined then content += @__replyTo post.reply_to
      if post.type in ['text', 'link', 'code'] then content += post.content
      if post.hashtag isnt undefined then content += post.hashtag
      if post.type in ['image'] then content += @__postImage post.image
      if post.type in ['code'] then content += @__postCode post.code
      content
    __replyTo: (id) ->
      """
        RE: <a href="/post/#{ id }/">##{ PAGE_NAME }#{ id }</a>&nbsp;
      """
    __postImage: (url) ->
      """
        <div><img src="#{ url }" class="img-responsive" /></div>
      """
    __postCode: (code)->
      """
        <pre>#{ code }</pre>
      """
    __author: (author, author_post) ->
      """
        <div class="span3">
          <div class="author-card old-school-scroll">
            <div class="content">
              <ul>
                <li>
                  <a href="/feed/?author=#{ author.name }">
                    <h4 style="padding-bottom: 10px;"><strong>
                      <mark>#{ author.name }</mark>
                    </strong></h4>
                    <div class="post-content">#{ author_post }</div>
                  </a>
                </li>
              </ul>
            </div>
          </div>
        </div>
      """


global.FeedAuthorsView = new FeedAuthorsView
module.exports = FeedAuthorsView
