# TODO: Refactor app.coffee
# TODO: Recheck heights on window resize
# TODO: Add mobile support to events


# =================================
#===  Bootstrap Fix              ====
#=================================== 
if navigator.userAgent.match(/IEMobile\/10\.0/)
	msViewportStyle = document.createElement("style")
	msViewportStyle.appendChild document.createTextNode("@-ms-viewport{width:auto!important}")
	document.querySelector("head").appendChild msViewportStyle

# =================================
#===  STICKY NAV                 ====
#=================================== 
$ ->
	$("#home .main-nav-list").onePageNav
		scrollThreshold: 0.2 # Adjust if Navigation highlights too early or too late
		scrollOffset: 75 #Height of Navigation Bar
		changeHash: true

	
	# Sticky Header - http://jqueryfordesigners.com/fixed-floating-elements/         
	top = $("#main-nav").offset().top - parseFloat($("#main-nav").css("margin-top").replace(/auto/, 0))
	# $(window).scroll (event) ->
		
	# 	# what the y position of the scroll is
	# 	y = $(this).scrollTop()
		
	# 	# whether that's below the form
	# 	if y >= top
			
	# 		# if so, ad the fixed class
	# 		$("#main-nav").addClass "fixed"
	# 	else
			
	# 		# otherwise remove it
	# 		$("#main-nav").removeClass "fixed"
	# return

bottomWaypoint = ->
	$("body")
		.waypoint
			offset: -$(document).height() - 800
			handler: (direction) ->
				if direction == 'down'
					$("footer").addClass 'is-bottom'
				else
					$("footer").removeClass 'is-bottom'
	$(".tools__scroll-container")
		.waypoint
			offset: -$(".tools__scroll-container").height() + $(window).height()
			context: '.tools'
			handler: (direction) ->
				
				if direction == 'down'
					$("footer").addClass 'is-bottom'
				else
					$("footer").removeClass 'is-bottom'

#=================================
#===  OWL CROUSEL               ====
#===================================
# $(document).ready ->
# 	owl = $("#client-feedbacks")
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
# 	$(".works.js-set-height .container")
# 		.waypoint
# 			offset: 0
# 			handler: (direction) ->
# 				console.log 'project'
# 				$("body")
# 					.css 
# 						'overflow': 'hidden'

	# $(".our-community .container")
	# 	.waypoint
	# 		offset: $(".works.js-set-height").height()
	# 		handler: (direction) ->
	# 			console.log 'community'
	# 			if direction == 'down'
	# 				$(".works.js-set-height")
	# 					.css 
	# 						'overflow': 'hidden'

#=================================
#===  SMOOTH SCROLL             ====
#=================================== 

# $(document).ready(function() {
#   var scrollAnimationTime = 1200,
#   scrollAnimation = 'easeInOutExpo';
#   $('a.scrollto').bind('click.smoothscroll',function (event) {
#     event.preventDefault();
#     var target = $(this).attr("href").substr(1);
#     $.scrollTo($(target), 1000, {offset:-75} );
#     hash = target.substr(1);
#     window.location.hash = hash;
#   });  
# }); 
$("a[href^=\"#\"]").on 'click', ->
	$("html,body").animate
		scrollTop: $(@hash).offset().top
	, 700
	return false
	e.preventDefault()
	
# ================================
#===  PROJECT LOADING           ====
#================================= 
$ ($) ->
	$(".more").on "click", (event) ->
		event.preventDefault()
		href = $(this).attr("href")
		portfolioList = $("#portfolio-list")
		content = $("#loaded-content")
		portfolioList.animate
			marginLeft: "-120%"
		,
			duration: 400
			queue: false

		portfolioList.fadeOut 400
		setTimeout (->
			$("#loader").show()
			return
		), 400
		setTimeout (->
			content.load href, ->
				$("#loaded-content meta").remove()
				$("#loader").hide()
				content.fadeIn 600
				$("#back-button").fadeIn 600
				window.location.hash = href
				return

			return
		), 800
		return

	$("#back-button").on "click", (event) ->
		event.preventDefault()
		portfolioList = $("#portfolio-list")
		content = $("#loaded-content")
		content.fadeOut 400
		$("#back-button").fadeOut 400
		setTimeout (->
			portfolioList.animate
				marginLeft: "0"
			,
				duration: 400
				queue: false

			portfolioList.fadeIn 600
			return
		), 800


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


# ================================
#===  KNOB                      ====
#================================= 

#
#$(function() {
#$(".skill1").knob({
#                'max':100,
#                'width': 64,
#                'readOnly':true,
#                'inputColor':' #FFFFFF ',
#                'bgColor':' #222222 ',
#                'fgColor':' #e96656 '
#                });
#$(".skill2").knob({
#                'max':100,
#                'width': 64,
#                'readOnly':true,
#                'inputColor':' #FFFFFF ',
#                'bgColor':' #222222 ',
#                'fgColor':' #34d293 '
#                });
#  $(".skill3").knob({
#                'max': 100,
#                'width': 64,
#                'readOnly': true,
#                'inputColor':' #FFFFFF ',
#                'bgColor':' #222222 ',
#                'fgColor':' #3ab0e2 '
#                });
#  $(".skill4").knob({
#                'max': 100,
#                'width': 64,
#                'readOnly': true,
#                'inputColor':' #FFFFFF ',
#                'bgColor':' #222222 ',
#                'fgColor':' #E7AC44 '
#                });
#});
#

# =================================
#===  WOW ANIMATION             ====
#=================================== 

new WOW().init();

# =================================
#===  MATCH HEIGHT             ====
#=================================== 
$ ->
	$(".equal-height").equalize children: "h6"
	
	$('.project-box figure')
		.on 'mouseover', ->
			$(this).css
				'background': $(this).data('background')
		.on 'mouseleave', ->
			$(this).css
				'background': ''



$(window).on 'load', ->
	bottomWaypoint()

	$('.js-set-height').css 
		'min-height': $(window).height()
		'max-height': $(window).height()
	$('.js-set-min-height').css 
		'min-height': $(window).height()
	# will first fade out the loading animation
	$(".status").fadeOut()
	# will fade out the whole DIV that covers the website.
	$(".preloader").delay(1000).fadeOut "slow"