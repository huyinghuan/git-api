###
  项目相关
###

ProjectHooks = require './project-hooks'
Owned = require './owned'

class Projects
  constructor: (@service, @id)->
    @mainName = 'projects'
  #visibility_level:
  # Private: 0  Internal: 10 Public: 20
  post: (projects)->
    @service(@mainName, projects, 'POST')

  hooks: -> new ProjectHooks(@service, @id)

  owned: ()-> new Owned(@service, 'projects')

  all: -> @service("#{@mainName}/all")

module.exports = Projects