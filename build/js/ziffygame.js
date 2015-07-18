(function() {
  var myTestThing;

  myTestThing = function(stuff) {
    return "Hello " + stuff;
  };

  myTestThing('World');

}).call(this);

(function() {
  var options;

  options = {
    "this": 'is',
    pretty: 'cool'
  };

}).call(this);
