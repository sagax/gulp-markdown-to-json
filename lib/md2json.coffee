'use strict'
worker = {}
worker.convert = (file, options) ->
  console.log 'worker is run'
  console.log file.contents.toString()
  worker.file = file
  return

module.exports = worker
