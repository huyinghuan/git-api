
###
  统一对外接口
###

_q = require 'q'
_request = require 'request'

Projects = require './modules/projects'

class GitLabInterface
  ###
    @constructor
    @params {string} the token of gitlab
    @params {string} the url of gitlab
    @return {Function}
  ###
  constructor: (@token, @url)->

  ###
    @private
    @return {Function}
  ###
  service: ()->
    API = @url
    token = @token
    (api, params = {}, method = 'GET')->
      deferred = _q.defer()
      uri = "#{API}/#{api}"
      options =
        method: method
        uri: uri
        headers: "PRIVATE-TOKEN": token
      if method isnt 'GET' or method isnt 'DELETE'
        options.json = true
        options.body = params

      if method is 'GET'
        options.qs = params

      _request options, (error, response, body)->
        if error or not (response.statusCode in [200, 201])
          deferred.reject(new Error(error or response.statusCode))
        else
          deferred.resolve(body)

      deferred.promise

  ###
    @public
    @params {string} the id of project
    @return {object} the instance of Projects
  ###
  projects: (id)-> new Projects(@service(), id)


module.exports = GitLabInterface