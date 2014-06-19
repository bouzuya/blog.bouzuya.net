module.exports = {
  build: {
    files: [
      { src: 'src/index.html', dest: 'build/index.html' },
      { src: 'src/scripts/vendor/requirejs/require.js', dest: 'build/scripts/vendor/requirejs/require.js' },
      { expand: true, src: 'fonts/*', dest: 'build/', cwd: 'src/scripts/vendor/fontawesome' }
    ]
  }
};
