module.exports = {
  develop: {
    options: {
      port: 9000,
      base: ['src', 'build'],
      livereload: 35729,
      open: true
    }
  },
  build: {
    options: {
      port: 9000,
      base: ['build'],
      open: true
    }
  }
};
