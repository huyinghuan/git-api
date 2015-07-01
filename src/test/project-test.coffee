moment = require 'moment'
GitLabInterface = require '../lib/index'
assert = require 'assert'

url = 'http://git.hunantv.com/api/v3'
token = 'AsXdp8cq5MSn8p9U53iZ'
gitlab = new GitLabInterface(token, url)

testProjectOwned = ->
  gitlab.projects().owned().get().then((data)->
    #console.log data[4].id, data[4].name
    console.log item.id, item.name, item.web_url for item in data
  ).catch((e)->
    console.log e
  )

#testProjectOwned()

testProjectBranches = ->
  gitlab.projects(1050).branches().getAllNames().then((data)->
    console.log data
  )

#testProjectBranches()

testProjectCommits = ->
  gitlab.projects(1050)
    .commits()
    .get('develop', {timeBucket: moment().subtract(2, 'M')}) #, {timeBucket: moment().subtract(3, 'M')}
    .then((data)->
      console.log data.length
      console.log item.message for item in data
    )

#testProjectCommits()

getProjectsList = ->
  gitlab.projects().get().then((data)-> console.log data)

#getProjectsList()

getProjectsSingle = ->
  gitlab.projects(1050).get().then((data)-> console.log data)

#getProjectsSingle()

describe("Project", ()->
  it("get project list", (done)->
    gitlab.projects().get().then((data)->

      data.map((item)->
        console.log item.id, "#{item.name_with_namespace.replace(/\s/g, "")}"
      )
      done()
    )
  )
  it.only("fork and set web hooks", (done)->
    gitlab.projects().fork(677)
    .then((data)->
      gitlab.projects(data.id).hooks().post("http://bho.hunantv.com")
    ).then((data)->
      console.log data
      done()
    )
    .catch((e)->
      console.log e
    )
  )
)