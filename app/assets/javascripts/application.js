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

// Create the dropdown base
$("<select />").appendTo("nav");

// Create default option "Go to..."
$("<option />", {
   "selected": "selected",
   "value"   : "",
   "text"    : "Go to..."
}).appendTo("nav select");

// Populate dropdown with menu items
$("nav a").each(function() {
 var el = $(this);
 $("<option />", {
     "value"   : el.attr("href"),
     "text"    : el.text()
 }).appendTo("nav select");
});

$("nav select").change(function() {
    window.location = $(this).find("option:selected").val();
    });

function success(pos) {
  var crd = pos.coords;
  document.cookie = `lat_long=${crd.latitude + "|" + crd.longitude}`;
}

function error(err) {
  console.warn(`ERROR(${err.code}): ${err.message}`);
}

function writeCookie() {
   cookievalue = escape(document.location_form.location.value) + ";"
   document.cookie = "manual_location=" + cookievalue;
}

async function updatePage(){
    var repeater;
    var survey_id = $('.temp_information').data('survey-id')
    var api_url = $('.temp_information').data('api-url')
    const response = await fetch(`https://${api_url}/api/v1/surveys/${survey_id}`, {});
    const json = await response.json();
    var total_votes = json.data.attributes.total_votes;
    var restaurant_1_votes = json.data.attributes.restaurant_1_votes;
    var restaurant_2_votes = json.data.attributes.restaurant_2_votes;
    var restaurant_3_votes = json.data.attributes.restaurant_3_votes;

    document.getElementById("total-votes").innerHTML=total_votes;
    document.getElementById("sr1-votes").innerHTML=restaurant_1_votes;
    document.getElementById("sr2-votes").innerHTML=restaurant_2_votes;
    document.getElementById("sr3-votes").innerHTML=restaurant_3_votes;
    repeater = setTimeout(updatePage, 3000);
  };
