module.exports = {
  upload: {
    options: {
      bucketName: 'blog.bouzuya.net'
    },
    files: [
      { cwd: 'build', src: '**', filter: 'isFile' }
    ]
  }
};
