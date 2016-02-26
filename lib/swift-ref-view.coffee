'use strict'

FilterEditorView = require 'filter-editor-view'

module.exports =
class SwiftRefView

  constructor: (serializedState) ->
    # Create root element
    @_createFrameArea()
    filterEditor = new FilterEditorView()
    @body.appendChild(filterEditor.getElement())
    filterEditor.onFilterSync (str) ->
      Math.random() for i in [0..Math.floor(Math.random()*5)]
    @_createContentArea()

    @title.textContent = 'Swift Ref' if not serializedState?.title?
    @content.textContent = '' if not serializedState?.content?
    @root.style.width = '20em' if not serializedState?.width?

  _createFrameArea: ->
    @root = document.createElement('div')
    @root.classList.add('swift-ref')

    container = document.createElement('div')
    container.classList.add('inset-panel')

    @heading = document.createElement('div')
    @heading.classList.add('panel-heading')
    container.appendChild(@heading)

    @body = document.createElement('div')
    @body.classList.add('panel-body', 'padded')
    container.appendChild(@body)

    @root.appendChild(container)

  _createContentArea: ->
    @title = document.createElement('div')
    @heading.appendChild(@title)

    @content = document.createElement('div')
    @body.appendChild(@content)

  setWidth: (width) ->
    @root.style.width = "#{width}em"

  setTitle: (str) ->
    @title.textContent = str

  setContent: (str) ->
    @content.textContent = str

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @root.remove()

  getElement: ->
    @root
