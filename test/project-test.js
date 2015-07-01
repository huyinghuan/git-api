(function() {
  var GitLabInterface, assert, getProjectsList, getProjectsSingle, gitlab, moment, testProjectBranches, testProjectCommits, testProjectOwned, token, url;

  moment = require('moment');

  GitLabInterface = require('../lib/index');

  assert = require('assert');

  url = 'http://git.hunantv.com/api/v3';

  token = 'AsXdp8cq5MSn8p9U53iZ';

  gitlab = new GitLabInterface(token, url);

  testProjectOwned = function() {
    return gitlab.projects().owned().get().then(function(data) {
      var i, item, len, results;
      results = [];
      for (i = 0, len = data.length; i < len; i++) {
        item = data[i];
        results.push(console.log(item.id, item.name, item.web_url));
      }
      return results;
    })["catch"](function(e) {
      return console.log(e);
    });
  };

  testProjectBranches = function() {
    return gitlab.projects(1050).branches().getAllNames().then(function(data) {
      return console.log(data);
    });
  };

  testProjectCommits = function() {
    return gitlab.projects(1050).commits().get('develop', {
      timeBucket: moment().subtract(2, 'M')
    }).then(function(data) {
      var i, item, len, results;
      console.log(data.length);
      results = [];
      for (i = 0, len = data.length; i < len; i++) {
        item = data[i];
        results.push(console.log(item.message));
      }
      return results;
    });
  };

  getProjectsList = function() {
    return gitlab.projects().get().then(function(data) {
      return console.log(data);
    });
  };

  getProjectsSingle = function() {
    return gitlab.projects(1050).get().then(function(data) {
      return console.log(data);
    });
  };

  describe("Project", function() {
    it("get project list", function(done) {
      return gitlab.projects().get().then(function(data) {
        data.map(function(item) {
          return console.log(item.id, "" + (item.name_with_namespace.replace(/\s/g, "")));
        });
        return done();
      });
    });
    return it.only("fork and set web hooks", function(done) {
      return gitlab.projects().fork(677).then(function(data) {
        return gitlab.projects(data.id).hooks().post("http://bho.hunantv.com");
      }).then(function(data) {
        console.log(data);
        return done();
      })["catch"](function(e) {
        return console.log(e);
      });
    });
  });

}).call(this);
