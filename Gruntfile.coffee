module.exports = (grunt) ->

  paths = {
    build_dir: 'build'
    src_dir: 'src'

    # Sources
    coffee_src: 'src/coffee/**/*.coffee'
    coffee_build: 'build/js/<%= pkg.name %>.js'

    # Paths for copying...
    image_src: 'img/**/*.png'
    image_build: 'build/img/'
    index_src: 'index.html'
    #js_specs: 'test/**/*.spec.js'

    # Compiled Output
    #js_dir: 'build/js'

    # Minified target name
    minified: 'build/js/<%= pkg.name %>.min.js'

    # Libraries to load for frontend
    frontend_libs: [
      # Craftyjs
    ]
  }

  paths.coffee_files = {}
  # Destination => source
  paths.coffee_files[paths.coffee_build] = [paths.coffee_src]

  paths.build_includes = [
    {expand: true, src: [paths.image_src, paths.index_src], dest: paths.build_dir, cwd: paths.src_dir}
  ]

  # Project configuration.
  grunt.initConfig(
    pkg: grunt.file.readJSON('package.json'),
    # Task to contact and compile JS into coffeescript
    coffee: {
      default: {
        #src: paths.coffee_src
        #dest: paths.js_dir
        files: paths.coffee_files
      }
    },
    # Task to uglify the JS
    uglify: {
      options: {
        banner: '/*! <%= pkg.name %> <%= grunt.template.today("yyyy-mm-dd") %> */\n'
      },
      build: {
        src: paths.coffee_build
        dest: paths.minified
      }
    }

    # Task to copy files into build
    copy:
      build:
        files: paths.build_includes

    # TODO: throw a test runner in here at some point.

  )

  grunt.loadNpmTasks('grunt-contrib-coffee')
  # Load the plugin that provides the "uglify" task.
  grunt.loadNpmTasks('grunt-contrib-uglify')
  grunt.loadNpmTasks('grunt-contrib-copy')

  # Default task(s).
  grunt.registerTask('default', ['coffee', 'uglify', 'copy:build'])
