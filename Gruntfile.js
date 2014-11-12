(function(){

  module.exports = function(grunt) {

    grunt.initConfig({
      watch: {
        files: ['lib/**/*.*', '*.*', 'test/**/*.*'],
        tasks: ['test']
      },
      jshint: {
        files: ['lib/**/*.*', 'test/**/*.*'],
      },
      mochaTest: {
        test: {
          options: {
            reporter: 'spec',
            require: [
              function(){ expect = require('chai').expect; }
            ]
          },
          src: ['test/**/*-spec.js']
        }
      }
    });

    require('load-grunt-tasks')(grunt);

    grunt.registerTask('test', ['jshint', 'mochaTest']);
    grunt.registerTask('default', ['test']);

  };
})();
