'use strict'

SwiftRefView = require './swift-ref-view'
DemoFilter = require '../plugins/demo/demo'

{CompositeDisposable} = require 'atom'

module.exports = SwiftRef =
  # Config
  config:
    someSetting:
      type: 'array'
      default: ['1', '2', '3']
      items:
        type: 'string'

  # Object member variables
  subscriptions: null
  handleSelectionTimeout: null

  activate: (state) ->
    console.log 'activated'
    # Views
    @swiftRefView = new SwiftRefView
    @swiftRefPanel = atom.workspace.addRightPanel(item: @swiftRefView.getElement())

    @swiftRefView.onFilter DemoFilter.onFilter
    @swiftRefView.onConfirmed DemoFilter.onConfirmed

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.workspace.observeTextEditors (editor) =>
      editor.onDidChangeSelectionRange (event) => @onSelectionChanged (event)

  deactivate: ->
    @swiftRefView?.destroy()
    @swiftRefPanel?.destroy()
    @subscriptions?.dispose()

  serialize: ->

  onSelectionChanged: (event) ->
    clearTimeout(@handleSelectionTimeout)
    @handleSelectionTimeout = null

    editor = atom.workspace.getActiveTextEditor()
    return unless editor

    return unless editor.getSelectedText().length > 0 and not editor.hasMultipleCursors()
    @handleSelectionTimeout = setTimeout (=> @handleSelection()), 1000

  handleSelection: ->
    console.log 'handleSelection'
    clearTimeout(@handleSelectionTimeout)
    @handleSelectionTimeout = null

    editor = atom.workspace.getActiveTextEditor()
    return unless editor

    console.log "selected [#{editor.getSelectedText()}]"
    @swiftRefView.setContent(editor.getSelectedText())
