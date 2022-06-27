!function(){function t(n,e,i){function o(s,a){if(!e[s]){if(!n[s]){var l="function"==typeof require&&require;if(!a&&l)return l(s,!0);if(r)return r(s,!0);var u=new Error("Cannot find module '"+s+"'");throw u.code="MODULE_NOT_FOUND",u}var c=e[s]={exports:{}};n[s][0].call(c.exports,function(t){return o(n[s][1][t]||t)},c,c.exports,t,n,e,i)}return e[s].exports}for(var r="function"==typeof require&&require,s=0;s<i.length;s++)o(i[s]);return o}return t}()({1:[function(t,n,e){(function(t){(function(){var e,i=function(t,n){return function(){return t.apply(n,arguments)}};e=function(){function t(){this.hasToken=i(this.hasToken,this),this.createIdentification=i(this.createIdentification,this),this.checkIdentificationCallback=i(this.checkIdentificationCallback,this),this.checkIdentification=i(this.checkIdentification,this),this.getIdentification=i(this.getIdentification,this),this.login=i(this.login,this),this.me=void 0,this.identification=void 0,this.getIdentification(),this.getLoginStatus(),this.bind()}return t.prototype.bind=function(){return bind(".button-github-login","click",function(t){return function(){return t.login("github")}}(this)),bind(".button-facebook-login","click",function(t){return function(){return t.login("facebook")}}(this)),bind(".button-logout","click",this.logout)},t.prototype.login=function(t){return redirect(AUTH_URL+t)},t.prototype.logout=function(){return Cookies.set("_ggid","",{expires:0,path:"/",domain:".unlink.men"}),setTimeout(function(){return redirect("/")},500)},t.prototype.getLoginStatus=function(){return this.hasToken()?get(API_URL+"me",function(t){return"connected"===t.status?(this.me=t.user,this.me.verified?View.switch("verified-user"):View.switch("user")):(Cookies.set("_ggid","",{expires:0,path:"/",domain:".unlink.men"}),View.switch("guest"))}.bind(this),{token:ACCESS_TOKEN}):View.switch("guest")},t.prototype.getIdentification=function(){return null===localStorage.getItem("identification")?this.createIdentification():(this.identification=localStorage.getItem("identification"),this.checkIdentification(this.identification))},t.prototype.checkIdentification=function(t){return post(API_URL+"client/check",this.checkIdentificationCallback,{identification:t})},t.prototype.checkIdentificationCallback=function(t){if(void 0===t.message)return this.createIdentification()},t.prototype.createIdentification=function(){return post(API_URL+"client",function(t){var n;return n=t.data.identification,localStorage.setItem("identification",n),this.identification=n}.bind(this))},t.prototype.hasToken=function(){return void 0!==ACCESS_TOKEN&&""!==ACCESS_TOKEN},t}(),t.User=new e,n.exports=e}).call(this)}).call(this,"undefined"!=typeof global?global:"undefined"!=typeof self?self:"undefined"!=typeof window?window:{})},{}],2:[function(t,n,e){t("./../view/View"),t("./../view/PostReportView"),t("./../component/User"),t("./../partial/PostReport")},{"./../component/User":1,"./../partial/PostReport":3,"./../view/PostReportView":4,"./../view/View":5}],3:[function(t,n,e){(function(t){(function(){var e,i=function(t,n){return function(){return t.apply(n,arguments)}};e=function(){function t(){this.handlePostReport=i(this.handlePostReport,this),this.loadPostCallback=i(this.loadPostCallback,this),this.loadPost=i(this.loadPost,this),this.container=$("#post"),this.post_id=inputGet("id"),this.url=API_URL+"post",this.report_url=API_URL+"report/"+this.post_id,this.loadPost(),this.bind()}return t.prototype.bind=function(){return bind("#button-report","click",this.handlePostReport)},t.prototype.loadPost=function(){return""!==this.post_id?get(this.url,this.loadPostCallback,{id:this.post_id}):redirect("/")},t.prototype.loadPostCallback=function(t){return t.success&&void 0!==t.data.post?PostReportView.post.create(t.data.post):View.message.page_not_found(this.container)},t.prototype.handlePostReport=function(t){return post(this.report_url,function(t){return t.success?PostReportView.post_report.success():alert(MESSAGE.something_wrong)}.bind(this),{},!0)},t}(),t.PostReport=new e,n.exports=e}).call(this)}).call(this,"undefined"!=typeof global?global:"undefined"!=typeof self?self:"undefined"!=typeof window?window:{})},{}],4:[function(t,n,e){(function(t){(function(){var e;e=function(){function t(){}return t.prototype.post={parent:$("#post"),create:function(t,n){return null==n&&(n=""),t.content=this.handleContent(t),n+=this.__post(t),this.parent.html(n)},handleContent:function(t,n){var e;return null==n&&(n=""),t.title=this.__postTitle(t),void 0!==t.reply_to&&(n+=this.__replyTo(t.reply_to)),"text"!==(e=t.type)&&"link"!==e&&"code"!==e||(n+=t.content),void 0!==t.hashtag&&(n+="<br />"+t.hashtag),"image"===t.type&&(n+=this.__postImage(t.image)),"code"===t.type&&(n+=this.__postCode(t.code)),n},handleState:function(t){return"published"===t?TEXT.published:"unpublished"===t?TEXT.unpublished:"denied"===t?TEXT.denied:"pending"===t?TEXT.pending:"analysing"===t?TEXT.analysing:"queuing"===t?TEXT.queuing:"failed"===t?TEXT.failed:void 0},__replyTo:function(t){return'RE: <a href="/post/'+t+'/">#'+PAGE_NAME+t+"</a>&nbsp;"},__postImage:function(t){return'<div style="margin-top: 24px;"><img src="'+t+'" class="img-responsive" /></div>'},__postCode:function(t){return'<pre style="margin-top: 24px;">'+t+"</pre>"},__postTitle:function(t){return"<strong>\n  <mark>#"+(void 0!==t.id?PAGE_NAME+t.id:t.key)+"</mark>\n</strong><br />"},__post:function(t){return'<div class="post old-school-scroll" style="background: red;">\n  <div class="content">\n    <div class="text-center">\n      <br />\n      '+MESSAGE.report_this+"\n      <hr />\n    </div>\n    <ul>\n      <li>\n        "+t.title+'\n        <span class="post-content">'+t.content+"</span>\n      </li>\n    </ul>\n  </div>\n</div>"}},t.prototype.post_report={parent:$("#post-report"),success:function(){var t;return t=this.__success(),this.parent.html(t)},__success:function(){return'<div class="alert alert-danger alert-block user-view text-center">\n  <h2>'+MESSAGE.report_success+"<h2>\n</div>"}},t}(),t.PostReportView=new e,n.exports=e}).call(this)}).call(this,"undefined"!=typeof global?global:"undefined"!=typeof self?self:"undefined"!=typeof window?window:{})},{}],5:[function(t,n,e){(function(t){(function(){var e;e=function(){function t(){}return t.prototype.switch=function(t){return"verified-user"===t?($("body").removeClass("guest").addClass("user verified"),this.navbar.user()):"user"===t?($("body").removeClass("guest").addClass("user"),this.navbar.user()):($("body").removeClass("user verified").addClass("guest"),this.navbar.guest())},t.prototype.navbar={parent:$("#main-menu-left"),user:function(){var t;return t='<li class="dropdown" id="preview-menu">\n  <a class="dropdown-toggle" data-toggle="dropdown" href="#">\n    Member <b class="caret"></b>\n  </a>\n  <ul class="dropdown-menu">\n    <li><a href="/me/posts/">My posts</a></li>\n    <li><a href="/me/setting/">Setting</a></li>\n    <li><a href="javascript:void(0)" class="button-logout">Logout</a></li>\n  </ul>\n</li>',this.parent.append(t)},guest:function(){var t;return t='<li class="dropdown" id="preview-menu">\n  <a class="dropdown-toggle" data-toggle="dropdown" href="#">\n    Login <b class="caret"></b>\n  </a>\n  <ul class="dropdown-menu">\n    <li><a href="javascript:void(0)" class="button-github-login">GitHub登入</a></li>\n    <li><a href="javascript:void(0)" class="button-facebook-login">Facebook登入</a></li>\n  </ul>\n</li>',this.parent.append(t)}},t.prototype.message={failed:function(t){var n;return n="<span>Load failed</span>",t.append(n)},failed_table:function(t,n){var e;return null==n&&(n=1),e='<tr>\n  <td colspan="'+n+'">\n    <span>Load failed</span>\n  </td>\n</tr>',t.append(e)},null_table:function(t,n,e){var i;return null==n&&(n=1),null==e&&(e=""),i='<tr>\n  <td colspan="'+n+'">\n    <span>No record. '+e+"</span>\n  </td>\n</tr>",t.append(i)},page_not_found:function(t){var n;return n='<div class="alert alert-block alert-danger text-center">\n  <img src="/images/old/shark.gif" /><br /><br />\n  <h4 class="alert-heading">Thiss paage isn avilabie</h4><br />\n  <p>\n    Tho likn yuo flolowed mav bi borken, orr tle pgae mya heva beem remvoed.\n    <br /><br />\n    Wi cann not doo amything fro yyu, pleese fcuk yurself or go home.\n  </p>\n  <br />\n</div>',t.append(n)}},t.prototype.like_button={create:function(t){return this.__view(t.id,t.likes,t.liked)},updateLikeCount:function(t,n,e,i,o){return null==i&&(i=!1),null==o&&(o=""),o+=this.__view(n,e,i),t.parent().replaceWith(o)},__view:function(t,n,e){var i;return null==e&&(e=!1),e=e?" btn-primary":"",i=e?TEXT.liked:TEXT.like,'<div class="like-wrapper">\n  <button type="button" class="btn'+e+' button-like" data-id="'+t+'">\n    <i class="fa fa-thumbs-o-up" aria-hidden="true"></i> '+i+'\n  </button>\n  <span class="post-likes-count">\n    '+n+TEXT.people_liked+"\n  </span>\n</div>"}},t}(),t.View=new e,n.exports=e}).call(this)}).call(this,"undefined"!=typeof global?global:"undefined"!=typeof self?self:"undefined"!=typeof window?window:{})},{}]},{},[2]);