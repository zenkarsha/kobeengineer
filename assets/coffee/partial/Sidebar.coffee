class Sidebar

  constructor: ->
    @container = $('#recently-posts')
    @url = API_URL + 'feed/recently'
    @initial()

  initial: =>
    get @url, @callback

  callback: (response) =>
    if response.success
      SidebarView.main.create response.data.posts
    else
      View.message.failed @container

Sidebar = new Sidebar
module.exports = Sidebar
