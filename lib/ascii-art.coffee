{CompositeDisposable} = require 'atom'

module.exports = AsciiArt =
  subscriptions: null

  activate: ->
    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'ascii-art:convert': => @convert()

  deactive: ->
    @subscriptions.dispose()

  convert: ->
    console.log 'Convert Text!'
    if editor = atom.workspace.getActiveTextEditor()
      selection = editor.getSelectedText()

      figlet = require 'figlet'

      console.log "Convertting #{selection}..."
      figlet selection, (error, art) ->
        if error
          console.error error
        else
          editor.insertText("\n#{art}\n")
