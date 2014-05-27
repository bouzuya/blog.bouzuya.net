module.exports = {
  build: {
    files: [
      { src: 'src/index.html', dest: 'build/index.html' },
      { src: 'src/scripts/vendor/requirejs/require.js', dest: 'build/scripts/vendor/requirejs/require.js' },
      { src: 'src/styles/main.css', dest: 'build/styles/main.css' },
    ]
  }
};
