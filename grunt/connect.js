module.exports = {
  default: {
    options: {
      port: 9000,
      base: ['src', 'build'],
      livereload: 35729,
      open: true,
      middleware: function(connect, options, middlewares) {
        return [
          function(req, res, next) {
            var parse = require('url').parse;
            var extname = require('path').extname;
            var url = parse(req.url);
            var file = url.pathname.split('/').splice(-1)[0];
            if (!extname(file) && req.url.indexOf('/') === 0) {
              req.url = req.url.replace('/', '#');
            }
            next();
          }
        ].concat(middlewares);
      }
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
