shared = require('../src/mocha-shared')

describe '#hasBehavior', ->

  describe 'with no params', ->

    shared.behavior 'contains the letter "a"', ->

      before ->
        @letter = 'a'

      it "contains the letter 'a'", ->
        expect(@word).to.contain @letter

    describe 'for car', ->

      before ->
        @word = 'car'

      shared.hasBehavior 'contains the letter "a"'

    describe 'for banana', ->

      before ->
        @word = 'banana'

      shared.hasBehavior 'contains the letter "a"'

  describe 'when param is a string', ->

    shared.behavior 'contains the letter', (letter) ->

      it "contains the letter '#{letter}'", ->
        expect(@word).to.contain letter

    describe 'for banana', ->

      before ->
        @word = 'banana'

      shared.hasBehavior 'contains the letter', 'b'

    describe 'for car', ->

      before ->
        @word = 'car'

      shared.hasBehavior 'contains the letter', 'c'

  describe 'when param is an object', ->

    shared.behavior 'does not contain the letter', (opts) ->

      it "does not contain the letter '#{opts.letter}'", ->
        expect(@word).to.not.contain opts.letter

    describe 'for banana', ->

      before ->
        @word = 'banana'

      shared.hasBehavior 'does not contain the letter', { letter: 'd' }

    describe 'for car', ->

      before ->
        @word = 'car'

      shared.hasBehavior 'does not contain the letter', { letter: 'e' }

describe '#setup', ->

  shared.setup 'checking letters in donkey', ->

    beforeEach ->

      @word = 'donkey'
      @includesLetter = (letter) ->
        if @word.match(letter) then true else false

  describe 'the word donkey', ->

    shared.setup 'checking letters in donkey'

    it 'includes the letter "e"', ->
      expect(@includesLetter("e")).to.be.true

    it 'does not include the letter "f"', ->
      expect(@includesLetter("f")).to.be.false

describe '#forMany', ->

  shared.behavior 'is a number', (number) ->

    it "#{number} is a number", ->
      expect(typeof number).to.equal 'number'

  shared.forMany [1,2,3], (number) ->

    shared.hasBehavior 'is a number', number

  shared.forMany [5,6,7], 'is a number'

