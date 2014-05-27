module.exports = {
  develop: {
    options: {
      port: 9000,
      base: ['build', 'src'],
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
