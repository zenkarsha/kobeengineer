class UserView

  user_posts:
    parent: $('#posts-table tbody')
    create: (posts, view = '') ->
      for post in posts
        post.state = @handleState post.state
        view += @__post post
      @parent.html view
    handleState: (state) ->
      return TEXT.published if state is 'published'
      return TEXT.unpublished if state is 'unpublished'
      return TEXT.denied if state is 'denied'
      return TEXT.pending if state is 'pending'
      return TEXT.analysing if state is 'analysing'
      return TEXT.queuing if state is 'queuing'
      return TEXT.failed if state is 'failed'
    __post: (data) ->
      is_new = if compoareDatetimes data.created_at, currentDatetime(-6) then '<img src="/images/old/new.gif" />' else ''
      id = if data.id isnt '' then '#' + PAGE_NAME +  data.id else ''
      content = $("<div />").html(data.content).text()
      """
        <tr data-key="#{ data.key }">
          <td class="text-center">#{ id }</td>
          <td class="span7">
            #{ is_new }
            <a href="/post/?key=#{ data.key }" target="_blank">
              #{ content }
            </a><br />
          </td>
          <td class="text-center">#{ data.state }</td>
          <td class="text-center">#{ data.created_at }</td>
          <td class="text-center">
            <button type="button" class="btn btn-danger button-post-delete">刪除</button>
          </td>
        </tr>
      """

  user_posts_pagination:
    parent: $('#posts-table tfoot tr td .pagination ul')
    create: (data, view = '') ->
      if data.total_page isnt 1
        for i in [1..data.total_page]
          active = if i is data.current_page then 'active' else ''
          view += @__li i, active
      @parent.html view
    __li: (i, active = '') ->
      """
        <li class="#{ active }"><a href="/me/posts/?page=#{ i }">#{ i }</a></li>
      """

  user_setting:
    parent: $('#user-setting-field')
    create: (data, view = '') ->
      @createPublicField data.public
    createPublicField: (value) ->
      view = @__publicField value
      @parent.append view
    __publicField: (value) ->
      checked = if value is 1 then ' checked="checked"' else ''
      """
        <div class="checkbox">
        <input id="public" type="checkbox"#{ checked }>
        <label class="css-label" for="public"> 啟用個人頁面</label>
        <div class="alert alert-block">
          <p>啟用後您將有個人的專屬作者頁面，並且會顯示在 <a href="/feed/authors/">Feed Authors</a> 列表中，其他人將可以看到你發過的所有文<br /></p>
        </div>
      </div>
      """

global.UserView = new UserView
module.exports = UserView
