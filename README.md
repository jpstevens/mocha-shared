# mocha-shared
[![Build Status](https://travis-ci.org/jpstevens/mocha-shared.svg?branch=master)](https://travis-ci.org/jpstevens/mocha-shared)

Shared behaviour for Mocha, to help DRY your test suite.

## Installation

In the root project of your directory, run the command:
```
npm install mocha-shared --save-dev
```

Then, in your javascript, add:

```
var shared = require('mocha-shared');
```

## Usage

### API

#### Setting the Example

```javascript
shared.example('name of example', function() {
  // test logic goes here
});
```

#### Using the Example
```javascript
shared.example('name of example');
```

### Example Usage

Below is an example of the shared context in a mocha test.

First, let's take a look at our example file:

```javascript
var User;

User = (function() {
  function User(config) {
    this.name = config.name;
    this.age = config.age;
  }

  User.prototype.hasFakeId = function() {
    return this.age < 21;
  };

  return User;

})();
```

Now, let's look at our spec file:

```javascript

describe('User', function() {

  // init our shared example
  shared.example('has a name and age', function() {

    beforeEach(function(){
      this.user = new User({ name: this.name, age: this.age });
    });

    it('has the expected name', function() {
      expect(this.user.name).to.equal(this.name);
    });

    it('has the expected age', function(){
      expect(this.user.age).to.equal(this.age);
    });
  });

  // name doesn't change, so set it here
  beforeEach(function(){
    this.name = 'Christopher Mintz-Plasse';
  });

  describe('when the user is under 21', function(){

    beforeEach(function(){
      this.age = 17;
      this.fakeId = true;
    });

    // shared example
    shared.example('has a name and age');

    it('has a fake ID', function(){
      expect(this.user.hasFakeID()).to.be.truthy;
    });
  });


  describe('when the user is over 21', function(){

    beforeEach(function(){
      this.age = 25;
      this.fakeId = true;
    });

    // shared example
    shared.example('has a name and age');

    it('does not have a fake ID', function(){
      expect(this.user.hasFakeID()).to.be.falsey;
    });
  });

});

```
