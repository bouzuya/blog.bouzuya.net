define(['chai', 'collections/posts'], function(chai, Posts) {
  var expect = chai.expect;

  describe('collections/posts', function() {
    beforeEach(function() { this.posts = new Posts(); });

    describe('fetch', function() {
      it('returns thenable object', function() {
        expect(this.posts.fetch()).to.have.property('then');
      });
    });
  });
});
