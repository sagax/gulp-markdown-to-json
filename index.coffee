through = require 'through2'
gutil   = require 'gulp-util'
md2json = require './lib/md2json'

'use strict'

module.exports = (options) ->
  options = options or {}

  flush = (err) ->
    return

  transform = (file, enc, cb) ->
    if file.isNull()
      @push file

    if file.isStream()
      @emit 'error', new gutil.PluginError 'Stream content is not supported'

    if file.isBuffer()
      md2json.convert file, options
      @push md2json.file

    if cb
      cb()
    return

  through.obj transform, flush
