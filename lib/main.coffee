module.exports =
  configDefaults:
    showOnRightSideOfStatusBar: true

  activate: ->
    atom.workspaceView.command('git-branch-selector:show', createGitBranchListView)

createGitBranchListView = ->
  editor = atom.workspace.getActiveEditor()
  if editor?
    GitBranchListView = require './git-branch-list-view'
    view = new GitBranchListView(editor)
    view.attach()
