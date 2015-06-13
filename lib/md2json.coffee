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
  'list':       /^(\*|\-|\d+)\s(\w|\W)+/
  'blockquote': /^>\s(\w|\W)+/
  'paragraph':  /^\w{1,}/
  'code':       /```(\w|\W)+```/i

error_collection = []

parser_first = (line) ->
  item = {}
  item.text = line
  item.status = false

  for key, value of regexp_collection
    if value.test item.text
      console.log item.text + ' \t IS \t ' + key
      item.status = true

  if item.status is false
    error_collection.push item.text
  return


worker = {}
worker.convert = (file, options) ->
  console.log 'worker is run'

  self = @

  text = file.contents.toString()
  lines = text.split('\n')

  for line in lines
    do (line) ->
      parser_first line
      return

  console.log error_collection

  worker.file = file
  return

module.exports = worker
