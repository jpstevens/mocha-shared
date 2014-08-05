shared = require("../src/mocha-shared")

describe '#example', ->

  shared.example 'a shared (it block)', ->

    it 'inherits the parent shared', ->
      expect(@actual).to.equal @expected

  before ->
    @actual = 'apple'
    @expected = 'apple'

  shared.example 'a shared (it block)'

  describe 'nested shared example', ->

    before ->
      @actual = 'lovely'
      @expected = 'lovely'

    shared.example 'a shared (it block)'

  describe 'another example', ->

    before ->
      @actual = 'something'
      @expected = 'something'

    shared.example 'a shared (it block)'
