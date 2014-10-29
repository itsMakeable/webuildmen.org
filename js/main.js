var bottomWaypoint, msViewportStyle, preCacheImages, scrollWaypoint, setHeights, wh, ww;

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
  return $('.js-set-min-height').css({
    'min-height': $(window).height()
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

scrollWaypoint = function() {
  return $('.works .container').waypoint({
    offset: 0,
    handler: function(direction) {
      if (direction === 'down') {
        return $('.works').css({
          'background-attachment': 'fixed'
        });
      } else {
        return $('.works').css({
          'background-attachment': 'scroll'
        });
      }
    }
  });
};

$("a[href*=\"#\"]").on('click', function(e) {
  if ($(this.hash).selector !== '#toolkits') {
    $("html,body").animate({
      scrollTop: $(this.hash).offset().top
    }, 700);
  } else {
    $("html,body").animate({
      scrollTop: $('[data-offset]').attr('data-offset')
    }, 700);
    return false;
  }
  return e.preventDefault();
});

$(function($) {
  var $window;
  $(".js-like-button").on('click', function() {
    $(".fb-like").find("a.connect_widget_like_button").click();
  });
  $('.tools-icons').on('click', '.tools-icons__share', function() {
    return $(this).parent().next().toggleClass('js-is-hidden');
  });
  $window = $(window);
  return $("div[data-type=\"background\"], header[data-type=\"background\"], section[data-type=\"background\"]").each(function() {
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

new WOW().init();

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
  bottomWaypoint();
  preCacheImages();
  setHeights();
  if (ww > 1024 && !head.touch) {
    scrollWaypoint();
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
  setHeights();
  if (ww > 1024 && !head.touch) {
    return scrollWaypoint();
  }
});
