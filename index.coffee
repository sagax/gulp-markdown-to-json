through  = require('through2')
gutil    = require('gulp-util')
md2json  = require('./lib/md2json')

module.exports = (insertText) ->
  'use strict'

  flush = ->
    return

  transform = (file, enc, callback) ->
    if file.isNull()
      @push file
      return callback()
    if file.isStream()
      @emit 'error', new (gutil.PluginError)(
        'Stream content is not supported'
      )
      return callback()
    if file.isBuffer()
      md2json.compile file
    callback()

  through.obj transform, flush
