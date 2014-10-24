var bottomWaypoint, msViewportStyle;

if (navigator.userAgent.match(/IEMobile\/10\.0/)) {
  msViewportStyle = document.createElement("style");
  msViewportStyle.appendChild(document.createTextNode("@-ms-viewport{width:auto!important}"));
  document.querySelector("head").appendChild(msViewportStyle);
}

$(function() {
  var top;
  $("#home .main-nav-list").onePageNav({
    scrollThreshold: 0.2,
    scrollOffset: 75,
    changeHash: true
  });
  return top = $("#main-nav").offset().top - parseFloat($("#main-nav").css("margin-top").replace(/auto/, 0));
});

bottomWaypoint = function() {
  $("body").waypoint({
    offset: -$(document).height() - 800,
    handler: function(direction) {
      if (direction === 'down') {
        return $("footer").addClass('is-bottom');
      } else {
        return $("footer").removeClass('is-bottom');
      }
    }
  });
  return $(".tools__scroll-container").waypoint({
    offset: -$(".tools__scroll-container").height() + $(window).height(),
    context: '.tools',
    handler: function(direction) {
      if (direction === 'down') {
        return $("footer").addClass('is-bottom');
      } else {
        return $("footer").removeClass('is-bottom');
      }
    }
  });
};

$("a[href^=\"#\"]").on('click', function() {
  $("html,body").animate({
    scrollTop: $(this.hash).offset().top
  }, 700);
  return false;
  return e.preventDefault();
});

$(function($) {
  var $window;
  $(".more").on("click", function(event) {
    var content, href, portfolioList;
    event.preventDefault();
    href = $(this).attr("href");
    portfolioList = $("#portfolio-list");
    content = $("#loaded-content");
    portfolioList.animate({
      marginLeft: "-120%"
    }, {
      duration: 400,
      queue: false
    });
    portfolioList.fadeOut(400);
    setTimeout((function() {
      $("#loader").show();
    }), 400);
    setTimeout((function() {
      content.load(href, function() {
        $("#loaded-content meta").remove();
        $("#loader").hide();
        content.fadeIn(600);
        $("#back-button").fadeIn(600);
        window.location.hash = href;
      });
    }), 800);
  });
  $("#back-button").on("click", function(event) {
    var content, portfolioList;
    event.preventDefault();
    portfolioList = $("#portfolio-list");
    content = $("#loaded-content");
    content.fadeOut(400);
    $("#back-button").fadeOut(400);
    return setTimeout((function() {
      portfolioList.animate({
        marginLeft: "0"
      }, {
        duration: 400,
        queue: false
      });
      portfolioList.fadeIn(600);
    }), 800);
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
  $(".equal-height").equalize({
    children: "h6"
  });
  return $('.project-box figure').on('mouseover', function() {
    return $(this).css({
      'background': $(this).data('background')
    });
  }).on('mouseleave', function() {
    return $(this).css({
      'background': ''
    });
  });
});

$(window).on('load', function() {
  bottomWaypoint();
  $('.js-set-height').css({
    'min-height': $(window).height(),
    'max-height': $(window).height()
  });
  $('.js-set-min-height').css({
    'min-height': $(window).height()
  });
  $(".status").fadeOut();
  return $(".preloader").delay(1000).fadeOut("slow");
});
