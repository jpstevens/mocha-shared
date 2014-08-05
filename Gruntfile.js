(function(){

  module.exports = function(grunt) {

    grunt.initConfig({
      watch: {
        files: ['src/**/*.*', '*.*', 'tests/**/*.*'],
        tasks: ['test']
      },
      coffee: {
        glob_to_multiple: {
          expand: true,
          flatten: false,
          cwd: 'src/',
          src: ['**/*.coffee'],
          dest: 'dist/',
          ext: '.js'
        }
      },
      coffeelint: {
        files: ['src/**/*.coffee']
      },
      mochaTest: {
        test: {
          options: {
            reporter: 'spec',
            require: [
              'coffee-script/register',
              function(){ expect = require('chai').expect; }
            ]
          },
          src: ['tests/**/*.coffee']
        }
      }
    });

    require('load-grunt-tasks')(grunt);

    grunt.registerTask('build', ['coffee']);
    grunt.registerTask('test', ['mochaTest']);
    grunt.registerTask('default', ['test', 'build']);

  };
})();
