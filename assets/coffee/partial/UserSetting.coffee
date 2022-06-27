class UserSetting

  constructor: ->
    @container = $('#user-setting-form')
    @initial()

  initial: =>
    @createForm()
    @bind()

  createForm: =>
    get API_URL + 'me', ((response) ->
      if response.status is 'connected'
        UserView.user_setting.create response.user
      else
        redirect '/'
    ).bind(@), { token: ACCESS_TOKEN }

  handleSave: (event) =>
    data =
      public: if $('#public').prop('checked') then 1 else 0
    post API_URL + 'me/setting', ((response) ->
      if response.success
        return redirect '/me/setting/'
      else
        alert MESSAGE.something_wrong
    ).bind(@), data, true

  bind: ->
    bind '#button-save', 'click', @handleSave


UserSetting = new UserSetting
module.exports = UserSetting
