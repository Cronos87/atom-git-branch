{SelectListView} = require 'atom'

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
    alert "ok"

  attach: ->
    @storeFocusedElement()
    atom.workspaceView.append(this)
    @focusFilterEditor()

  getGitBranch: ->
    branchs = {name: "admin"}

    branchs

  getGitBranchs: ->
    branchs = @test()

    branchs

  test: ->
    branchs = [{name: "master"}, {name: "admin"}]
