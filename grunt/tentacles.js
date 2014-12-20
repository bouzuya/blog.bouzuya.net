module.exports = {
  upload: {
    options: {
      bucketName: 'blog.bouzuya.net',
      sslEnabled: false
    },
    files: [
      { cwd: 'build', src: '**', filter: 'isFile' }
    ]
  }
};
