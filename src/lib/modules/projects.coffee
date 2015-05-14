###
  项目相关
###

ProjectHooks = require './project-hooks'
Owned = require './owned'
Commits = require './commits'
Branches = require './branches'

class Projects
  constructor: (@service, @id)->
    @mainName = 'projects'
  #visibility_level:
  # Private: 0  Internal: 10 Public: 20
  post: (projects)->
    @service(@mainName, projects, 'POST')

  hooks: -> new ProjectHooks(@service, "#{@mainName}/#{@id}")

  owned: ()-> new Owned(@service, @mainName)

  commits: -> new Commits(@service, "#{@mainName}/#{@id}")

  branches: -> new Branches(@service, "#{@mainName}/#{@id}")

  ###
   only for admin
  ###
  all: -> @service("#{@mainName}/all")

  ###
    get projects of authenticated user.
  ###
  get: ->
    return @service(@mainName) if not @id
    return @service("#{@mainName}/#{@id}")


module.exports = Projects