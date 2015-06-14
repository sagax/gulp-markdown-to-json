gulp    = require 'gulp'
md2json = require './index'

gulp.task 'gen', ->
  gulp.src 'test2.md'
    .pipe md2json()
    return

gulp.task 'default', [
  'gen'
]
