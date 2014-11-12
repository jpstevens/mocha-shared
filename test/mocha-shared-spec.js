var shared = require('../lib/mocha-shared');

describe('#hasBehavior', function () {

  describe('with no params', function () {

    shared.behavior('contains the letter "a"', function () {
      before(function () {
        this.letter = 'a';
      });

      it("contains the letter 'a'", function () {
        expect(this.word).to.contain(this.letter);
      });
    });

    describe('for car', function () {
      before(function () {
        this.word = 'car';
      });

      shared.hasBehavior('contains the letter "a"');
    });

    describe('for banana', function () {
      before(function () {
        this.word = 'banana';
      });

      shared.hasBehavior('contains the letter "a"');
    });
  });

  describe('when param is a string', function () {

    shared.behavior('contains the letter', function (letter) {

      it("contains the letter '" + letter + "'", function () {
        expect(this.word).to.contain(letter);
      });
    });

    describe('for banana', function () {
      before(function () {
        this.word = 'banana';
      });

      shared.hasBehavior('contains the letter', 'b');
    });

    describe('for car', function () {
      before(function () {
        this.word = 'car';
      });

      shared.hasBehavior('contains the letter', 'c');
    });

  });

  describe('when param is an object', function () {

    shared.behavior('does not contain the letter', function (opts) {

      it("does not contain the letter '" + opts.letter + "'", function () {
        expect(this.word).to.not.contain(opts.letter);
      });
    });

    describe('for banana', function () {
      before(function () {
        this.word = 'banana';
      });

      shared.hasBehavior('does not contain the letter', {
        letter: 'd'
      });
    });

    describe('for car', function () {
      before(function () {
        this.word = 'car';
      });

      shared.hasBehavior('does not contain the letter', {
        letter: 'e'
      });
    });

  });

  describe('#setup', function () {

    shared.setup('checking letters in donkey', function () {
      beforeEach(function () {
        this.word = 'donkey';
        this.includesLetter = function (letter) {
          return !!this.word.match(letter);
        };
      });
    });

    describe('the word donkey', function () {
      shared.setup('checking letters in donkey');

      it('includes the letter "e"', function () {
        return expect(this.includesLetter("e")).to.be.true;
      });

      it('does not include the letter "f"', function () {
        return expect(this.includesLetter("f")).to.be.false;
      });
    });
  });

  describe('#scenario', function () {

    shared.scenario('feelings test', function (person) {

      describe("" + person.name, function () {

        it('is not feeling sad', function () {
          expect(person.feelings).to.not.contain('sad');
        });

        it('is feeling happy', function () {
          expect(person.feelings).to.contain('happy');
        });
      });
    });

    shared.scenario('feelings test', {
      name: "Steve",
      feelings: ['happy', 'joyous']
    });

  });

  describe('#forMany', function () {

    shared.forMany([
      { name: "Steve", feelings: ['happy', 'joyous'] },
      { name: "Peter", feelings: ['happy'] }
    ], 'feelings test');

    describe('when a behavior is called on a forMany block', function () {

      it('throws an error', function () {
        expect(function () {
          shared.forMany(['a'], 'contains the letter');
        }).to.throw(Error, /requires a scenario. Got behavior/);
      });
    });

    describe('when a setup is called on a forMany block', function () {

      it('throws an error', function () {
        expect(function () {
          shared.forMany(['a'], 'checking letters in donkey');
        }).to.throw(Error, /requires a scenario. Got setup/);
      });
    });
  });

  describe('#for', function () {
    shared.for([
      { name: "Steve", feelings: ['happy', 'joyous']},
      { name: "Peter", feelings: ['happy'] }
    ], 'feelings test');
  });
});
