#==========================================
# Global variable
#==========================================
PAGE_NAME = '靠北工程師 - 測試用'
API_URL = 'https://kobeengineer-api.unlink.men/v1/'
AUTH_URL = 'https://kobeengineer-api.unlink.men/auth/'
KXGIO_APPS = ['2PtsxZcjX', '2qzmW72SO', '40cNDdt3b']
ACCESS_TOKEN = Cookies.get '_ggid'
ROUTE = window.location.pathname


#==========================================
# Message
#==========================================
MESSAGE =
  something_wrong: 'kobeengineer.exe - 應用程式錯誤﻿"0x00000000" 指令參考的﻿"0x00000000" 記憶體'
  asshole_read_the_license: '請詳細閱讀發文守則'
  content_is_empty: '請輸入發文內容'
  code_is_empty: '請輸入程式碼'
  post_submit_failed: '發文失敗，請稍候再嘗試或聯絡網站管理員'
  are_you_sure: '刪、都刪？'
  countdown_failed: '根据相关法律法规和政策，您的发文内容未予发佈'
  report_this: '您要檢舉的是這篇發文？'
  report_success: '您的檢舉已送出'
  report_failed: '檢舉失敗，請稍後再試'


#==========================================
# Text
#==========================================
TEXT =
  published: '已發佈'
  unpublished: '已下架'
  denied: '禁止發佈'
  pending: '審核中'
  analysing: '分析中'
  queuing: '佇列中'
  failed: '發文失敗'
  state: '發文狀態'
  created_at: '新增時間'
  publish_countdown: '發文倒數'
  like: '靠北'
  liked: '已靠北'
  people_liked: '人感覺靠北'


#==========================================
# Feed
#==========================================
FEED =
  sorting:
    newest: '最新發文'
    ranking_today: '今日排行'
    ranking_week: '本週排行'
    ranking_month: '本月排行'
    ranking_top100: 'TOP100排行'


#==========================================
# Little pal
#==========================================
xx = (x) -> console.log x
index = (obj, i) -> obj[i]
dotToArray = (object, target) -> target.split('.').reduce(index, object)
redirect = (path) -> window.location = path
bind = (element, event, callback, parent = 'body') ->
  $(parent).delegate element, event, callback
text2lines = (text) -> text.match(/[^\r\n]+/g)
ucfirst = (string) -> string.charAt(0).toUpperCase() + string.slice(1)

#==========================================
# Datetime
#==========================================
currentDatetime = (add_hour = 0) ->
  now = new Date()
  now.setHours(now.getHours() + add_hour)
  date = now.getFullYear() + '-' + (now.getMonth() + 1) + '-'+now.getDate()
  time = now.getHours() + ":" + now.getMinutes() + ":" + now.getSeconds()
  return date + ' ' + time

compoareDatetimes = (a, b) ->
  return if Date.parse(a) > Date.parse(b) then true else false


#==========================================
# Routing
#==========================================
inputGetAll = ->
  query = window.location.search.substring(1)
  vars = query.split('&')
  query_string = {}
  i = 0
  while i < vars.length
    pair = vars[i].split('=')
    if typeof query_string[pair[0]] == 'undefined'
      query_string[pair[0]] = decodeURIComponent(pair[1])
    else if typeof query_string[pair[0]] == 'string'
      arr = [query_string[pair[0]], decodeURIComponent(pair[1])]
      query_string[pair[0]] = arr
    else
      query_string[pair[0]].push decodeURIComponent(pair[1])
    i++
  query_string

inputGet = (target, default_value = '') ->
  object = inputGetAll()
  return if object[target] is undefined then default_value else object[target]


#==========================================
# Request
#==========================================
get = (url, callback, data = {}) ->
  data.token = ACCESS_TOKEN
  $.ajax
    url: url
    type: 'get'
    data: data
    dataType: 'json'
    error: (response) ->
      callback response
    success: (response) ->
      callback response

post = (url, callback, data = {}, with_token = false) ->
  if with_token then url += '?token=' + ACCESS_TOKEN
  $.ajax
    url: url
    type: 'post'
    data: data
    dataType: 'json'
    error: (response) ->
      callback response
    success: (response) ->
      callback response

postImgur = (callback, data = {}) ->
  $.ajax
    url: 'https://api.imgur.com/3/image'
    contentType: 'application/x-www-form-urlencoded'
    type: 'post'
    data: data
    dataType: 'json'
    beforeSend: (xhr) ->
      xhr.setRequestHeader 'Authorization', 'Client-ID c60e308b07d56f2'
    error: (response) ->
      callback response
    success: (response) ->
      callback response


#==========================================
# Package setting
#==========================================
$.ajaxSetup
  cache: false
  crossDomain: true
