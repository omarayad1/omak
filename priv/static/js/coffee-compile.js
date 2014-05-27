(function() {
  window.Omak = {
    Models: {},
    Collections: {},
    Controllers: {},
    Views: {},
    init: $(function() {
      var pattern, t;
      t = new Trianglify();
      pattern = t.generate($(window).width(), $(window).height());
      $('#container').hide();
      $('#container').css('background-image', pattern.dataUrl);
      return $('#container').fadeIn(2000);
    })
  };

  Omak.init();

}).call(this);

(function() {


}).call(this);
