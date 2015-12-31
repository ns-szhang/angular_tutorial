'use strict'

module.exports = (grunt) ->

  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    coffee:
      compile:
        options:
          join: true
        files:
          'static/js/app.js': [
            "apps/**/app.coffee"
            "apps/**/services/*.coffee"
            "apps/**/controllers/*.coffee"
            "apps/**/directives/*.coffee"
            "apps/**/filters/*.coffee"
            "apps/**/*.coffee"
          ]
          'lib/app.js': [
            'src/app.coffee'
          ]

    less:
      compile:
        files:
          'styles/stylesheet.css': 'styles/stylesheet.less'

    watch:
      coffee:
        files: ['apps/**/*.coffee', 'src/*.coffee']
        tasks: ['coffee']
      less:
        files: 'styles/**/*.less'
        tasks: ['less']
      views:
        files: ['apps/**/*.html']
        tasks: ['copy:views']

    copy:
      views:
        files: [
          expand: true
          flatten: true
          src: ['apps/**/*.html']
          dest: 'static/views/'
        ]
      fonts:
        files: [
          expand: true
          flatten: true
          filter: 'isFile'
          src: [
            'bower_components/font-awesome/fonts/**'
            'bower_components/bootstrap/fonts/**'
          ]
          dest: 'static/fonts/'
        ]

    concat:
      min_vendor:
        files:
          'static/js/vendor.min.js': [
            'bower_components/jquery/dist/jquery.js'
            'bower_components/angular/angular.js'
          ]
          'static/styles/stylesheet.css': [
            'bower_components/bootstrap/dist/css/bootstrap.css'
            'styles/stylesheet.css'
          ]

  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-less'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-concat'

  grunt.registerTask 'build', ['coffee', 'less', 'copy', 'concat']
  grunt.registerTask 'default', ['build', 'watch']
