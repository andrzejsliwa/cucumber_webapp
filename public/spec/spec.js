beforeEach(function() {
  this.addMatchers({
    toBeFunction: function() {
      return typeof this.actual === 'function';
    }
  });
});
describe("true", function() {
  it("should be true", function() {
    expect(true)).toEqual(true);
  });
});

