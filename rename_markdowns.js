var fse = require('fs-extra');
var moment = require('moment');

var files = fse.readdirSync('./src/_posts/');

files.forEach(function(file) {
  var match = file.match(/^(\d+)-(\d+)-(\d+)-(.+)?\.markdown$/);
  var year = match[1];
  var month = match[2];
  var date = match[3];
  var title = match[4];

  var name = './data/' + year + '/' + month + '/' + year + '-' + month + '-' + date + '-' + title + '.md'
  fse.copySync('./src/_posts/' + file, name);
});

