'use strict'

module.exports =
  onFilter: (token, text, response) ->
    response(token, Math.random() for i in [0..Math.floor(Math.random()*5)])

  onConfirmed: (token, text, response) ->
    console.log 'onConfirmed', token, response
    response(token, token)
