(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
(function (global){
var User,
  bind1 = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

User = (function() {
  function User() {
    this.hasToken = bind1(this.hasToken, this);
    this.login = bind1(this.login, this);
    this.me = void 0;
    this.identification = void 0;
    this.getIdentification();
    this.getLoginStatus();
    this.bind();
  }

  User.prototype.bind = function() {
    bind('.button-github-login', 'click', ((function(_this) {
      return function() {
        return _this.login('github');
      };
    })(this)));
    bind('.button-bitbucket-login', 'click', ((function(_this) {
      return function() {
        return _this.login('bitbucket');
      };
    })(this)));
    return bind('.button-logout', 'click', this.logout);
  };

  User.prototype.login = function(provider) {
    return redirect(AUTH_URL + provider);
  };

  User.prototype.logout = function() {
    Cookies.set('_ggid', '', {
      expires: 0,
      path: '/',
      Htmlain: '.kobeengineer.io'
    });
    return redirect('/');
  };

  User.prototype.getLoginStatus = function() {
    if (this.hasToken()) {
      return get(API_URL + 'me', (function(response) {
        if (response.status === 'connected') {
          this.me = response.user;
          return View["switch"]('user');
        } else {
          return View["switch"]('guest');
        }
      }).bind(this), {
        token: ACCESS_TOKEN
      });
    } else {
      return View["switch"]('guest');
    }
  };

  User.prototype.getIdentification = function() {
    if (localStorage.getItem('identification') === null) {
      return post(API_URL + 'client', (function(response) {
        var identification;
        identification = response.data.identification;
        localStorage.setItem('identification', identification);
        return this.identification = identification;
      }).bind(this));
    } else {
      return this.identification = localStorage.getItem('identification');
    }
  };

  User.prototype.hasToken = function() {
    if (ACCESS_TOKEN === (void 0) || ACCESS_TOKEN === '') {
      return false;
    } else {
      return true;
    }
  };

  return User;

})();

global.User = new User;

module.exports = User;


}).call(this,typeof global !== "undefined" ? global : typeof self !== "undefined" ? self : typeof window !== "undefined" ? window : {})

},{}],2:[function(require,module,exports){
(function (global){
var View;

View = (function() {
  function View() {}

  View.prototype["switch"] = function(type) {
    if (type === 'user') {
      $('body').removeClass('guest').addClass('user');
      return this.navbar.user();
    } else {
      $('body').removeClass('user').addClass('guest');
      return this.navbar.guest();
    }
  };

  View.prototype.message = {
    failed: function(parent) {
      var view;
      view = "<span>Load failed</span>";
      return parent.append(view);
    }
  };

  View.prototype.navbar = {
    parent: $('#main-menu-left'),
    user: function() {
      var view;
      view = "<li class=\"dropdown\" id=\"preview-menu\">\n  <a class=\"dropdown-toggle\" data-toggle=\"dropdown\" href=\"#\">\n    Member <b class=\"caret\"></b>\n  </a>\n  <ul class=\"dropdown-menu\">\n    <li><a href=\"/me/posts/\">My posts</a></li>\n    <li><a href=\"/me/setting/\">Setting</a></li>\n    <li><a href=\"javascript:void(0)\" class=\"button-logout\">Logout</a></li>\n  </ul>\n</li>";
      return this.parent.append(view);
    },
    guest: function() {
      var view;
      view = "<li class=\"dropdown\" id=\"preview-menu\">\n  <a class=\"dropdown-toggle\" data-toggle=\"dropdown\" href=\"#\">\n    Login <b class=\"caret\"></b>\n  </a>\n  <ul class=\"dropdown-menu\">\n    <li><a href=\"javascript:void(0)\" class=\"button-github-login\">GitHub login</a></li>\n    <li><a href=\"javascript:void(0)\" class=\"button-bitbucket-login\">Bitbucket login</a></li>\n  </ul>\n</li>";
      return this.parent.append(view);
    }
  };

  View.prototype.sidebar = {
    parent: $('#recently-posts'),
    create: function(posts, view) {
      var j, len, post;
      if (view == null) {
        view = '';
      }
      for (j = 0, len = posts.length; j < len; j++) {
        post = posts[j];
        post.content = this.handleContent(post);
        view += this.__post(post);
      }
      this.parent.html(view);
      return this.parent.linkify();
    },
    handleContent: function(post, content) {
      var ref, ref1;
      if (content == null) {
        content = '';
      }
      if (post.reply_to !== void 0) {
        content += this.__replyTo(post.reply_to);
      }
      if ((ref = post.type) === 'text' || ref === 'link' || ref === 'code') {
        content += post.content;
      }
      if ((ref1 = post.type) === 'image') {
        content += this.__postImage(post.image);
      }
      return content;
    },
    __replyTo: function(id) {
      return "RE: <a href=\"/post/" + id + "/\">#" + PAGE_NAME + id + "</a>&nbsp;";
    },
    __postImage: function(url) {
      return "<img src=\"" + url + "\" class=\"img-responsive\" />";
    },
    __post: function(data) {
      return "<li>\n  <strong>\n    <a href=\"/post/" + data.id + "/\"><mark>#" + PAGE_NAME + data.id + "</mark></a>\n  </strong><br />\n  <span class=\"post-content\">" + data.content + "</span>\n</li>";
    }
  };

  View.prototype.posts = {
    parent: $('#posts-table tbody'),
    create: function(posts, view) {
      var j, len, post;
      if (view == null) {
        view = '';
      }
      for (j = 0, len = posts.length; j < len; j++) {
        post = posts[j];
        post.state = this.handleState(post.state);
        view += this.__post(post);
      }
      return this.parent.html(view);
    },
    handleState: function(state) {
      if (state === 'published') {
        return TEXT.published;
      }
      if (state === 'denied') {
        return TEXT.denied;
      }
      if (state === 'pending') {
        return TEXT.pending;
      }
      if (state === 'analysing') {
        return TEXT.analysing;
      }
      if (state === 'queuing') {
        return TEXT.queuing;
      }
      if (state === 'failed') {
        return TEXT.failed;
      }
    },
    __post: function(data) {
      return "<tr data-key=\"" + data.key + "\">\n  <td>" + data.id + "</td>\n  <td class=\"span6\">\n    <a href=\"/post/?key=" + data.key + "\" target=\"_blank\">\n      " + data.content + "\n    </a><br />\n  </td>\n  <td>" + data.state + "</td>\n  <td>" + data.created_at + "</td>\n  <td>\n    <button type=\"button\" class=\"btn btn-danger\">刪除</button>\n  </td>\n</tr>";
    }
  };

  View.prototype.posts_pagination = {
    parent: $('#posts-table tfoot tr td .pagination ul'),
    create: function(data, view) {
      var active, i, j, ref;
      if (view == null) {
        view = '';
      }
      if (data.total_page !== 1) {
        for (i = j = 1, ref = data.total_page; 1 <= ref ? j <= ref : j >= ref; i = 1 <= ref ? ++j : --j) {
          active = i === data.current_page ? 'active' : '';
          view += this.__li(i, active);
        }
      }
      return this.parent.html(view);
    },
    __li: function(i, active) {
      if (active == null) {
        active = '';
      }
      return "<li class=\"" + active + "\"><a href=\"/me/posts/?page=" + i + "\">" + i + "</a></li>";
    }
  };

  return View;

})();

global.View = new View;

module.exports = View;


}).call(this,typeof global !== "undefined" ? global : typeof self !== "undefined" ? self : typeof window !== "undefined" ? window : {})

},{}],3:[function(require,module,exports){
var Posts, User, View;

View = require('./../component/View');

User = require('./../component/User');

Posts = require('./../partial/Posts');


},{"./../component/User":1,"./../component/View":2,"./../partial/Posts":4}],4:[function(require,module,exports){
var UserPosts,
  bind1 = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

UserPosts = (function() {
  function UserPosts() {
    this.callback = bind1(this.callback, this);
    this.initial = bind1(this.initial, this);
    this.container = $('#recently-posts');
    this.url = API_URL + 'me/posts';
    this.current_page = inputGet('page', 1);
    this.initial();
  }

  UserPosts.prototype.initial = function() {
    get(this.url, this.callback, {
      page: this.current_page,
      token: ACCESS_TOKEN
    });
    return this.bind();
  };

  UserPosts.prototype.callback = function(response) {
    if (response.success) {
      if (this.current_page > response.data.total_page) {
        return redirect('/me/posts/');
      }
      View.posts.create(response.data.posts);
      return View.posts_pagination.create(response.data);
    } else {
      return View.message.failed(this.container);
    }
  };

  UserPosts.prototype.bind = function() {
    return bind('.button-post-delete', 'click', this.handlePostDelete);
  };

  return UserPosts;

})();

UserPosts = new UserPosts;

module.exports = UserPosts;


},{}]},{},[3])
//# sourceMappingURL=data:application/json;charset=utf-8;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbIm5vZGVfbW9kdWxlcy9icm93c2VyLXBhY2svX3ByZWx1ZGUuanMiLCJhc3NldHMvY29mZmVlL2NvbXBvbmVudC9Vc2VyLmNvZmZlZSIsImFzc2V0cy9jb2ZmZWUvY29tcG9uZW50L1ZpZXcuY29mZmVlIiwiYXNzZXRzL2NvZmZlZS9wYWdlL3Bvc3RzLmNvZmZlZSIsImFzc2V0cy9jb2ZmZWUvcGFydGlhbC9Qb3N0cy5jb2ZmZWUiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IkFBQUE7O0FDQUEsSUFBQSxJQUFBO0VBQUE7O0FBQU07RUFFUyxjQUFBOzs7SUFDWCxJQUFDLENBQUEsRUFBRCxHQUFNO0lBQ04sSUFBQyxDQUFBLGNBQUQsR0FBa0I7SUFDbEIsSUFBQyxDQUFBLGlCQUFELENBQUE7SUFDQSxJQUFDLENBQUEsY0FBRCxDQUFBO0lBQ0EsSUFBQyxDQUFBLElBQUQsQ0FBQTtFQUxXOztpQkFPYixJQUFBLEdBQU0sU0FBQTtJQUNKLElBQUEsQ0FBSyxzQkFBTCxFQUE2QixPQUE3QixFQUFzQyxDQUFFLENBQUEsU0FBQSxLQUFBO2FBQUEsU0FBQTtlQUFHLEtBQUMsQ0FBQSxLQUFELENBQU8sUUFBUDtNQUFIO0lBQUEsQ0FBQSxDQUFBLENBQUEsSUFBQSxDQUFGLENBQXRDO0lBQ0EsSUFBQSxDQUFLLHlCQUFMLEVBQWdDLE9BQWhDLEVBQXlDLENBQUUsQ0FBQSxTQUFBLEtBQUE7YUFBQSxTQUFBO2VBQUcsS0FBQyxDQUFBLEtBQUQsQ0FBTyxXQUFQO01BQUg7SUFBQSxDQUFBLENBQUEsQ0FBQSxJQUFBLENBQUYsQ0FBekM7V0FDQSxJQUFBLENBQUssZ0JBQUwsRUFBdUIsT0FBdkIsRUFBZ0MsSUFBQyxDQUFBLE1BQWpDO0VBSEk7O2lCQUtOLEtBQUEsR0FBTyxTQUFDLFFBQUQ7V0FDTCxRQUFBLENBQVMsUUFBQSxHQUFXLFFBQXBCO0VBREs7O2lCQUdQLE1BQUEsR0FBUSxTQUFBO0lBQ04sT0FBTyxDQUFDLEdBQVIsQ0FBWSxPQUFaLEVBQXFCLEVBQXJC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UyxTQUFBO0lBQ1AsR0FBQSxDQUFJLElBQUMsQ0FBQSxHQUFMLEVBQVUsSUFBQyxDQUFBLFFBQVgsRUFBcUI7TUFBRSxJQUFBLEVBQU0sSUFBQyxDQUFBLFlBQVQ7TUFBdUIsS0FBQSxFQUFPLFlBQTlCO0tBQXJCO1dBQ0EsSUFBQyxDQUFBLElBQUQsQ0FBQTtFQUZPOztzQkFJVCxRQUFBLEdBQVUsU0FBQyxRQUFEO0lBQ1IsSUFBRyxRQUFRLENBQUMsT0FBWjtNQUNFLElBQWdDLElBQUMsQ0FBQSxZQUFELEdBQWdCLFFBQVEsQ0FBQyxJQUFJLENBQUMsVUFBOUQ7QUFBQSxlQUFPLFFBQUEsQ0FBUyxZQUFULEVBQVA7O01BQ0EsSUFBSSxDQUFDLEtBQUssQ0FBQyxNQUFYLENBQWtCLFFBQVEsQ0FBQyxJQUFJLENBQUMsS0FBaEM7YUFDQSxJQUFJLENBQUMsZ0JBQWdCLENBQUMsTUFBdEIsQ0FBNkIsUUFBUSxDQUFDLElBQXRDLEVBSEY7S0FBQSxNQUFBO2FBS0UsSUFBSSxDQUFDLE9BQU8sQ0FBQyxNQUFiLENBQW9CLElBQUMsQ0FBQSxTQUFyQixFQUxGOztFQURROztzQkFRVixJQUFBLEdBQU0sU0FBQTtXQUNKLElBQUEsQ0FBSyxxQkFBTCxFQUE0QixPQUE1QixFQUFxQyxJQUFDLENBQUEsZ0JBQXRDO0VBREk7Ozs7OztBQUlSLFNBQUEsR0FBWSxJQUFJOztBQUNoQixNQUFNLENBQUMsT0FBUCxHQUFpQiIsImZpbGUiOiJnZW5lcmF0ZWQuanMiLCJzb3VyY2VSb290IjoiIiwic291cmNlc0NvbnRlbnQiOlsiKGZ1bmN0aW9uIGUodCxuLHIpe2Z1bmN0aW9uIHMobyx1KXtpZighbltvXSl7aWYoIXRbb10pe3ZhciBhPXR5cGVvZiByZXF1aXJlPT1cImZ1bmN0aW9uXCImJnJlcXVpcmU7aWYoIXUmJmEpcmV0dXJuIGEobywhMCk7aWYoaSlyZXR1cm4gaShvLCEwKTt2YXIgZj1uZXcgRXJyb3IoXCJDYW5ub3QgZmluZCBtb2R1bGUgJ1wiK28rXCInXCIpO3Rocm93IGYuY29kZT1cIk1PRFVMRV9OT1RfRk9VTkRcIixmfXZhciBsPW5bb109e2V4cG9ydHM6e319O3Rbb11bMF0uY2FsbChsLmV4cG9ydHMsZnVuY3Rpb24oZSl7dmFyIG49dFtvXVsxXVtlXTtyZXR1cm4gcyhuP246ZSl9LGwsbC5leHBvcnRzLGUsdCxuLHIpfXJldHVybiBuW29dLmV4cG9ydHN9dmFyIGk9dHlwZW9mIHJlcXVpcmU9PVwiZnVuY3Rpb25cIiYmcmVxdWlyZTtmb3IodmFyIG89MDtvPHIubGVuZ3RoO28rKylzKHJbb10pO3JldHVybiBzfSkiLCJjbGFzcyBVc2VyXG5cbiAgY29uc3RydWN0b3I6IC0+XG4gICAgQG1lID0gdW5kZWZpbmVkXG4gICAgQGlkZW50aWZpY2F0aW9uID0gdW5kZWZpbmVkXG4gICAgQGdldElkZW50aWZpY2F0aW9uKClcbiAgICBAZ2V0TG9naW5TdGF0dXMoKVxuICAgIEBiaW5kKClcblxuICBiaW5kOiAtPlxuICAgIGJpbmQgJy5idXR0b24tZ2l0aHViLWxvZ2luJywgJ2NsaWNrJywgKCA9PiBAbG9naW4gJ2dpdGh1YicgKVxuICAgIGJpbmQgJy5idXR0b24tYml0YnVja2V0LWxvZ2luJywgJ2NsaWNrJywgKCA9PiBAbG9naW4gJ2JpdGJ1Y2tldCcgKVxuICAgIGJpbmQgJy5idXR0b24tbG9nb3V0JywgJ2NsaWNrJywgQGxvZ291dFxuXG4gIGxvZ2luOiAocHJvdmlkZXIpID0+XG4gICAgcmVkaXJlY3QgQVVUSF9VUkwgKyBwcm92aWRlclxuXG4gIGxvZ291dDogLT5cbiAgICBDb29raWVzLnNldCAnX2dnaWQnLCAnJywge2V4cGlyZXM6IDAsIHBhdGg6ICcvJywgSHRtbGFpbjogJy5rb2JlZW5naW5lZXIuaW8nfVxuICAgIHJlZGlyZWN0ICcvJ1xuXG4gIGdldExvZ2luU3RhdHVzOiAtPlxuICAgIGlmIEBoYXNUb2tlbigpXG4gICAgICBnZXQgQVBJX1VSTCArICdtZScsICgocmVzcG9uc2UpIC0+XG4gICAgICAgIGlmIHJlc3BvbnNlLnN0YXR1cyBpcyAnY29ubmVjdGVkJ1xuICAgICAgICAgIEBtZSA9IHJlc3BvbnNlLnVzZXJcbiAgICAgICAgICBWaWV3LnN3aXRjaCAndXNlcidcbiAgICAgICAgZWxzZVxuICAgICAgICAgIFZpZXcuc3dpdGNoICdndWVzdCdcbiAgICAgICkuYmluZChAKSwgeyB0b2tlbjogQUNDRVNTX1RPS0VOIH1cbiAgICBlbHNlXG4gICAgICBWaWV3LnN3aXRjaCAnZ3Vlc3QnXG5cbiAgZ2V0SWRlbnRpZmljYXRpb246IC0+XG4gICAgaWYgbG9jYWxTdG9yYWdlLmdldEl0ZW0oJ2lkZW50aWZpY2F0aW9uJykgaXMgbnVsbFxuICAgICAgcG9zdCBBUElfVVJMICsgJ2NsaWVudCcsICgocmVzcG9uc2UpIC0+XG4gICAgICAgIGlkZW50aWZpY2F0aW9uID0gcmVzcG9uc2UuZGF0YS5pZGVudGlmaWNhdGlvblxuICAgICAgICBsb2NhbFN0b3JhZ2Uuc2V0SXRlbSAnaWRlbnRpZmljYXRpb24nLCBpZGVudGlmaWNhdGlvblxuICAgICAgICBAaWRlbnRpZmljYXRpb24gPSBpZGVudGlmaWNhdGlvblxuICAgICAgKS5iaW5kKEApXG4gICAgZWxzZVxuICAgICAgQGlkZW50aWZpY2F0aW9uID0gbG9jYWxTdG9yYWdlLmdldEl0ZW0oJ2lkZW50aWZpY2F0aW9uJylcblxuICBoYXNUb2tlbjogPT5cbiAgICBpZiBBQ0NFU1NfVE9LRU4gaW4gW3VuZGVmaW5lZCwgJyddIHRoZW4gZmFsc2UgZWxzZSB0cnVlXG5cbmdsb2JhbC5Vc2VyID0gbmV3IFVzZXJcbm1vZHVsZS5leHBvcnRzID0gVXNlclxuIiwiY2xhc3MgVmlld1xuXG4gIHN3aXRjaDogKHR5cGUpIC0+XG4gICAgaWYgdHlwZSBpcyAndXNlcidcbiAgICAgICQoJ2JvZHknKS5yZW1vdmVDbGFzcygnZ3Vlc3QnKS5hZGRDbGFzcyAndXNlcidcbiAgICAgIEBuYXZiYXIudXNlcigpXG4gICAgZWxzZVxuICAgICAgJCgnYm9keScpLnJlbW92ZUNsYXNzKCd1c2VyJykuYWRkQ2xhc3MgJ2d1ZXN0J1xuICAgICAgQG5hdmJhci5ndWVzdCgpXG5cbiAgbWVzc2FnZTpcbiAgICBmYWlsZWQ6IChwYXJlbnQpIC0+XG4gICAgICB2aWV3ID0gXCJcIlwiXG4gICAgICAgIDxzcGFuPkxvYWQgZmFpbGVkPC9zcGFuPlxuICAgICAgXCJcIlwiXG4gICAgICBwYXJlbnQuYXBwZW5kIHZpZXdcblxuICBuYXZiYXI6XG4gICAgcGFyZW50OiAkKCcjbWFpbi1tZW51LWxlZnQnKVxuICAgIHVzZXI6IC0+XG4gICAgICB2aWV3ID0gXCJcIlwiXG4gICAgICAgIDxsaSBjbGFzcz1cImRyb3Bkb3duXCIgaWQ9XCJwcmV2aWV3LW1lbnVcIj5cbiAgICAgICAgICA8YSBjbGFzcz1cImRyb3Bkb3duLXRvZ2dsZVwiIGRhdGEtdG9nZ2xlPVwiZHJvcGRvd25cIiBocmVmPVwiI1wiPlxuICAgICAgICAgICAgTWVtYmVyIDxiIGNsYXNzPVwiY2FyZXRcIj48L2I+XG4gICAgICAgICAgPC9hPlxuICAgICAgICAgIDx1bCBjbGFzcz1cImRyb3Bkb3duLW1lbnVcIj5cbiAgICAgICAgICAgIDxsaT48YSBocmVmPVwiL21lL3Bvc3RzL1wiPk15IHBvc3RzPC9hPjwvbGk+XG4gICAgICAgICAgICA8bGk+PGEgaHJlZj1cIi9tZS9zZXR0aW5nL1wiPlNldHRpbmc8L2E+PC9saT5cbiAgICAgICAgICAgIDxsaT48YSBocmVmPVwiamF2YXNjcmlwdDp2b2lkKDApXCIgY2xhc3M9XCJidXR0b24tbG9nb3V0XCI+TG9nb3V0PC9hPjwvbGk+XG4gICAgICAgICAgPC91bD5cbiAgICAgICAgPC9saT5cbiAgICAgIFwiXCJcIlxuICAgICAgQHBhcmVudC5hcHBlbmQgdmlld1xuICAgIGd1ZXN0OiAtPlxuICAgICAgdmlldyA9IFwiXCJcIlxuICAgICAgICA8bGkgY2xhc3M9XCJkcm9wZG93blwiIGlkPVwicHJldmlldy1tZW51XCI+XG4gICAgICAgICAgPGEgY2xhc3M9XCJkcm9wZG93bi10b2dnbGVcIiBkYXRhLXRvZ2dsZT1cImRyb3Bkb3duXCIgaHJlZj1cIiNcIj5cbiAgICAgICAgICAgIExvZ2luIDxiIGNsYXNzPVwiY2FyZXRcIj48L2I+XG4gICAgICAgICAgPC9hPlxuICAgICAgICAgIDx1bCBjbGFzcz1cImRyb3Bkb3duLW1lbnVcIj5cbiAgICAgICAgICAgIDxsaT48YSBocmVmPVwiamF2YXNjcmlwdDp2b2lkKDApXCIgY2xhc3M9XCJidXR0b24tZ2l0aHViLWxvZ2luXCI+R2l0SHViIGxvZ2luPC9hPjwvbGk+XG4gICAgICAgICAgICA8bGk+PGEgaHJlZj1cImphdmFzY3JpcHQ6dm9pZCgwKVwiIGNsYXNzPVwiYnV0dG9uLWJpdGJ1Y2tldC1sb2dpblwiPkJpdGJ1Y2tldCBsb2dpbjwvYT48L2xpPlxuICAgICAgICAgIDwvdWw+XG4gICAgICAgIDwvbGk+XG4gICAgICBcIlwiXCJcbiAgICAgIEBwYXJlbnQuYXBwZW5kIHZpZXdcblxuICBzaWRlYmFyOlxuICAgIHBhcmVudDogJCgnI3JlY2VudGx5LXBvc3RzJylcbiAgICBjcmVhdGU6IChwb3N0cywgdmlldyA9ICcnKSAtPlxuICAgICAgZm9yIHBvc3QgaW4gcG9zdHNcbiAgICAgICAgcG9zdC5jb250ZW50ID0gQGhhbmRsZUNvbnRlbnQgcG9zdFxuICAgICAgICB2aWV3ICs9IEBfX3Bvc3QgcG9zdFxuICAgICAgQHBhcmVudC5odG1sIHZpZXdcbiAgICAgIEBwYXJlbnQubGlua2lmeSgpXG4gICAgaGFuZGxlQ29udGVudDogKHBvc3QsIGNvbnRlbnQgPSAnJykgLT5cbiAgICAgIGlmIHBvc3QucmVwbHlfdG8gaXNudCB1bmRlZmluZWQgdGhlbiBjb250ZW50ICs9IEBfX3JlcGx5VG8gcG9zdC5yZXBseV90b1xuICAgICAgaWYgcG9zdC50eXBlIGluIFsndGV4dCcsICdsaW5rJywgJ2NvZGUnXSB0aGVuIGNvbnRlbnQgKz0gcG9zdC5jb250ZW50XG4gICAgICBpZiBwb3N0LnR5cGUgaW4gWydpbWFnZSddIHRoZW4gY29udGVudCArPSBAX19wb3N0SW1hZ2UgcG9zdC5pbWFnZVxuICAgICAgY29udGVudFxuICAgIF9fcmVwbHlUbzogKGlkKSAtPlxuICAgICAgXCJcIlwiXG4gICAgICAgIFJFOiA8YSBocmVmPVwiL3Bvc3QvI3sgaWQgfS9cIj4jI3sgUEFHRV9OQU1FIH0jeyBpZCB9PC9hPiZuYnNwO1xuICAgICAgXCJcIlwiXG4gICAgX19wb3N0SW1hZ2U6ICh1cmwpIC0+XG4gICAgICBcIlwiXCJcbiAgICAgICAgPGltZyBzcmM9XCIjeyB1cmwgfVwiIGNsYXNzPVwiaW1nLXJlc3BvbnNpdmVcIiAvPlxuICAgICAgXCJcIlwiXG4gICAgX19wb3N0OiAoZGF0YSkgLT5cbiAgICAgIFwiXCJcIlxuICAgICAgICA8bGk+XG4gICAgICAgICAgPHN0cm9uZz5cbiAgICAgICAgICAgIDxhIGhyZWY9XCIvcG9zdC8jeyBkYXRhLmlkIH0vXCI+PG1hcms+IyN7IFBBR0VfTkFNRSB9I3sgZGF0YS5pZCB9PC9tYXJrPjwvYT5cbiAgICAgICAgICA8L3N0cm9uZz48YnIgLz5cbiAgICAgICAgICA8c3BhbiBjbGFzcz1cInBvc3QtY29udGVudFwiPiN7IGRhdGEuY29udGVudCB9PC9zcGFuPlxuICAgICAgICA8L2xpPlxuICAgICAgXCJcIlwiXG5cbiAgcG9zdHM6XG4gICAgcGFyZW50OiAkKCcjcG9zdHMtdGFibGUgdGJvZHknKVxuICAgIGNyZWF0ZTogKHBvc3RzLCB2aWV3ID0gJycpIC0+XG4gICAgICBmb3IgcG9zdCBpbiBwb3N0c1xuICAgICAgICBwb3N0LnN0YXRlID0gQGhhbmRsZVN0YXRlIHBvc3Quc3RhdGVcbiAgICAgICAgdmlldyArPSBAX19wb3N0IHBvc3RcbiAgICAgIEBwYXJlbnQuaHRtbCB2aWV3XG4gICAgaGFuZGxlU3RhdGU6IChzdGF0ZSkgLT5cbiAgICAgIHJldHVybiBURVhULnB1Ymxpc2hlZCBpZiBzdGF0ZSBpcyAncHVibGlzaGVkJ1xuICAgICAgcmV0dXJuIFRFWFQuZGVuaWVkIGlmIHN0YXRlIGlzICdkZW5pZWQnXG4gICAgICByZXR1cm4gVEVYVC5wZW5kaW5nIGlmIHN0YXRlIGlzICdwZW5kaW5nJ1xuICAgICAgcmV0dXJuIFRFWFQuYW5hbHlzaW5nIGlmIHN0YXRlIGlzICdhbmFseXNpbmcnXG4gICAgICByZXR1cm4gVEVYVC5xdWV1aW5nIGlmIHN0YXRlIGlzICdxdWV1aW5nJ1xuICAgICAgcmV0dXJuIFRFWFQuZmFpbGVkIGlmIHN0YXRlIGlzICdmYWlsZWQnXG4gICAgX19wb3N0OiAoZGF0YSkgLT5cbiAgICAgIFwiXCJcIlxuICAgICAgICA8dHIgZGF0YS1rZXk9XCIjeyBkYXRhLmtleSB9XCI+XG4gICAgICAgICAgPHRkPiN7IGRhdGEuaWQgfTwvdGQ+XG4gICAgICAgICAgPHRkIGNsYXNzPVwic3BhbjZcIj5cbiAgICAgICAgICAgIDxhIGhyZWY9XCIvcG9zdC8/a2V5PSN7IGRhdGEua2V5IH1cIiB0YXJnZXQ9XCJfYmxhbmtcIj5cbiAgICAgICAgICAgICAgI3sgZGF0YS5jb250ZW50IH1cbiAgICAgICAgICAgIDwvYT48YnIgLz5cbiAgICAgICAgICA8L3RkPlxuICAgICAgICAgIDx0ZD4jeyBkYXRhLnN0YXRlIH08L3RkPlxuICAgICAgICAgIDx0ZD4jeyBkYXRhLmNyZWF0ZWRfYXQgfTwvdGQ+XG4gICAgICAgICAgPHRkPlxuICAgICAgICAgICAgPGJ1dHRvbiB0eXBlPVwiYnV0dG9uXCIgY2xhc3M9XCJidG4gYnRuLWRhbmdlclwiPuWIqumZpDwvYnV0dG9uPlxuICAgICAgICAgIDwvdGQ+XG4gICAgICAgIDwvdHI+XG4gICAgICBcIlwiXCJcblxuICBwb3N0c19wYWdpbmF0aW9uOlxuICAgIHBhcmVudDogJCgnI3Bvc3RzLXRhYmxlIHRmb290IHRyIHRkIC5wYWdpbmF0aW9uIHVsJylcbiAgICBjcmVhdGU6IChkYXRhLCB2aWV3ID0gJycpIC0+XG4gICAgICBpZiBkYXRhLnRvdGFsX3BhZ2UgaXNudCAxXG4gICAgICAgIGZvciBpIGluIFsxLi5kYXRhLnRvdGFsX3BhZ2VdXG4gICAgICAgICAgYWN0aXZlID0gaWYgaSBpcyBkYXRhLmN1cnJlbnRfcGFnZSB0aGVuICdhY3RpdmUnIGVsc2UgJydcbiAgICAgICAgICB2aWV3ICs9IEBfX2xpIGksIGFjdGl2ZVxuICAgICAgQHBhcmVudC5odG1sIHZpZXdcbiAgICBfX2xpOiAoaSwgYWN0aXZlID0gJycpIC0+XG4gICAgICBcIlwiXCJcbiAgICAgICAgPGxpIGNsYXNzPVwiI3sgYWN0aXZlIH1cIj48YSBocmVmPVwiL21lL3Bvc3RzLz9wYWdlPSN7IGkgfVwiPiN7IGkgfTwvYT48L2xpPlxuICAgICAgXCJcIlwiXG5cblxuZ2xvYmFsLlZpZXcgPSBuZXcgVmlld1xubW9kdWxlLmV4cG9ydHMgPSBWaWV3XG4iLCIjIGNvcmVcblZpZXcgPSByZXF1aXJlICdjb21wb25lbnQvVmlldydcblVzZXIgPSByZXF1aXJlICdjb21wb25lbnQvVXNlcidcblxuIyBtb2RlbFxuUG9zdHMgPSByZXF1aXJlICdwYXJ0aWFsL1Bvc3RzJ1xuIiwiY2xhc3MgVXNlclBvc3RzXG5cbiAgY29uc3RydWN0b3I6IC0+XG4gICAgQGNvbnRhaW5lciA9ICQoJyNyZWNlbnRseS1wb3N0cycpXG4gICAgQHVybCA9IEFQSV9VUkwgKyAnbWUvcG9zdHMnXG4gICAgQGN1cnJlbnRfcGFnZSA9IGlucHV0R2V0KCdwYWdlJywgMSlcbiAgICBAaW5pdGlhbCgpXG5cbiAgaW5pdGlhbDogPT5cbiAgICBnZXQgQHVybCwgQGNhbGxiYWNrLCB7IHBhZ2U6IEBjdXJyZW50X3BhZ2UsIHRva2VuOiBBQ0NFU1NfVE9LRU4gfVxuICAgIEBiaW5kKClcblxuICBjYWxsYmFjazogKHJlc3BvbnNlKSA9PlxuICAgIGlmIHJlc3BvbnNlLnN1Y2Nlc3NcbiAgICAgIHJldHVybiByZWRpcmVjdCAnL21lL3Bvc3RzLycgaWYgQGN1cnJlbnRfcGFnZSA+IHJlc3BvbnNlLmRhdGEudG90YWxfcGFnZVxuICAgICAgVmlldy5wb3N0cy5jcmVhdGUgcmVzcG9uc2UuZGF0YS5wb3N0c1xuICAgICAgVmlldy5wb3N0c19wYWdpbmF0aW9uLmNyZWF0ZSByZXNwb25zZS5kYXRhXG4gICAgZWxzZVxuICAgICAgVmlldy5tZXNzYWdlLmZhaWxlZCBAY29udGFpbmVyXG5cbiAgYmluZDogLT5cbiAgICBiaW5kICcuYnV0dG9uLXBvc3QtZGVsZXRlJywgJ2NsaWNrJywgQGhhbmRsZVBvc3REZWxldGVcblxuXG5Vc2VyUG9zdHMgPSBuZXcgVXNlclBvc3RzXG5tb2R1bGUuZXhwb3J0cyA9IFVzZXJQb3N0c1xuIl19
