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

- behavior
- setup
- scenario
- forMany

### behavior

Used to describe behaviour that is shared between multiple test cases. Behaviors **should** be used to wrap "it" blocks, and describe what something **does**. 

*e.g. "has status", "returns JSON"*

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
  shared.behavior('contains the letter', 'h');

});
```

### setup

Used to describe setup steps that are shared between multiple scenarios. These **should not** include expectations, but **should** include: `before`, `beforeEach`, `after`, `afterEach`, for setting up spies, mocks and stubs (for example).

*e.g. "set title", "init HTTP request"*

#### Configuring a setup:

**API:**

```
#setup(description, fn)
```
- description (required; string)
- function (required)

**Example #1:**

```javascript
shared.setup('init string test', function() {

  // init our setup
  before(function(){
    this.isWord = function(word) {
      return (typeof word == 'string');
    };
  });

});
```

**Example #2:**

```javascript
shared.setup('set word', function(word) {

  // init our setup
  before(function(){
    this.word = word;
  });

});
```

#### Using a setup:

**API:**

```
#setup(description[, options])
```
- description (required; string)
- options (optional, injected into your shared behavior method as the first argument)

**Example:**

```javascript
describe('hello', function(){

  // include setup
  // must match our description text above EXACTLY
  shared.setup('init string test');
  shared.setup('set word', word);

  // test our expectations
  it('is a word', function(){
    expect(this.isWord(this.word)).to.be.truthy;
  });

});
```

### scenario

Used to describe a scenario that is shared between multiple test cases. Scenarios **should** be used to wrap describe blocks, and encapsulate shared behaviors and setups.

*e.g. "making a request with missing fields", "deleting a resource"*

#### Setting a scenario:

**API:**

```
#scenario(description, fn)
```
- description (required; string)
- function (required; function signature may take ZERO or ONE arguments)

**Example:**

```javascript
shared.scenario('word contains "h" and "e"', function(word) {

  describe('when the word is ' + word, function() {
    shared.setup('set word', word);
    shared.behavior('is a string');
    shared.behavior('contains the letter', 'h');
    shared.behavior('contains the letter', 'e');
  });

});
```

#### Using a scenario:

**API:**

```
#scenario(description[, options])
```

- description (required; string)
- options (optional, injected into your shared behavior method as the first argument)

**Example:**

```javascript
describe('test suite', function() {

  shared.scenario('word contains "h" and "e"', 'horse');
  shared.scenario('word contains "h" and "e"', 'hello');

});
```

### forMany

Used to apply a behavior/scenario to an array of inputs.

**ALIAS:** ```#for```

#### Usage

**API:**

```
#forMany(values, [fn|description])
```
- values (required; array)
- fn (function; provides an iterator within the passed-in function)
- description (string; the description of the **scenario** you want applied to many)

**NOTE: ** This can be used to loop through setup, behaviors and scenarios *within* the anonymous function. The optional scenario string in the "shorthand" version is just sugar to help reduce repetition.

**Example #1:**

```javascript
describe('test suite', function(){

  shared.forMany(['horse','hello'], function(word){
    shared.scenario('word contains "h" and "e"', word);
  });

});
```


**Example #2 ("sugar" shorthand, for scenarios only):**

```javascript
describe('test suite', function(){

  shared.forMany(['horse','hello'], 'word contains "h" and "e"');
  // OR shared.for(['horse','hello'], 'word contains "h" and "e"');

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

**0.2.0**
- Add `scenario` for wrapping describe blocks in tests
- Add alias for `forMany` (`for`)
- `forMany` "sugar" string syntax now points to `scenario`, not `behavior`
- Adds deprecation notice for users attempting to call a `behavior` from `forMany`
