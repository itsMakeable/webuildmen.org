# TODO: Refactor app.coffee
# TODO: Recheck heights on window resize @done
# TODO: Add mobile support to events @done

ww = $(window).width()
wh = $(window).height()

# =================================
#===  Bootstrap Fix              ====
#=================================== 
if navigator.userAgent.match(/IEMobile\/10\.0/)
	msViewportStyle = document.createElement("style")
	msViewportStyle.appendChild document.createTextNode("@-ms-viewport{width:auto!important}")
	document.querySelector("head").appendChild msViewportStyle

setHeights = ->
	$('.js-set-height').css 
		'min-height': $(window).height()
		'max-height': $(window).height()
	$('.js-set-min-height').css 
		'min-height': $(window).height()

preCacheImages = ->
	imgArray = $.makeArray($('[data-precache]'))
	$.each imgArray, ->
		img = new Image()
		img.src = $(this).data('precache')
		
bottomWaypoint = ->
	$('#index-page body')
		.waypoint
			offset: 'bottom-in-view'
			handler: (direction) ->
				if direction == 'down'
					$('footer').addClass 'is-bottom'
				else
					$('footer').removeClass 'is-bottom'

	$('.tools__scroll-container')
		.waypoint
			offset: -$('.tools__scroll-container').height() + $(window).height()
			context: '.tools'
			handler: (direction) ->
				if direction == 'down'
					$('footer').addClass 'is-bottom'
					# $('.tools__actions').removeClass 'js-is-hidden'
				else
					$('footer').removeClass 'is-bottom'
					# $('.tools__actions').addClass 'js-is-hidden'

#=================================
#===  OWL CROUSEL               ====
#===================================
# $(document).ready ->
# 	owl = $('#client-feedbacks')
# 	owl.owlCarousel
# 		items: 3 #10 items above 1000px browser width
# 		itemsDesktop: [ #5 items between 1000px and 901px
# 			1000
# 			2
# 		]
# 		itemsDesktopSmall: [ # betweem 900px and 601px
# 			900
# 			1
# 		]
# 		itemsTablet: [ #2 items between 600 and 0
# 			600
# 			1
# 		]
# 		itemsMobile: false # itemsMobile disabled - inherit from itemsTablet option

# 	return


#=================================
#===  SCROLL WAYPOINT             ====
#=================================== 
# scrollWaypoint = ->
# 	$('.works .container')
# 		.waypoint
# 			offset: 0
# 			handler: (direction) ->
# 				if direction == 'down'
# 					$('.works')
# 						.css 
# 							'background-attachment': 'fixed'
# 				else
# 					$('.works')
# 						.css 
# 							'background-attachment': 'scroll'


#=================================
#===  SMOOTH SCROLL             ====
#=================================== 

# $(document).ready(function() {
#   var scrollAnimationTime = 1200,
#   scrollAnimation = 'easeInOutExpo';
#   $('a.scrollto').bind('click.smoothscroll',function (event) {
#     event.preventDefault();
#     var target = $(this).attr('href').substr(1);
#     $.scrollTo($(target), 1000, {offset:-75} );
#     hash = target.substr(1);
#     window.location.hash = hash;
#   });  
# }); 
	

$("#index-page a[href*=\"#\"]").on 'click', (e) ->
	$("html,body").animate
		scrollTop: $(@hash).offset().top
	, 700
	e.preventDefault()

$("#project-page a[href*=\"#\"]").on 'click', (e) ->
	$(".tools").animate
			scrollTop: $('.tools__scroll-container').offset().top
		, 700
		return false
	e.preventDefault()

$(".tools__title .logo").on 'click', (e) ->
	$('.panel').addClass('is-highlighted')
	$(".tools").animate
			scrollTop: $('.panel').offset().top
		, 700, ->
			$('.panel').removeClass('is-highlighted')
		return false
	e.preventDefault()


# ================================
#===  PROJECT LOADING           ====
#================================= 
$ ($) ->
		
	$(document).on "click", (event) ->
		if !$(event.target).closest('.tools-icons__share').length
			$('.tools-icons__share').parent().next().addClass('js-is-hidden')

	$('.tools-icons').on 'click', '.tools-icons__share', ->
		$(this).parent().next().toggleClass('js-is-hidden')


	
	# ================================
	#===  PARALLAX                ====
	#================================= 
	$window = $(window)
	$("div[data-type=\"background\"], header[data-type=\"background\"], section[data-type=\"background\"]").each ->
		$bgobj = $(this)
		$(window).scroll ->
			yPos = -($window.scrollTop() / $bgobj.data("speed"))
			coords = "50% " + yPos + "px"
			$bgobj.css backgroundPosition: coords

# =================================
#===  WOW ANIMATION             ====
#=================================== 

new WOW().init();

# =================================
#===  MATCH HEIGHT             ====
#=================================== 
$ ->
	$('.equal-height').equalize children: 'p'
	
	$('.project-box figure')
		.on 'mouseover', ->
			$(this).css
				'background-image': 'url(' + $(this).data("precache") + ')'
				'background-size': 'cover'
				'background-position': 'center center'
				'background-repeat': 'no-repeat'
		.on 'mouseleave', ->
			$(this).css
				'background-image': ''
				'background-size': 'cover'
				'background-position': 'center center'
				'background-repeat': 'no-repeat'

$(window).on 'load', ->
	bottomWaypoint()
	preCacheImages()
	setHeights()
	
	# if ww > 1024 && !head.touch
	# 	scrollWaypoint()

	# will first fade out the loading animation
	$(".status").fadeOut()
	# will fade out the whole DIV that covers the website.
	$(".preloader").delay(1000).fadeOut "slow"

$(window).on 'resize', ->
	ww = $(window).width()
	wh = $(window).height()

	$(".equal-height").equalize children: "h6"
	setHeights()
	
	# if ww > 1024 && !head.touch
	# 	scrollWaypoint()