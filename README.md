# mocha-shared
[![Build Status](https://travis-ci.org/jpstevens/mocha-shared.svg?branch=master)](https://travis-ci.org/jpstevens/mocha-shared)

Shared behaviour for Mocha, to help DRY your test suite.

## Installation

In the root directory of your project, run the command:
```
npm install mocha-shared --save-dev
```

Then, in your javascript, add:

```
var shared = require('mocha-shared');
```

## Methods

| Method        | Set API                               | Use API                                     |
|---------------|---------------------------------------|---------------------------------------------|
| behavior      | `shared.behavior(description, fn)`    | `shared.behavior(description[, opts])`      |
| hasBehavior   | `shared.hasBehavior(description, fn)` | `shared.hasBehavior(description[, opts])`   |
| behavesLike   | `shared.behavesLike(description, fn)` | `shared.behavesLike(description[, opts])`   |
| setup         | `shared.setup(description, fn)`       | `shared.setup(description)`                 |
| forMany       | N/A                                   | `shared.forMany(values, [fn][description])` |

### behavior

Used to describe behaviour that is shared between multiple scenarios.

**ALIAS:** ```#hasBehavior```, ```#behavesLike```

**NOTE:** For our British users, you an also use the "correct" spellings of ```#behaviour``` and ```#hasBehaviour```

#### Setting a behavior:

**API:**

```
#behavior(description, fn)
```
- description (required; string)
- function (required; function signature may take ZERO or ONE arguments)

**Example #1:**

```javascript
shared.behavior('is a string', function() {

  // shared behavior
  it('is a string', function() {
    expect(typeof this.word).to.equal('string');
  });

});
```

**Example #2:**

```javascript
shared.behavior('contains letter', function(letter) {

  // shared behavior, based on function param
  it('contains the letter ' + letter, function() {
    expect(typeof this.word).to.contain(letter);
  });

});
```

#### Using a behavior:

**API:**

```
#behavior(description[, options])
```

- description (required; string)
- options (optional, injected into your shared behavior method as the first argument)

**Example:**

```javascript
describe('hello', function(){

  before(function(){
    this.word = 'hello';
  });

  shared.behavior('is a string'); // must match our description text above EXACTLY
  // or scenario.hasBehavior('is a string');
  // or scenario.behavesLike('is a string');
  // as long as the string matches the description used when setting the behavior
  shared.behavior('contains the letter', 'h');

});
```

### setup

Used to describe setup steps that are shared between multiple scenarios. These **should not** include expectations, but **should** include: `before`, `beforeEach`, `after`, `afterEach`, for setting up spies, mocks and stubs (for example).

#### Configuring a setup:

**API:**

```
#setup(description, fn)
```
- description (required; string)
- function (required)

**Example:**

```javascript
shared.setup('string test', function() {

  // init our setup
  before(function(){
    this.isWord = function(word) {
      return (typeof word == 'string');
    };
  });

});
```

#### Using a setup:

**API:**

```
#setup(description)
```

- description (required; string)

**Example:**

```javascript
describe('hello', function(){

  // include setup
  shared.setup('string test'); // must match our description text above EXACTLY

  // other setup (not shared)
  before(function(){
    this.word = 'hello';
  });

  // test our expectations
  it('is a word', function(){
    expect(this.isWord(this.word)).to.be.truthy;
  });

});
```

### forMany

Used to apply behaviors to an array of inputs.

#### Usage

**API:**

```
#forMany(values, [fn|description])
```
- values (required; array)
- fn (function; provides an iterator within the passed-in function)
- description (string; the description of the behavior you want applied to many)

**Example #1:**

```javascript
describe('hello', function(){

  before(function(){
    this.word = 'hello';
  });

  shared.forMany(['h','e','l','o'], function(letter){
    shared.behavior('contains letter', letter);
  });

});
```


**Example #2 (shorthand):**

```javascript
describe('hello', function(){

  before(function(){
    this.word = 'hello';
  });

  shared.forMany(['h','e','l','o'], 'contains letter'); // call the describe directly

});
```

## Changelog

**0.1.0**
- Rename `example` to `behavior`
- Deprecate `example`
- Add aliases for `behavior` (`hasBehavior`, `behavesLike`)
- Add British aliases for `behavior` (`behaviour`, `hasBehaviour`), with the extra "u"
- Add `setup` for setting up tests
- Add `forMany` for iterative tests
