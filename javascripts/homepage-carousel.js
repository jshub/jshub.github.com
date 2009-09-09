(function () {
  var initButtons = function(carousel) {
    $.each(['jshub', 'owners', 'implementors', 'developers', 'vendors'], function(idx, name) {
      $('#scroll-'+name).click(function () {
        $('.carousel-links li').removeClass('active');
        $(this).addClass('active');
        carousel.scroll(idx+1);
      })
    });
  };
  
  $(document).ready(function() {
    $('#carousel').jcarousel({
      visible : 1,
      scroll : 1,
      buttonPrevHTML : null,
      buttonNextHTML : null,
      easing : 'easeOutExpo',
      initCallback : initButtons
    });
  });
  
})();
