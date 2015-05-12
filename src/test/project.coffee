
GitLabInterface = require '../lib/index'

url = 'http://git.hunantv.com'
token = 'gs1Bdujnh4yiGpyRk4yZ'

gitlab = new GitLabInterface(token, url)

gitlab.projects().all().then((data)->
  console.log data
).catch((e)->
  console.log e
)