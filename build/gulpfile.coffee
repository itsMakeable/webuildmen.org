gulp = require 'gulp'
plugins = require('gulp-load-plugins')()

# requireDir = require 'require-dir'
# requireDir './tasks',
#   recurse: true

# plugins.mainBowerFiles = require('main-bower-files');
# files = mainBowerFiles()
# plugins.preen = require 'preen'
# plugins.axis = require 'axis-css'
# plugins.nib = require 'nib'
# plugins.rupture = require 'rupture'
# plugins.prefix = require 'autoprefixer-stylus'
plugins.browserSync = require 'browser-sync'
plugins.gutil = require 'gulp-util'
plugins.svgSprite = require 'gulp-svg-sprites'


# CLean Bower Components Folders
# gulp.task 'preen', (cb) ->
# 	plugins.preen.preen {}, cb

gulp.task 'jade', (e) ->
	gulp.src(['./src/jade/**/*.jade','!./src/jade/_**/*.jade'], {base: './src/jade/'})
		.pipe plugins.jade()
		# .on('error', plugins.gutil.log)
		.pipe gulp.dest('.')


gulp.task 'coffee', (e) ->
	gulp.src([
		'./src/coffee/**/*.coffee'
	])
		.pipe plugins.coffee(
			bare: true
		).on('error', plugins.gutil.log)
		.pipe plugins.concat('main.js')
		.pipe gulp.dest('./js/')


# gulp.task 'js', ['coffee', 'templates'], (e) ->
# 	gulp.src([
# 		'./src/js/main.js'
# 		'./src/js/templates.js'
# 		'./src/js/jquery.fixer.js'
# 		])
# 		.pipe plugins.concat('main.js')
# 		.pipe plugins.uglify(
# 			mangle: false
# 			compress: false
# 			preserveComments: false
# 		)
# 		.pipe gulp.dest('./dist/js/')

# Bower Concat
# gulp.task 'TASKNAME', ->
#   # options
#   gulp.src(mainBowerFiles(), # what you want to do with the files
#     base: 'path/to/bower_components'
#   ).pipe()


gulp.task 'scss', ->
	gulp.src('./src/scss/styles.scss')
		.pipe plugins.sass()
		.pipe gulp.dest('./css')


gulp.task 'symbols', ->
	gulp.src('src/svg/*.svg')
		.pipe plugins.svgSprite(
			svg:
				symbols: 'symbol/symbols.svg'
			mode: 'symbols'
			)
		.pipe gulp.dest('src/')


gulp.task 'svg', ['symbols'], ->
	gulp.src('src/symbol/*.svg')
		.pipe plugins.html2jade(
			bodyless: true
			donotencode: true
			tabs: true
			double: true
			)
		.pipe gulp.dest('src/jade/_includes')

# gulp.task 'svg-prd', ->
# 	gulp.src('src/svg/*.svg')
# 		.pipe plugins.svgmin()
# 		.pipe gulp.dest('public/svg')

# gulp.task 'img-svg', ['svg'], ->
# gulp.src('src/img/', {read: false})
# 	.pipe plugins.clean({force: true})
# 	gulp.src('src/svg/*.svg', {base: 'assets/svg/'})
# 		# .pipe	plugins.cache('linting')
# 		.pipe plugins.svg2png([2])
# 		.pipe gulp.dest('src/img/')

# gulp.task 'img',  ->
# 	gulp.src('src/img/**/*', {base: 'src/img/'})
# 		.pipe plugins.imagemin(
# 			progressive: true
# 		)
# 		.pipe gulp.dest('dist/img/')


gulp.task 'browser-sync', ->
	plugins.browserSync.init [
		'./*.html'
		'./toolkits/**/*.html'
		'./js/**/*.js'
		'./css/**/*.css'
	],
		server:
			baseDir: './'
		# proxy: 'localhost:3000'


# TASKS #########################################

gulp.task 'dev', ['jade','scss','coffee','browser-sync']

gulp.task 'default', [
	'dev'
	], ->
		gulp.watch ['./src/jade/**/*.jade'], ['jade']
		gulp.watch ['./src/svg/**/*.svg'], ['svg']
		gulp.watch ['./src/coffee/**/*.coffee'], ['coffee']
		gulp.watch ['./src/scss/**/*.scss'], ['scss']
		# gulp.watch ['./dist/components/**/*'], ['preen']
