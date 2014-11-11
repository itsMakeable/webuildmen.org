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
	$('[data-offset]').each(->
		$(this).attr('data-offset', $(this).offset().top)
		)

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


$('#index-page a[href*=\"#\"]').on 'click', (e) ->
	if $(@hash).selector != '#toolkits'
		$('html,body').animate
			scrollTop: $(@hash).offset().top
		, 900, 'easeOutQuad'
		return false
		e.preventDefault()
	else
		$('html,body').animate
			scrollTop: $('[data-offset]').attr('data-offset')
		, 900, 'easeOutQuad'
		return false
		e.preventDefault()

$('#project-page .back-to-top').on 'click', (e) ->
	$('.tools').animate
			scrollTop: $('body').offset().top
	, 900, 'easeOutQuad'
	return false
	e.preventDefault()



$('.tools__title .logo').on 'click', (e) ->
	$('.panel').addClass('is-highlighted')
	$('.tools').animate
			scrollTop: $('.tools__scroll-container').height()
		, 900, 'easeOutQuad', ->
			$('.panel').removeClass('is-highlighted')
	return false
	e.preventDefault()


# ================================
#===  PROJECT LOADING           ====
#================================= 
$ ($) ->
		
	$(document).on 'click', (event) ->
		if !$(event.target).closest('.tools-group__share').length
			$('.tools-group__share').parent().next().addClass('js-is-hidden')

	$('.tools-groups').on 'click', '.tools-group__share', ->
		$(this).parent().next().toggleClass('js-is-hidden')


	
	# ================================
	#===  PARALLAX                ====
	#================================= 
	$window = $(window)
	$('div[data-type=\"background\"], header[data-type=\"background\"], section[data-type=\"background\"]').each ->
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
	preCacheImages()
	setHeights()

	if window.location.hash == '#toolkits'
		console.log $('.works').offset().top
		$('html,body').animate
			scrollTop: $('.works').offset().top
		, 0, 'easeOutQuad'

	if !head.mobile
		bottomWaypoint()

	# will first fade out the loading animation
	$(".status").fadeOut()
	# will fade out the whole DIV that covers the website.
	$(".preloader").delay(1000).fadeOut "slow"

$(window).on 'resize', ->
	ww = $(window).width()
	wh = $(window).height()

	$(".equal-height").equalize children: "h6"
	setHeights()
	if !head.mobile
		bottomWaypoint()
	# if ww > 1024 && !head.touch
	# 	scrollWaypoint()