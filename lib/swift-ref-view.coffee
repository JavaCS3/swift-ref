'use strict'

FilterEditorView = require 'filter-editor-view'

module.exports =
class SwiftRefView

  constructor: (serializedState) ->
    # Create root element
    @_createFrameArea()
    @filterEditor = new FilterEditorView()
    @body.appendChild(@filterEditor.getElement())
    @_createContentArea()

    @title.textContent = 'Swift Ref' if not serializedState?.title?
    @content.textContent = '' if not serializedState?.content?
    @root.style.width = '20em' if not serializedState?.width?

  _createFrameArea: ->
    @root = document.createElement('div')
    @root.classList.add('swift-ref', 'flex-container', 'inset-panel')

    @heading = document.createElement('div')
    @heading.classList.add('panel-heading', 'flex-header')
    @root.appendChild(@heading)

    @body = document.createElement('div')
    @body.classList.add('panel-body', 'padded', 'flex-body', 'flex-container')
    @root.appendChild(@body)

  _createContentArea: ->
    @title = document.createElement('div')
    @heading.appendChild(@title)

    @contentContainer = document.createElement('div')
    @contentContainer.classList.add('content-container')
    @body.appendChild(@contentContainer)

    @content = document.createElement('pre')
    @contentContainer.appendChild(@content)

  setWidth: (width) ->
    @root.style.width = "#{width}em"

  setTitle: (str) ->
    @title.textContent = str

  setContent: (str) ->
    @content.textContent = str

  onConfirmed: (callback) ->
    @filterEditor.onConfirmed callback

  onFilter: (callback) ->
    @filterEditor.onFilter callback

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @root.remove()

  getElement: ->
    @root
