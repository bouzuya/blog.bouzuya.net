module.exports = {
  build: [
    'shell:kraken',
    'requirejs:compile',
    'less',
    'copy:build'
  ],
  server: [
    'connect:default',
    'watch:default'
  ],
  'server:build': [
    'connect:build',
    'watch:default'
  ],
  default: [
    'jshint',
    'build'
  ]
};
