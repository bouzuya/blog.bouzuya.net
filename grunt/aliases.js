module.exports = {
  build: [
    'shell:kraken',
    'requirejs:compile',
    'copy:build'
  ],
  develop: [
    'connect:develop',
    'watch:develop'
  ],
  'server:build': [
    'connect:build',
    'watch:develop'
  ],
  default: [
    'jshint',
    'build'
  ]
};
