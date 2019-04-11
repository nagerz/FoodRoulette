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

async function initMap(){
  var restaurant_id = $('.temp_information').data('restaurant-id');
  var response = await fetch(`http://localhost:3000/api/v1/restaurants/${restaurant_id}`, {});
  var json = await response.json();

  var user_manual_location = $('.temp_information').data('user-manual-location');
  var user_latlong = $('.temp_information').data('user-latlong');

  if (user_manual_location != null) {
    var search_location = user_manual_location
  } else {
    var latlong = []
    var lat = user_latlong.split("|")[0]
    var long = user_latlong.split("|")[1]
    lat = parseFloat(lat)
    long = parseFloat(long)
    latlong.push(lat)
    latlong.push(long)
  }

  var restaurant_name = json.data.attributes.name;
  var restaurant_address = json.data.attributes.address;
  var restaurant_lat = json.data.attributes.latitude;
  var restaurant_long = json.data.attributes.longitude;
  var rest_latlong = []
  rest_latlong.push(restaurant_lat)
  rest_latlong.push(restaurant_long)

  var names = ["Current Location", restaurant_name];

  window.onload = function() {
    L.mapquest.key = mapquestKey;

    // Geocode the locations, then call the createMap callback
    if (user_manual_location == null) {
      var addresses = [latlong, rest_latlong];
      console.log(addresses)
      L.mapquest.geocoding().geocoder.reverse(addresses, createMap);
    } else {
      var addresses = [user_manual_location, restaurant_address];
      L.mapquest.geocoding().geocode(addresses, createMap);
    }

    function createMap(error, response) {
      // Initialize the Map
      var map = L.mapquest.map('map', {
        layers: L.mapquest.tileLayer('map'),
        center: [0, 0],
        zoom: 15
      });

      // Generate the feature group containing markers from the geocoded locations
      var featureGroup = generateMarkersFeatureGroup(response, names);

      // Add markers to the map and zoom to the features
      featureGroup.addTo(map);
      map.fitBounds(featureGroup.getBounds());
    }

    function generateMarkersFeatureGroup(response, names) {
      var group = [];
      var location = response.results[0].locations[0];
      var locationLatLng = location.latLng;
      var location2 = response.results[1].locations[0];
      var locationLatLng2 = location2.latLng;

        // Create a marker for each location
      var marker = L.marker(locationLatLng, {icon: L.mapquest.icons.circle({primaryColor: '#22407F'})})
        .bindPopup(names[0]);
      var marker2 = L.marker(locationLatLng2, {icon: L.mapquest.icons.marker({symbol: 'A'})})
        .bindPopup(names[1]);

        group.push(marker);
        group.push(marker2);
      return L.featureGroup(group);
    }
  }
};

async function initSurveyMap(){
  var restaurant_1_id = $('.temp_information').data('restaurant-id-1');
  var restaurant_2_id = $('.temp_information').data('restaurant-id-2');
  var restaurant_3_id = $('.temp_information').data('restaurant-id-3');
  var response_1 = await fetch(`http://localhost:3000/api/v1/restaurants/${restaurant_1_id}`, {});
  var response_2 = await fetch(`http://localhost:3000/api/v1/restaurants/${restaurant_2_id}`, {});
  var response_3 = await fetch(`http://localhost:3000/api/v1/restaurants/${restaurant_3_id}`, {});
  var json_1 = await response_1.json();
  var json_2 = await response_2.json();
  var json_3 = await response_3.json();

  var restaurant_1_name = json_1.data.attributes.name;
  var restaurant_2_name = json_2.data.attributes.name;
  var restaurant_3_name = json_3.data.attributes.name;
  var restaurant_1_address = json_1.data.attributes.address;
  var restaurant_2_address = json_2.data.attributes.address;
  var restaurant_3_address = json_3.data.attributes.address;

  var addresses = [
  restaurant_1_address, restaurant_2_address, restaurant_3_address
  ];
  var names = [
  restaurant_1_name, restaurant_2_name, restaurant_3_name
  ];

  async function renderMap() {
    L.mapquest.key = mapquestKey;

    // Geocode three locations, then call the createMap callback
    L.mapquest.geocoding().geocode(addresses, createMap);

    async function createMap(error, response) {

      // Initialize the Map
      var map = L.mapquest.map('map', {
        layers: L.mapquest.tileLayer('map'),
        center: [0, 0],
        zoom: 15
      });

      // Generate the feature group containing markers from the geocoded locations
      var featureGroup = generateMarkersFeatureGroup(response, names);

      // Add markers to the map and zoom to the features
      featureGroup.addTo(map);
      map.fitBounds(featureGroup.getBounds());
    }

    async function generateMarkersFeatureGroup(response, names) {
      var group = [];
      for (var i = 0; i < response.results.length; i++) {
        var location = response.results[i].locations[0];
        var locationLatLng = location.latLng;

        // Create a marker for each location
        var marker = L.marker(locationLatLng, {icon: L.mapquest.icons.marker()})
          .bindPopup("test");

        group.push(marker);
      }
      return L.featureGroup(group);
    }
  }
};
