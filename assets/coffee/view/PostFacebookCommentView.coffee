class PostFacebookCommentView

  main:
    parent: $('#post-comment')
    loading: $('#post-comment-progress')
    after: ''
    create: (data, view = '') ->
      @loading.show()
      if data.comments.length is 0
        @removeButton()
      else
        for comment in data.comments
          view += @__comment comment

        if data.after isnt undefined and data.after isnt '' then @after = data.after else @removeButton()

        if $('#button-load-more').length is 0
          view += @__loadMore data.after
          @bind()

        if $('#post-comment-wrapper').length is 0
          view = @__commentWrapper view
          @parent.append view
        else
          $(view).insertBefore('#button-load-more')

        $('.fake-avatar').each (index) ->
          if $(this).css('background-image') is 'none'
            $(this).gixi()

      $('.comment').linkify()
      @loading.hide()
    bind: ->
      bind '#button-load-more', 'click', ( => @loadMore() )
    loadMore: ->
      Post.loadFacebookComments @after
    removeButton: ->
      $('#button-load-more').remove()
    __comment: (data) ->
      message = $('<div/>').html(data.message).text()
      if message is '' then message = '[Sticker]'
      """
        <div class="fake-avatar"></div>
        <div class="comment">
          <strong>
            <a href="https://facebook.com/#{ data.id }" target="_blank" style="background: none;"><mark>#{ data.from.name }</mark></a>
          </strong><br />
          #{ message }
        </div>
        <hr />
      """
    __commentWrapper: (comments) ->
      """
        <div class="alert" style="background: white;" id="post-comment-wrapper">
          <h4 class="alert-heading">Facebook comments</h4>
          <hr />
          #{ comments }
        </div>
      """
    __loadMore: ->
      """
        <button type="button" class="btn btn-primary btn-large btn-block" id="button-load-more" style="margin-bottom: 20px;">Load more</button>
      """


global.PostFacebookCommentView = new PostFacebookCommentView
module.exports = PostFacebookCommentView
