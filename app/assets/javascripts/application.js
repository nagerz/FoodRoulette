//= require jquery3
//= require popper
//= require bootstrap-sprockets

// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .
function success(pos) {
  var crd = pos.coords;
  document.cookie = `lat_long=${crd.latitude + "|" + crd.longitude}`;
}

function error(err) {
  console.warn(`ERROR(${err.code}): ${err.message}`);
}

function WriteCookie() {
   cookievalue = escape(document.location_form.location.value) + ";"
   document.cookie = "manual_location=" + cookievalue;
}

// jQuery(function($) {
//     // Asynchronously Load the map API
//     var script = document.createElement('script');
//     script.src = "//maps.googleapis.com/maps/api/js?sensor=false&callback=initialize";
//     document.body.appendChild(script);
// });
//
// function initialize() {
//     var map;
//     var bounds = new google.maps.LatLngBounds();
//     var mapOptions = {
//         mapTypeId: 'roadmap'
//     };
//
//     // Display a map on the page
//     map = new google.maps.Map(document.getElementById("map_canvas"), mapOptions);
//     map.setTilt(45);
//
//     // Multiple Markers
//     var markers = [
//         ['rest_1', 51.503454,-0.119562],
//         ['rest_2', 51.499633,-0.124755],
//         ['rest_3', 51.4997,-0.124755]
//     ];
//
//     // // Info Window Content
//     var infoWindowContent = [
//         ['<div class="info_content">' + '<h3>A</h3>' +  '</div>'],
//         ['<div class="info_content">' + '<h3>B</h3>' + '</div>'],
//         ['<div class="info_content">' + '<h3>C</h3>' + '</div>']
//     ];
//
//     // Display multiple markers on a map
//     var infoWindow = new google.maps.InfoWindow(), marker, i;
//
//     // Loop through our array of markers & place each one on the map
//     for( i = 0; i < markers.length; i++ ) {
//         var position = new google.maps.LatLng(markers[i][1], markers[i][2]);
//         bounds.extend(position);
//         marker = new google.maps.Marker({
//             position: position,
//             map: map,
//             title: markers[i][0]
//         });
//
//         // Allow each marker to have an info window
//         google.maps.event.addListener(marker, 'click', (function(marker, i) {
//             return function() {
//                 infoWindow.setContent(infoWindowContent[i][0]);
//                 infoWindow.open(map, marker);
//             }
//         })(marker, i));
//
//         // Automatically center the map fitting all markers on the screen
//         map.fitBounds(bounds);
//     }
//
//     // Override our map zoom level once our fitBounds function runs (Make sure it only runs once)
//     var boundsListener = google.maps.event.addListener((map), 'bounds_changed', function(event) {
//         this.setZoom(14);
//         google.maps.event.removeListener(boundsListener);
//     });
//
// }

var map = L.map('map', {
  layers: MQ.mapLayer()
});

MQ.geocode({ map: map })
  .search('Boston,MA');
//
// function initMap() {
//   var map = new google.maps.Map(document.getElementById('map'), {
//     zoom: 8,
//     center: {lat: -34.397, lng: 150.644}
//   });
//   var geocoder = new google.maps.Geocoder();
//
//   geocodeAddress(geocoder, map);
// }
//
// function geocodeAddress(geocoder, resultsMap) {
//   var address = document.getElementById('address').value;
//   geocoder.geocode({'address': address}, function(results, status) {
//     if (status === 'OK') {
//       resultsMap.setCenter(results[0].geometry.location);
//       var marker = new google.maps.Marker({
//         map: resultsMap,
//         position: results[0].geometry.location
//       });
//     } else {
//       alert('Geocode was not successful for the following reason: ' + status);
//     }
//   });
// }
