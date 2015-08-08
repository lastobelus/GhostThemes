module.exports = (grunt) ->
  pkg = grunt.file.readJSON('package.json')

  config =
    connect:
      http:
        options:
          hostname: "*"
          port: process.env.PORT || 80
          livereload: true

    watch:
      options:
        livereload: true
      css:
        files: ['assets/css/**/*.css']
      templates:
        files: ['*.hbs', 'partials/*.hbs']
      grunt:
        files: ['Gruntfile.coffee']

    compress:
      main:
        options:
          archive: 'dist/theme.zip'
          pretty: true
        files: [
          {src: ['**/*', '!node_modules/**/*', '!assets/bootstrap/**/*', '!dist/**/*']}
        ]

    recess:
      options:
        strictPropertyOrder: false
      dist:
        src: ['assets/screen.css']

    'ghost-upload':
      main:
        zip: 'dist/theme.zip'
        blog: 'hopkode'

  tasks =
    # Building block tasks
    build: []
    deploy: ['build', 'compress', 'ghost-upload']
    # Development tasks
    default: ['build', 'connect', 'watch']

  # Project configuration.
  grunt.initConfig config
  grunt.loadNpmTasks name for name of pkg.devDependencies when name[0..5] is 'grunt-'
  grunt.registerTask taskName, taskArray for taskName, taskArray of tasks
