'use strict'

worker = {}
worker.convert = (file, options) ->
  self = @
  document = file.contents.toString()
  open = false
  after_open = false
  block = {}
  content = ''
  name = ''
  key = ''
  iter = 0
  length = document.length

  for i in document
    if i is '{' and after_open is false
      open = true
    else if i is '{' and after_open is true
      open = true
      after_open = false
      block[key]['content'] = content
      content = ''
      name = ''
    else if iter is length-1
      block[key]['content'] = content

    if open is true
      name += i
    else
      content += i

    if i is '}'
      open = false
      after_open = true
      name = name.replace /{|}/gi, ''
      if /:/gi.test name
        name  = name.split ':'
        key   = name[0]
        value = name[1]
        block[key] = {}
        block[key]['name'] = key
        block[key]['value'] = JSON.parse value
      else
        key = name.replace /{|}/gi, ''
        block[key] = {}
        block[key]['name'] = name
      name = ''

    iter += 1

  worker.file = JSON.stringify(block)
  return

module.exports = worker
