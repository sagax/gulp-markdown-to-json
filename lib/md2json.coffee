'use strict'
prettyjson = require 'prettyjson'

worker = {}
worker.convert = (file, options) ->
  options = options or {}
  self = @
  main_text = file.contents.toString()

  open = false
  after_open = false
  block = {}
  content = ""
  name = ""
  key = ""
  iter = 0
  length = main_text.length

  for w in main_text
    if w is '{' and after_open is false
      open = true

    else if w is '{' and after_open is true
      open = true
      after_open = false
      block[key]['content'] = content
      content = ''
      name = ''

    else if iter is length - 1
      block[key]['content'] = content

    if open is true
      name += w

    else
      content += w

    if w is '}'
      open = false
      after_open = true
      name = name.replace /{|}/gi, ''
      if /:/gi.test name
        name  = name.split ':'
        key   = name[0]
        value = name[1]
        block[key] = {}
        block[key]['name'] = key

        try
          block[key]['value'] = JSON.parse value

        catch err
          block[key]['value'] = value

      else
        key = name.replace /{|}/gi, ''
        block[key] = {}
        block[key]['name'] = name

      name = ''

    iter += 1

  file.contents = new Buffer JSON.stringify block
  file.path = file.path.replace /.md$/, '.json'

  #console.log prettyjson.render block

  worker.file = file
  return

module.exports = worker
