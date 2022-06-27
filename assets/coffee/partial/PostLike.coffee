class PostLike

  constructor: ->
    @url = API_URL + 'post'
    @bind()

  bind: ->
    bind '.button-like', 'click', @handlePostLike

  handlePostLike: (event) =>
    if User.me is undefined
      $('#login-modal').modal 'show'
    else
      element = $(event.currentTarget)
      post_id = element.attr 'data-id'
      post @url + '/like/' + post_id, ((response) ->
        if response.success
          View.like_button.updateLikeCount element, post_id, response.data.likes, response.data.liked
        else
          alert MESSAGE.something_wrong
      ).bind(@), {}, true

global.PostLike = new PostLike
module.exports = PostLike
