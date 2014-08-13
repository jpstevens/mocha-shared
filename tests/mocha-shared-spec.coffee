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

  describe '#scenario', ->

    shared.scenario 'feelings test', (person) ->

      describe "#{person.name}", ->

        it 'is not feeling sad', ->
          expect(person.feelings).to.not.contain 'sad'

        it 'is feeling happy', ->
          expect(person.feelings).to.contain 'happy'

    shared.scenario 'feelings test', { name: "Steve", feelings: ['happy', 'joyous'] }

  describe '#forMany', ->

    shared.forMany [
      { name: "Steve", feelings: ['happy', 'joyous'] }
      { name: "Peter", feelings: ['happy'] }
    ], 'feelings test'

  describe '#for', ->

    shared.for [
      { name: "Steve", feelings: ['happy', 'joyous'] }
      { name: "Peter", feelings: ['happy'] }
    ], 'feelings test'


