gulp    = require 'gulp'
md2json = require './index'

gulp.task 'gen', ->
  gulp.src 'test.md'
    .pipe md2json()
    return

gulp.task 'default', [
  'gen'
]
