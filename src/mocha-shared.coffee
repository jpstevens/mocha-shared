class Shared

  data =
    behavior: {}
    setup: {}
    scenario: {}

  set = (resource) ->
    (description, fn) ->
      data[resource][description] = fn

  checkForMany = (resource) ->
    (description, array = []) ->
      for value in array
        check(resource)(description, value)

  check = (resource) ->
    (description, value) ->
      data[resource][description](value)

  checkOrSet = (resource) ->
    (description, fn) ->
      if typeof fn is 'function'
        set(resource)(description, fn)
      else
        value = fn
        check(resource)(description, value)
      @

  loopThroughAndCallFunction = (values, fn) ->
    if typeof fn is 'function'
      fn(value) for value in values
    if typeof fn is 'string'
      try
        checkForMany('scenario')(fn, values)
      catch err
        if data.behavior[fn] isnt undefined
          throw new Error("The sugar-syntax for 'forMany' requires a scenario. Got behavior: '#{fn}'")
        else if data.setup[fn] isnt undefined
          throw new Error("The sugar-syntax for 'forMany' requires a scenario. Got setup: '#{fn}'")
        else
          throw err
    @

  forMany: loopThroughAndCallFunction
  for: loopThroughAndCallFunction
  behavior: checkOrSet('behavior')
  hasBehavior: checkOrSet('behavior') # alias to #behavior
  behavesLike: checkOrSet('behavior') # alias to #behavior
  behaviour: checkOrSet('behavior') # British spelling
  hasBehaviour: checkOrSet('behavior') # British spelling
  setup: checkOrSet('setup')
  scenario: checkOrSet('scenario')

module.exports = new Shared()
