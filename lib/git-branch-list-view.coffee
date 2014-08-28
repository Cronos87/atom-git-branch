{SelectListView} = require 'atom'

git = atom.project.getRepo()

# View to display a list of grammars to apply to the current editor.
module.exports =
class GitBranchListView extends SelectListView
  initialize: (@editor) ->
    super

    @addClass('git-branch-selector from-top overlay')
    @list.addClass('mark-active')

    @currentGitBranch = @getGitBranch()

    @subscribe this, 'git-branch-selector:show', =>
      @cancel()
      false

    @setItems(@getGitBranchs())

  getFilterKey: ->
    'name'

  viewForItem: (branch) ->
    element = document.createElement('li')
    element.classList.add('active') if branch is @currentGitBranch
    element.textContent = branch.name ? branch.scopeName
    element

  confirmed: (branch) ->
    @cancel()
    git.checkoutReference(branch.name)

  attach: ->
    @storeFocusedElement()
    atom.workspaceView.append(this)
    @focusFilterEditor()

  getGitBranch: ->
    branch = {name: git.getShortHead()}

    branch

  getGitBranchs: ->
    branchs = []

    for key, branch of git.getReferences().heads
      branchs.push {name: branch.replace "refs/heads/", ""}

    branchs
