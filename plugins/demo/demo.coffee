'use strict'

module.exports =
  onFilter: (token, text, response) ->
    response(token, Math.random() for i in [0..Math.floor(Math.random()*5)])

  onConfirmed: ->
    console.log 'onConfirmed'
