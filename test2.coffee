fs = require 'fs'

STRING=fs.readFileSync 'test3.md', 'utf8'

regexp =
  'h': /#/
  'new_line': /\n/
  'space': /\s/

get_text = (text) ->
  length = text.length
  index = 0
  text_part = []
  text_result = ''
  item_block = {}
  item_block.content = []

  run_find = ->
    find_entry text, index, change_index, push_to_block
    return

  push_to_block = (part) ->
    item_block.content.push part

  change_index = (new_index) ->
    index = new_index
    if index < length
      run_find()
    else
      console.log JSON.stringify(item_block)
    return

  run_find()

  return

find_all_block = (text, index, v, callback, callback2) ->
  text = text
  index = index
  full_part = ''
  while v.test(text[index]) is true
    full_part += text[index]
    index += 1
  console.log 'FP: ' + full_part
  callback2(full_part)
  callback(index)
  return

find_entry = (text, index, callback, callback2) ->
  for k, v of regexp
    if v.test(text[index])
      find_all_block text, index, v, callback, callback2
  return

get_text(STRING)
