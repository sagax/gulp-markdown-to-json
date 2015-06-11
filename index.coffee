through = require 'through2'
gutil   = require 'gulp-util'
md2json = require './lib/md2json'

module.exports = (options) ->
  'use strict'

  flush = (callback) ->
    console.log 'flush file is run'
    @push md2json.file
    callback()
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
      md2json.convert file, options
    callback()

  through.obj transform, flush
