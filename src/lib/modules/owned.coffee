###
  当前用户相关
###

class Owned
  constructor: (@service, uri)->
    @mainName = "#{uri}/owned"

  getByName: (projectName)->
    @service(@mainName).then((data)->
      return item for item in data when item.name is projectName
    )

  get: ->
    @service(@mainName)

module.exports = Owned