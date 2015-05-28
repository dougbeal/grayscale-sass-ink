# /*!
#  * Start Bootstrap - Grayscale Bootstrap Theme (http://startbootstrap.com)
#  * Code licensed under the Apache License v2.0.
#  * For details, see http://www.apache.org/licenses/LICENSE-2.0.
#  */

# jQuery to collapse the navbar on scroll
$(window).scroll ->
  if $('.navbar').offset().top > 50
    $('.navbar-fixed-top').addClass "top-nav-collapse"
  else
    $('.navbar-fixed-top').removeClass "top-nav-collapse"

# jQuery for page scrolling feature - requires jQuery Easing plugin
$ ->
  $('a.page-scroll').bind 'click', (event) ->
    $anchor = $(this)
    $('html, body').stop().animate { scrollTop: $($anchor.attr('href')).offset().top }, 1500, 'easeInOutExpo'
    event.preventDefault()
    return
  return

# Closes the Responsive Menu on Menu Item Click
$('.navbar-collapse ul li a').click ->
  $('.navbar-toggle:visible').click()
  return

# Google Maps Scripts
# When the window has finished loading create our google map below
google.maps.event.addDomListener window, 'load', init

init = ->
  # Basic options for a simple Google Map
  # For more options see: https://developers.google.com/maps/documentation/javascript/reference#MapOptions
  mapOptions =
    zoom: 15
    center: new (google.maps.LatLng)(40.6700, -73.9400)
    disableDefaultUI: true
    scrollwheel: false
    draggable: false
    styles: [
      {
        'featureType': 'water'
        'elementType': 'geometry'
        'stylers': [
          { 'color': '#000000' }
          { 'lightness': 17 }
        ]
      }
      {
        'featureType': 'landscape'
        'elementType': 'geometry'
        'stylers': [
          { 'color': '#000000' }
          { 'lightness': 20 }
        ]
      }
      {
        'featureType': 'road.highway'
        'elementType': 'geometry.fill'
        'stylers': [
          { 'color': '#000000' }
          { 'lightness': 17 }
        ]
      }
      {
        'featureType': 'road.highway'
        'elementType': 'geometry.stroke'
        'stylers': [
          { 'color': '#000000' }
          { 'lightness': 29 }
          { 'weight': 0.2 }
        ]
      }
      {
        'featureType': 'road.arterial'
        'elementType': 'geometry'
        'stylers': [
          { 'color': '#000000' }
          { 'lightness': 18 }
        ]
      }
      {
        'featureType': 'road.local'
        'elementType': 'geometry'
        'stylers': [
          { 'color': '#000000' }
          { 'lightness': 16 }
        ]
      }
      {
        'featureType': 'poi'
        'elementType': 'geometry'
        'stylers': [
          { 'color': '#000000' }
          { 'lightness': 21 }
        ]
      }
      {
        'elementType': 'labels.text.stroke'
        'stylers': [
          { 'visibility': 'on' }
          { 'color': '#000000' }
          { 'lightness': 16 }
        ]
      }
      {
        'elementType': 'labels.text.fill'
        'stylers': [
          { 'saturation': 36 }
          { 'color': '#000000' }
          { 'lightness': 40 }
        ]
      }
      {
        'elementType': 'labels.icon'
        'stylers': [ { 'visibility': 'off' } ]
      }
      {
        'featureType': 'transit'
        'elementType': 'geometry'
        'stylers': [
          { 'color': '#000000' }
          { 'lightness': 19 }
        ]
      }
      {
        'featureType': 'administrative'
        'elementType': 'geometry.fill'
        'stylers': [
          { 'color': '#000000' }
          { 'lightness': 20 }
        ]
      }
      {
        'featureType': 'administrative'
        'elementType': 'geometry.stroke'
        'stylers': [
          { 'color': '#000000' }
          { 'lightness': 17 }
          { 'weight': 1.2 }
        ]
      }
    ]
  # Get the HTML DOM element that will contain your map
  # We are using a div with id="map" seen below in the <body>
  mapElement = document.getElementById('map')
  # Create the Google Map using out element and options defined above
  map = new (google.maps.Map)(mapElement, mapOptions)
  # Custom Map Marker Icon - Customize the map-marker.png file to customize your icon
  image = 'img/map-marker.png'
  myLatLng = new (google.maps.LatLng)(40.6700, -73.9400)
  beachMarker = new (google.maps.Marker)(
    position: myLatLng
    map: map
    icon: image)
  return
