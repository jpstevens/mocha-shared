examples = {}

module.exports.example = (example, fn) ->
  if typeof fn is 'function'
    examples[example] = fn
  else
    examples[example]()
