###
  Hooks设置
###
class ProjectHooks
  constructor: (@service, mainName)->
    @mainName = "#{mainName}/hooks"

  ###
   增加项目的hooks
  ###
  post: (hooks)->
    @service(@mainName, {url: hooks}, "POST")

module.exports = ProjectHooks