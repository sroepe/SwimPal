<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
		<link rel="stylesheet" type="text/css" href="css/style.css">
		<title>SwimPal - Find a nearby pool or aquatic center!</title>
	</head>
	<body>
		<div class="container-fluid" id="header">
			<h1 class="align-text-middle">SwimPal</h1>
			
			
		</div>
		
		<nav class="navbar navbar-dark bg-primary">
			<form class="form-inline my-2 my-lg-0">
		      <input class="form-control mr-sm-2" type="search" placeholder="Enter Zip Code" aria-label="Search">
		      <button class="btn btn-outline-light my-2 my-sm-0" type="submit">Find Pool</button>
		    </form>
  			<a class="navbar-brand" href="#">My Pools</a>
  			<a class="navbar-brand" href="#">Events</a>
  			<a class="navbar-brand" href="#">Information</a>
  			<a class="navbar-brand" href="#">TBD1</a>
  			<a class="navbar-brand" href="#">About</a>
		</nav>
		<div class="container-fluid" id="panels">
  			<div class="row">
			    <div class="col-8" id="map">
			          <script>
					      // Note: This example requires that you consent to location sharing when
					      // prompted by your browser. If you see the error "The Geolocation service
					      // failed.", it means you probably did not give permission for the browser to
					      // locate you.
					      var map, infoWindow;
					      function initMap() {
					    	var currentLocation = {lat: -34.397, lng: 150.644};
					        map = new google.maps.Map(document.getElementById('map'), {
					          center: currentLocation,
					          zoom: 15
					        });
					        infoWindow = new google.maps.InfoWindow;
					
					        // Try HTML5 geolocation.
					        if (navigator.geolocation) {
					          navigator.geolocation.getCurrentPosition(function(position) {
					            var pos = {
					              lat: position.coords.latitude,
					              lng: position.coords.longitude
					            };
					
					            infoWindow.setPosition(pos);
					            infoWindow.setContent('Location found.');
					            infoWindow.open(map);
					            map.setCenter(pos);
					          }, function() {
					            handleLocationError(true, infoWindow, map.getCenter());
					          });
					        } else {
					          // Browser doesn't support Geolocation
					          handleLocationError(false, infoWindow, map.getCenter());
					        }
					      }
					
					      function handleLocationError(browserHasGeolocation, infoWindow, pos) {
					        infoWindow.setPosition(pos);
					        infoWindow.setContent(browserHasGeolocation ?
					                              'Error: The Geolocation service failed.' :
					                              'Error: Your browser doesn\'t support geolocation.');
					        infoWindow.open(map);
					      }
					    </script>
					    <script async defer
					    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyB6qRfQukE8p0wquYwtTalMrjFggF4iXMk&libraries=places&callback=initMap">
					    </script>
					    
			    </div>
			    <div class="col">
			      My Schedule
			      //registration
			      //login
			    </div>

  			</div>
		</div>
		
		<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
	    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
	    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
	</body>
</html>