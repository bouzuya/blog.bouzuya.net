module.exports = {
  build: {
    files: [
      { expand: true, cwd: 'src/styles/', dest: 'build/styles/', src: ['*.less'], ext: '.css' }
    ]
  }
};
