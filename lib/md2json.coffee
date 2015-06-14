'use strict'

regexp_collection =
  'h1':         /^#{1}\s.+/i
  'h2':         /^#{2}\s.+/i
  'h3':         /^#{3}\s.+/i
  'h4':         /^#{4}\s.+/i
  'h5':         /^#{5}\s.+/i
  'h6':         /^#{6}\s.+/i
  'h7':         /^#{7}\s.+/i
  'italic':     /(^|\s)\*{1}\w+\*{1}(\w|\W)*/i
  'bold':       /(^|\s)\*{2}\w+\*{2}(\w|\W)*/i
  'dashe':      /^(-|\*){3,}$/i
  'empty':      /^$/i
  'image':      /!\[(\w|\s)+\]\((\w|\/)+\.\w+(\)|\s"(\w|\s)+"\))/i
  'link':       /(^|[^!])\[(\w|\s)+\]\((\w|\/)+\.\w+(\)|\s"(\w|\s)+"\))/i
  'list':       /^(\*|\-|\d{1,}\.)\s(\w|\W)+/
  'blockquote': /^>\s(\w|\W)+/
  'paragraph':  /^\w{1,}/
  'code':       /```(\w|\W)+```/i

regexp_entry_collection =
  'h': /#/
  'new_line': /\n/

error_collection = []

find_entry = (text, index, key) ->
  entry_count = 0
  index = index
  full_string = text[index]

  if key is 'h'
    fregexp = regexp_entry_collection[key]
    console.log 'FIND RUN:'
    while fregexp.test(text[index]) is true
      entry_count += 1
      index += 1
      full_string += text[index]

  console.log 'entry_count: ' + entry_count + ' : ' + 'index: ' + index + ' :: ' + full_string

  return

parse = (text, index, callback) ->
  chunk = text[index]
  callback(null, 1)
  for k, v of regexp_entry_collection
    if v.test(chunk) is true and k is 'h'
      find_entry text, index, k
  return

analysis = (text) ->
  item = {}
  item.text = text
  item.status = false
  item.length = text.length

  index = 0

  change_index = (action, new_index) ->
    if action is false or action is null or action is undefined
      index += new_index
    while index < item.length
      run_parse()
    return

  run_parse = ->
    parse item.text, index, change_index
    return

  run_parse()

  return

worker = {}
worker.convert = (file, options) ->
  console.log 'worker is run'

  self = @

  text = file.contents.toString()

  analysis text

  console.log error_collection

  worker.file = file
  return

module.exports = worker
