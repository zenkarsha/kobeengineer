class User

  constructor: ->
    @me = undefined
    @identification = undefined
    @getIdentification()
    @getLoginStatus()
    @bind()

  bind: ->
    bind '.button-github-login', 'click', ( => @login 'github' )
    bind '.button-facebook-login', 'click', ( => @login 'facebook' )
    bind '.button-logout', 'click', @logout

  login: (provider) =>
    redirect AUTH_URL + provider

  logout: ->
    Cookies.set '_ggid', '', {expires: 0, path: '/', domain: '.unlink.men'}
    setTimeout ( ->
      redirect '/'
    ), 500

  getLoginStatus: ->
    if @hasToken()
      get API_URL + 'me', ((response) ->
        if response.status is 'connected'
          @me = response.user
          if @me.verified
            View.switch 'verified-user'
          else
            View.switch 'user'
        else
          Cookies.set '_ggid', '', {expires: 0, path: '/', domain: '.unlink.men'}
          View.switch 'guest'
      ).bind(@), { token: ACCESS_TOKEN }
    else
      View.switch 'guest'

  getIdentification: =>
    if localStorage.getItem('identification') is null
      @createIdentification()
    else
      @identification = localStorage.getItem('identification')
      @checkIdentification @identification

  checkIdentification: (identification) =>
    post API_URL + 'client/check', @checkIdentificationCallback, { identification: identification}

  checkIdentificationCallback: (response) =>
    if typeof response.message is 'undefined'
      @createIdentification()

  createIdentification: =>
    post API_URL + 'client', ((response) ->
      identification = response.data.identification
      localStorage.setItem 'identification', identification
      @identification = identification
    ).bind(@)

  hasToken: =>
    if ACCESS_TOKEN in [undefined, ''] then false else true

global.User = new User
module.exports = User
