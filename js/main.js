var bottomWaypoint, msViewportStyle, preCacheImages, setHeights, wh, ww;

ww = $(window).width();

wh = $(window).height();

if (navigator.userAgent.match(/IEMobile\/10\.0/)) {
  msViewportStyle = document.createElement("style");
  msViewportStyle.appendChild(document.createTextNode("@-ms-viewport{width:auto!important}"));
  document.querySelector("head").appendChild(msViewportStyle);
}

setHeights = function() {
  $('.js-set-height').css({
    'min-height': $(window).height(),
    'max-height': $(window).height()
  });
  $('.js-set-min-height').css({
    'min-height': $(window).height()
  });
  return $('[data-offset]').each(function() {
    return $(this).attr('data-offset', $(this).offset().top);
  });
};

preCacheImages = function() {
  var imgArray;
  imgArray = $.makeArray($('[data-precache]'));
  return $.each(imgArray, function() {
    var img;
    img = new Image();
    return img.src = $(this).data('precache');
  });
};

bottomWaypoint = function() {
  $('#index-page body').waypoint({
    offset: 'bottom-in-view',
    handler: function(direction) {
      if (direction === 'down') {
        return $('footer').addClass('is-bottom');
      } else {
        return $('footer').removeClass('is-bottom');
      }
    }
  });
  return $('.tools__scroll-container').waypoint({
    offset: -$('.tools__scroll-container').height() + $(window).height(),
    context: '.tools',
    handler: function(direction) {
      if (direction === 'down') {
        return $('footer').addClass('is-bottom');
      } else {
        return $('footer').removeClass('is-bottom');
      }
    }
  });
};

$('#index-page a[href*=\"#\"]').on('click', function(e) {
  if ($(this.hash).selector !== '#toolkits') {
    $('html,body').animate({
      scrollTop: $(this.hash).offset().top
    }, 900, 'easeOutQuad');
    return false;
    return e.preventDefault();
  } else {
    $('html,body').animate({
      scrollTop: $('[data-offset]').attr('data-offset')
    }, 900, 'easeOutQuad');
    return false;
    return e.preventDefault();
  }
});

$('#project-page .back-to-top').on('click', function(e) {
  $('.tools').animate({
    scrollTop: $('body').offset().top
  }, 900, 'easeOutQuad');
  return false;
  return e.preventDefault();
});

$('.tools__title .logo').on('click', function(e) {
  $('.panel').addClass('is-highlighted');
  $('.tools').animate({
    scrollTop: $('.tools__scroll-container').height()
  }, 900, 'easeOutQuad', function() {
    return $('.panel').removeClass('is-highlighted');
  });
  return false;
  return e.preventDefault();
});

$(function($) {
  var $window;
  $(document).on('click', function(event) {
    if (!$(event.target).closest('.tools-group__share').length) {
      return $('.tools-group__share').parent().next().addClass('js-is-hidden');
    }
  });
  $('.tools-groups').on('click', '.tools-group__share', function() {
    return $(this).parent().next().toggleClass('js-is-hidden');
  });
  $window = $(window);
  return $('div[data-type=\"background\"], header[data-type=\"background\"], section[data-type=\"background\"]').each(function() {
    var $bgobj;
    $bgobj = $(this);
    return $(window).scroll(function() {
      var coords, yPos;
      yPos = -($window.scrollTop() / $bgobj.data("speed"));
      coords = "50% " + yPos + "px";
      return $bgobj.css({
        backgroundPosition: coords
      });
    });
  });
});

$(function() {
  $('.equal-height').equalize({
    children: 'p'
  });
  return $('.project-box figure').on('mouseover', function() {
    return $(this).css({
      'background-image': 'url(' + $(this).data("precache") + ')',
      'background-size': 'cover',
      'background-position': 'center center',
      'background-repeat': 'no-repeat'
    });
  }).on('mouseleave', function() {
    return $(this).css({
      'background-image': '',
      'background-size': 'cover',
      'background-position': 'center center',
      'background-repeat': 'no-repeat'
    });
  });
});

$(window).on('load', function() {
  preCacheImages();
  if (window.location.hash === '#toolkits') {
    $('html,body').animate({
      scrollTop: $('.works').offset().top
    }, 0, 'easeOutQuad');
  }
  if (!head.mobile) {
    setHeights();
    bottomWaypoint();
    new WOW().init();
  }
  $(".status").fadeOut();
  return $(".preloader").delay(1000).fadeOut("slow");
});

$(window).on('resize', function() {
  ww = $(window).width();
  wh = $(window).height();
  $(".equal-height").equalize({
    children: "h6"
  });
  if (!head.mobile) {
    setHeights();
    return bottomWaypoint();
  }
});
