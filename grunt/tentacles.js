module.exports = {
  upload: {
    options: {
      bucketName: 'blog.bouzuya.net',
      endpoint: 'https://s3-ap-northeast-1.amazonaws.com',
      s3BucketEndpoint: true
    },
    files: [
      { cwd: 'build', src: '**', filter: 'isFile' }
    ]
  }
};
