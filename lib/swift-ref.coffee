'use strict'

SwiftRefView = require './swift-ref-view'
{CompositeDisposable} = require 'atom'

module.exports = SwiftRef =
  subscriptions: null
  handleSelectionTimeout: null

  activate: (state) ->
    console.log 'activated'
    # Views
    @swiftRefView = new SwiftRefView
    @swiftRefPanel = atom.workspace.addRightPanel(item: @swiftRefView.getElement())

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

  onSelectionChanged: (evt) ->
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
