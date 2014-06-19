module.exports = {
  default: {
    options: {
      livereload: 35729,
    },
    files: ['src/**/*.*', 'test/**/*.*'],
    tasks: ['jshint', 'less', 'karma:unit']
  }
};
