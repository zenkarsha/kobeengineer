// Config
var enable_livereload = true;
// var enable_livereload = false;
var enable_uglify = true;
// var enable_uglify = false;


// Include packages
var gulp            = require('gulp');
var gulpif          = require('gulp-if');
var gutil           = require('gulp-util');
var browserSync     = require('browser-sync');
var stylus          = require('gulp-stylus');
var coffee          = require('gulp-coffee');
var nib             = require('nib');
var jeet            = require('jeet');
var prefix          = require('gulp-autoprefixer');
var cp              = require('child_process');
var uglify          = require('gulp-uglify');
var rupture         = require('rupture');
var browserify      = require('browserify');
var tap             = require('gulp-tap');
var buffer          = require('gulp-buffer');
var coffeeify       = require('coffeeify');
var rename          = require("gulp-rename");
var aliasify        = require("aliasify");


// GO!
console.log("\u001b[2J\u001b[0;0H");

var messages = {
  jekyllBuild: '<span style="color: grey">Running:</span> $ jekyll build'
};

function onError(err) {
  console.log(err);
  this.emit('end');
}

gulp.task('jekyll', function (done) {
  browserSync.notify(messages.jekyllBuild);
  return cp.spawn('jekyll', ['build'], {stdio: 'inherit'})
    .on('close', done);
});

gulp.task('jekyll-rebuild', ['jekyll'], function () {
  if (enable_livereload) {
    browserSync.reload();
  }
});

gulp.task('refresh-page', ['jekyll'], function () {
  if (enable_livereload) {
    browserSync.reload("*.html");
  }
});

gulp.task('browser-sync', ['jekyll'], function() {
  browserSync({
    server: {
      baseDir: '_site',
    },
    open: false
  });
});

gulp.task('stylus', function () {
  return gulp.src('assets/stylus/all.styl')
    .pipe(stylus({
      use: [nib(), jeet(), rupture()],
      compress: true
    }))
    .pipe(prefix(['last 15 versions', '> 1%', 'ie 8', 'ie 7'], { cascade: true }))
    .pipe(gulp.dest('_site/css'))
    .pipe(gulpif(enable_livereload, browserSync.reload({stream:true})))
    .on('error', onError)
    .pipe(gulp.dest('css'));
});

gulp.task('coffee', function() {
  return gulp.src('assets/coffee/*.coffee')
    .pipe(coffee({bare: true}).on('error', gutil.log))
    .pipe(gulp.dest('_site/js'))
    .pipe(gulpif(enable_uglify, uglify()))
    .pipe(gulpif(enable_livereload, browserSync.reload({stream:true})))
    .on('error', onError)
    .pipe(gulp.dest('js'));
});

gulp.task('browserify', function() {
  return gulp.src('assets/coffee/page/*.coffee', {read: false})
    .pipe(tap(function (file) {
      gutil.log('bundling ' + file.path);
      file.contents = browserify(file.path, {
        debug: true,
        extensions: ['.coffee']
      })
      .transform({global: true}, aliasify)
      .transform(coffeeify, {
        bare: true
      })
      .bundle();
    }))
    .pipe(buffer())
    .pipe(gulpif(enable_uglify, uglify()))
    .pipe(rename(function (path) {
        path.extname = '.js';
    }))
    .pipe(gulp.dest('_site/js/page/'))
    .pipe(gulpif(enable_livereload, browserSync.reload({stream:true})))
    .pipe(gulp.dest('js/page'));
});

gulp.task('images', function() {
  return gulp.src('images/**/*')
    .pipe(gulp.dest('_site/images'))
    .pipe(browserSync.reload({stream: true}));
});

gulp.task('watch', function () {
  gulp.watch('assets/stylus/**/*', ['stylus']);
  gulp.watch(['assets/coffee/page/*', 'assets/coffee/component/*', 'assets/coffee/partial/*', 'assets/coffee/view/*'], ['browserify']);
  gulp.watch('assets/coffee/*', ['coffee']);
  gulp.watch(['images/**/*'], ['images']);
  gulp.watch(['vendor/**/*'], ['jekyll-rebuild']);
  gulp.watch(['*.html', '_layouts/*', '_includes/**/*', 'pages/*'], ['refresh-page']);
  gulp.watch(['_site/js/**/*', '_site/css/**/*'], ['refresh-page']);
});

gulp.task('default', ['stylus', 'coffee', 'browserify', 'images', 'browser-sync', 'watch']);
