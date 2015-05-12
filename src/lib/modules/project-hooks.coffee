###
  Hooks设置
###
class ProjectHooks
  constructor: (@service, @projectId)->
    @mainName = "projects/#{@projectId}/hooks"

  ###
   增加项目的hooks
  ###
  post: (hooks)->
    @service(@mainName, {url: hooks, id: @projectId}, "POST")

module.exports = ProjectHooks