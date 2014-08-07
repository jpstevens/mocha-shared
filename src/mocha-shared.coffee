class Shared

  data =
    behavior: {}
    setup: {}

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
      checkForMany('behavior')(fn, values)
    @

  forMany: loopThroughAndCallFunction
  behavior: checkOrSet('behavior')
  hasBehavior: checkOrSet('behavior') # alias to #behavior
  behavesLike: checkOrSet('behavior') # alias to #behavior
  behaviour: checkOrSet('behavior') # British spelling
  hasBehaviour: checkOrSet('behavior') # British spelling
  setup: checkOrSet('setup')

module.exports = new Shared()
