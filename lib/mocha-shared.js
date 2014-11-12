(function () {

  var data = {
    behavior: {},
    setup: {},
    scenario: {}
  };

  function set (resource) {
    return function (description, fn) {
      data[resource][description] = fn;
    };
  }

  function checkForMany (resource) {
    return function (description, array) {
      (array || []).forEach(function (value) {
        check(resource)(description, value);
      });
    };
  }

  function check (resource) {
    return function (description, args) {
      data[resource][description](args);
    };
  }

  function checkOrSet (resource) {
    return function (description, fn) {
      if (typeof fn === 'function') {
        set(resource)(description, fn);
      } else {
        value = fn;
        check(resource)(description, value);
      }
    };
  }

  function loopThroughAndCallFunction (values, fn) {
    if (typeof fn === 'function') {
      values.forEach(function (values) {
        fn(value);
      });
    } else if (typeof fn === 'string') {
      try {
        checkForMany('scenario')(fn, values);
      } catch (err) {
        if (data.behavior[fn] !== undefined) {
          throw new Error("The sugar-syntax for 'forMany' requires a scenario. Got behavior: '#{fn}'");
        } else if (data.setup[fn] !== undefined) {
          throw new Error("The sugar-syntax for 'forMany' requires a scenario. Got setup: '#{fn}'");
        } else {
          throw err;
        }
      }
    }
  }

  module.exports = {
    forMany: loopThroughAndCallFunction,
    for: loopThroughAndCallFunction,
    behavior: checkOrSet('behavior'),
    hasBehavior: checkOrSet('behavior'), // alias to #behavior
    behavesLike: checkOrSet('behavior'), // alias to #behavior
    behaviour: checkOrSet('behavior'), // British spelling
    hasBehaviour: checkOrSet('behavior'), // British spelling
    setup: checkOrSet('setup'),
    scenario: checkOrSet('scenario')
  };

})();
