Task = require 'task'

describe "Task", ->
  describe "populating the window with fake properties", ->
    describe "when jQuery is loaded in a child process", ->
      it "doesn't log to the console", ->
        spyOn(console, 'log')
        spyOn(console, 'error')
        spyOn(console, 'warn')

        jqueryTask = new Task('fixtures/jquery-task-handler.coffee')
        jqueryLoaded = false
        jqueryTask.start (loaded) -> jqueryLoaded = loaded

        waitsFor "child process to start and jquery to be required", 5000, ->
          jqueryLoaded

        runs ->
          expect(jqueryLoaded).toBeTruthy()
          expect(console.log).not.toHaveBeenCalled()
          expect(console.error).not.toHaveBeenCalled()
          expect(console.warn).not.toHaveBeenCalled()