 module.exports = function(grunt) {

   "use strict";

   require('load-grunt-tasks')(grunt);
   require('time-grunt')(grunt);

   grunt.initConfig({

     pkg: grunt.file.readJSON('package.json'),

     banner: '/*!\n' +
       ' * <%= pkg.name %> v<%= pkg.version %>\n' +
       ' * <%= pkg.url %>\n' +
       ' * Licensed under <%= pkg.licenses %>\n' +
       ' * <%= pkg.authorUrl %>\n' +
       ' */\n',
     // ====================================================
     clean: {
       files: [
         '<%= pkg.dist %>',
         '<%= pkg.source %>/js/<%= pkg.name %>.js',
         '<%= pkg.source %>/js/<%= pkg.name %>.min.js',
         '<%= pkg.public %>'
       ]
     },
     // ====================================================
     less: {
       source: {
         options: {
           strictMath: true,
           sourceMap: true,
           outputSourceFiles: true,
           sourceMapURL: ['<%= pkg.name %>.css.map'],
           sourceMapFilename: '<%= pkg.source %>/css/<%= pkg.name %>.css.map'
         },
         files: {
           '<%= pkg.source %>/css/<%= pkg.name %>.css': '<%= pkg.source %>/less/<%= pkg.name %>.less'
         }
       },
       minify: {
         options: {
           cleancss: true
         },
         files: {
           '<%= pkg.source %>/css/<%= pkg.name %>.min.css': '<%= pkg.source %>/css/<%= pkg.name %>.css'
         }
       }
     },
     // ====================================================
     autoprefixer: {
       options: {
         browsers: ['last 2 versions', 'ie 8', 'ie 9', 'android 2.3', 'android 4', 'opera 12']
       },
       source: {
         options: {
           map: true
         },
         src: '<%= pkg.source %>/css/<%= pkg.name %>.css'
       }
     },
     // ====================================================
     csscomb: {
       options: {
         config: '<%= pkg.source %>/less/.csscomb.json'
       },
       source: {
         expand: true,
         cwd: '<%= pkg.source %>/css/',
         src: ['*.css', '!*.min.css'],
         dest: '<%= pkg.source %>/css/'
       }
     },
     // ====================================================
     usebanner: {
       options: {
         position: 'top',
         banner: '<%= banner %>'
       },
       source: {
         src: '<%= pkg.source %>/css/*.css'
       }
     },
     // ====================================================
     csslint: {
       options: {
         csslintrc: '<%= pkg.source %>/less/.csslintrc'
       },
       source: [
         '<%= pkg.source %>/css/<%= pkg.name %>.css'
       ]
     },
     // ====================================================
     concat: {
       options: {
         banner: '<%= banner %>',
         stripBanners: false
       },
       source: {
         src: [
           '<%= pkg.source %>/js/plugin.js',
         ],
         dest: '<%= pkg.source %>/js/<%= pkg.name %>.js'
       }
     },
     // ====================================================
     uglify: {
      minify: {
        options: {
          banner: '<%= banner %>'
        },
        src: '<%= pkg.source %>/js/<%= pkg.name %>.js',
        dest: '<%= pkg.source %>/js/<%= pkg.name %>.min.js'
      }
     },
     // ====================================================
     jshint: {
       options: {
         jshintrc: '<%= pkg.source %>/js/.jshintrc',
       },
       grunt: {
         src: 'Gruntfile.js'
       },
       source: {
         src: [
           '<%= pkg.source %>/js/<%= pkg.name %>.js',
           '<%= pkg.source %>/js/<%= pkg.name %>.min.js'
         ]
       }
     },
     // ====================================================
     jscs: {
       options: {
         config: '<%= pkg.source %>/js/.jscsrc'
       },
       grunt: {
         options: {
           requireCamelCaseOrUpperCaseIdentifiers: null,
           requireParenthesesAroundIIFE: true
         },
         src: '<%= jshint.grunt.src %>'
       },
       source: {
         src: '<%= jshint.source.src %>'
       }
     },
     // ====================================================
     htmlmin: {
       publish: {
         options: {
           collapseBooleanAttributes: true,
           collapseWhitespace: true,
           removeAttributeQuotes: true,
           removeCommentsFromCDATA: true,
           removeEmptyAttributes: true,
           removeOptionalTags: true,
           removeRedundantAttributes: true,
           useShortDoctype: true
         },
         files: [{
           expand: true,
           cwd: '<%= pkg.public %>',
           src: '{,*/}*.html',
           dest: '<%= pkg.public %>'
         }]
       }
     },
     // ====================================================
     validation: {
       options: {
         charset: 'utf-8',
         doctype: 'HTML5',
         failHard: true,
         reset: true,
         relaxerror: [
           'Bad value X-UA-Compatible for attribute http-equiv on element meta.',
           'Element img is missing required attribute src.'
         ]
       },
       files: {
         src: [
           '<%= pkg.public %>/index.html',
           '<%= pkg.public %>/**/*.html'
         ]
       }
     },
     // ====================================================
     copy: {
       dist: {
         expand: true,
         cwd: './<%= pkg.source %>',
         src: [
           'js/<%= pkg.name %>.js',
           'js/<%= pkg.name %>.min.js',
           'css/*.css',
           'css/*.map'
         ],
         dest: './<%= pkg.dist %>'
       }
     },
     // ====================================================
     connect: {
       server: {
         options: {
           port: 9999,
           hostname: '0.0.0.0',
           base: '<%= pkg.public %>/',
           open: {
             server: {
               path: 'http://<%= connect.server.options.hostname %>:<%= connect.server.options.port %>'
             }
           }
         }
       }
     },
     // ====================================================
     notify: {
       options: {
         title: '<%= pkg.name %> Grunt Notify',
       },
       success: {
         options: {
           message: 'Success!',
         }
       }
     },
     // ====================================================
     bower: {
       install: {
         options: {
           targetDir: '<%= pkg.source %>/vendor',
           layout: 'byComponent',
           install: true,
           verbose: false,
           cleanTargetDir: true,
           cleanBowerDir: false
         }
       }
     },
     // ====================================================
     jekyll: {
       dist: {
         options: {
           config: '_config.yml'
         }
       }
     },
     // ====================================================
     watch: {
       options: {
         spawn: false,
         livereload: true
       },
       grunt: {
         files: ['<%= jshint.grunt.src %>'],
         tasks: [
           'jshint:grunt',
           'notify'
         ]
       },
       js: {
         files: [
           '<%= pkg.source %>/js/*.js'
         ],
         tasks: [
           'build-js',
           'jshint:source',
           //'jscs:source',
           'jekyll',
           'notify'
         ]
       },
       html: {
         files: [
           '<%= pkg.source %>/*.html',
           '<%= pkg.source %>/_includes/*',
           '<%= pkg.source %>/_posts/*',
           '<%= pkg.source %>/_layouts/*'
         ],
         tasks: [
           'build-html',
           'notify'
         ]
       },
       less: {
         files: [
           '<%= pkg.source %>/less/*.less',
           '<%= pkg.source %>/less/**/*.less'
         ],
         tasks: [
           'build-less',
           'jekyll',
           'notify'
         ]
       }
     },
     // ====================================================
     buildcontrol: {
       options: {
         dir: '<%= pkg.public %>',
         commit: true,
         push: true,
         message: 'Built %sourceName% from commit %sourceCommit% on branch %sourceBranch%'
       },
       pages: {
         options: {
           remote: 'git@github.com:<%= pkg.repository.user %>/<%= pkg.name %>.git',
           branch: 'gh-pages'
         }
       }
     }

   });

   // ====================================================
   grunt.registerTask('deploy', [
     'buildcontrol',
     'notify'
   ]);

   // ====================================================
   grunt.registerTask('build-less', [
     'less:source',
     'autoprefixer:source',
     'usebanner',
     'csscomb:source',
     'less:minify',
   ]);

   // ====================================================
   grunt.registerTask('build-js', [
     'concat',
     'uglify'
   ]);

   // ====================================================
   grunt.registerTask('build-html', [
     'jekyll',
     //'htmlmin'
   ]);

   // ====================================================
   grunt.registerTask('test', [
     'jshint:source',
     //'jscs:source',
     'csslint',
     'validation'
   ]);

   // ====================================================
   grunt.registerTask('b', [
     'clean',
     'bower',
     'build-less',
     'build-js',
     'build-html',
     'test',
     'copy'
   ]);

   // ====================================================
   grunt.registerTask('default', function() {
     grunt.log.warn('`grunt` to start a watch.');
     grunt.task.run([
       'connect',
       'watch'
     ]);
   });

 };