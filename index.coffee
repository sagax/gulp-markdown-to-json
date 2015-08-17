through = require 'through2'
gutil   = require 'gulp-util'
md2json = require './lib/md2json'

module.exports = (options) ->
  'use strict'

  flush = (callback) ->
    @push md2json.file
    callback()
    return

  transform = (file, enc, callback) ->
    if file.isNull()
      @push file
      callback()
    if file.isStream()
      @emit 'error', new (gutil.PluginError)(
        'Stream content is not supported'
      )
      callback()
    if file.isBuffer()
      md2json.convert file, options
      @push md2json.file
    callback()

  through.obj transform
