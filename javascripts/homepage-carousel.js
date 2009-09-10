"use strict";
/*jslint white: true, browser: true, undef: true, nomen: true, eqeqeq: true, plusplus: true, bitwise: true, regexp: true, strict: true, newcap: true, immed: true, indent: 2 */

(function () {
  var panel_numbers = {};
  var carousel;
  
  var scrollToCurrentPanel = function () {
    var hash = document.location.hash || '#welcome', panel_number = panel_numbers[hash];
    if (panel_number === undefined) {
      return;
    }
    $('.carousel-links li').removeClass('active');
    $('#scroll-'+hash.substring(1)).addClass('active');
    carousel.scroll(panel_number);
  };
  
  var initButtons = function (new_carousel) {
    carousel = new_carousel;
    $('.carousel-links li').each(function (index, element) {
      var node = $(this), id = '#' + node.attr('id').substring('scroll-'.length);
      panel_numbers[id] = index + 1;
      
      node.click(function () {
        document.location.hash = id;
        scrollToCurrentPanel();
      });
    });
  };
  
  $(document).ready(function () {
    $('#carousel').jcarousel({
      visible : 1,
      scroll : 1,
      buttonPrevHTML : null,
      buttonNextHTML : null,
      easing : 'easeOutExpo',
      initCallback : initButtons
    });
    
    // poll for back button
    var prev_label;
    setInterval(function () {
      if (document.location.hash === prev_label) {
        return;
      } else {
        prev_label = document.location.hash;
        scrollToCurrentPanel();
      }
    }, 100);
  });
  
}());
