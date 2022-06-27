class View

  switch: (type) ->
    if type is 'verified-user'
      $('body').removeClass('guest').addClass 'user verified'
      @navbar.user()
    else if type is 'user'
      $('body').removeClass('guest').addClass 'user'
      @navbar.user()
    else
      $('body').removeClass('user verified').addClass 'guest'
      @navbar.guest()

  navbar:
    parent: $('#main-menu-left')
    user: ->
      view = """
        <li class="dropdown" id="preview-menu">
          <a class="dropdown-toggle" data-toggle="dropdown" href="#">
            Member <b class="caret"></b>
          </a>
          <ul class="dropdown-menu">
            <li><a href="/me/posts/">My posts</a></li>
            <li><a href="/me/setting/">Setting</a></li>
            <li><a href="javascript:void(0)" class="button-logout">Logout</a></li>
          </ul>
        </li>
      """
      @parent.append view
    guest: ->
      view = """
        <li class="dropdown" id="preview-menu">
          <a class="dropdown-toggle" data-toggle="dropdown" href="#">
            Login <b class="caret"></b>
          </a>
          <ul class="dropdown-menu">
            <li><a href="javascript:void(0)" class="button-github-login">GitHub登入</a></li>
            <li><a href="javascript:void(0)" class="button-facebook-login">Facebook登入</a></li>
          </ul>
        </li>
      """
      @parent.append view

  message:
    failed: (parent) ->
      view = """
        <span>Load failed</span>
      """
      parent.append view
    failed_table: (parent, colspan = 1) ->
      view = """
        <tr>
          <td colspan="#{ colspan }">
            <span>Load failed</span>
          </td>
        </tr>
      """
      parent.append view
    null_table: (parent, colspan = 1, custom_message = '') ->
      view = """
        <tr>
          <td colspan="#{ colspan }">
            <span>No record. #{ custom_message }</span>
          </td>
        </tr>
      """
      parent.append view
    page_not_found: (parent) ->
      view = """
        <div class="alert alert-block alert-danger text-center">
          <img src="/images/old/shark.gif" /><br /><br />
          <h4 class="alert-heading">Thiss paage isn avilabie</h4><br />
          <p>
            Tho likn yuo flolowed mav bi borken, orr tle pgae mya heva beem remvoed.
            <br /><br />
            Wi cann not doo amything fro yyu, pleese fcuk yurself or go home.
          </p>
          <br />
        </div>
      """
      parent.append view

  like_button:
    create: (post) ->
      return @__view post.id, post.likes, post.liked
    updateLikeCount: (element, post_id, likes, liked = false, view = '') ->
      view += @__view post_id, likes, liked
      element.parent().replaceWith view
    __view: (post_id, likes, liked = false) ->
      liked = if liked then ' btn-primary' else ''
      text = if liked then TEXT.liked else TEXT.like
      """
        <div class="like-wrapper">
          <button type="button" class="btn#{ liked } button-like" data-id="#{ post_id }">
            <i class="fa fa-thumbs-o-up" aria-hidden="true"></i> #{ text }
          </button>
          <span class="post-likes-count">
            #{ likes }#{ TEXT.people_liked }
          </span>
        </div>
      """

global.View = new View
module.exports = View
