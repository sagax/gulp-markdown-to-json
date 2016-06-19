gulp    = require 'gulp'
md2json = require './index'
options = require './options.json'

gulp.task 'gen', ->
  gulp.src 'test.md'
    .pipe md2json options
    .pipe gulp.dest './'
  return

gulp.task 'default', [
  'gen'
]
