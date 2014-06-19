module.exports = {
  options: {
    files: [
      'test/main.js',
      { pattern: 'src/**/*.js',  included: false },
      { pattern: 'test/**/*.js', included: false }
    ],
    basePath: '',
    frameworks: ['mocha', 'requirejs'],
    exclude: [],
    reporters: ['progress'],
    port: 9876,
    colors: true,
    logLevel: 'INFO',
    browsers: ['PhantomJS'],
    singleRun: true,
    autoWatch: true,
  },
  unit: {}
};
