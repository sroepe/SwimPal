<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
		<link rel="stylesheet" type="text/css" href="css/style.css">
		<link rel="shortcut icon" href="images/swimblack.ico">
		<title>SwimPal - Swim Seattle Pools Now!</title>
	</head>
	<body>   <!--This main page is for logged in users.  'main' loads as "home" page when non-logged users.  -->
		<div class="container-fluid" id="header">
			<form method="post" action="/">
				<button>
					<h1 class="align-text-middle medLg"><img src="images/swim_white.png">SwimPal</h1>
				</button>
			</form>
			<h5 class="medLg">Swim Seattle Pools Now</h5>
			
			<a href="/"><h1 class="sm"><img src="/images/swim_white.png">SwimPal</h1></a>
		</div>
		<nav class="navbar navbar-dark bg-primary smLog medLog">
			<p class="navbar-brand" id="curTime"> <c:set var = "now" value = "<%= new java.util.Date()%>" />
		 	<img src="images/watchWhite.png">  <fmt:formatDate pattern="h:mm a"  value="${now}" /></p>
			<div class="lg" id="legend">
				<img src="https://png.icons8.com/metro/50/1A7B02/swimming.png"> Swims Available Now
				<img src="https://png.icons8.com/metro/50/F31E1E/swimming.png"> No Swims Currently Available
				<img src="https://png.icons8.com/metro/50/000000/swimming.png"> Pool Closed for Season
			</div>
			<a class="navbar-brand" href="/pools">Seattle Pools</a>

  			<c:if test="${sessionAttribute != 'noLoggedUser'}">
  				<a class="navbar-brand" href="/mySwims">My Swims</a>
  				<div class="logged">
		  			<p class="navbar-brand">Hello <c:out value="${sessionAttribute.firstName}"></c:out>!</p>
		  			<p><a class="navbar-brand-sm" href="/logout">Logout</a><p>
	  			</div>
  			</c:if>
		</nav>

  			<div class="row medLog" id="legend">  <!--this legend appears on medium screen sizes, not visible on small or large screens  -->
  				<p><img src="https://png.icons8.com/metro/50/1A7B02/swimming.png">Swims Available Now<br>
				<img src="https://png.icons8.com/metro/50/F31E1E/swimming.png">No Swims Currently Available<br>
				<img src="https://png.icons8.com/metro/50/000000/swimming.png">Pool Closed for Season</p>
  			</div>
			    <div id="mapOnly" class="medLog"></div> <!--this div holds the google map; script that follows generates markers from db info and populates map upon init map function being called;  also info window information established below under 'content'  -->
			    	<script>	
						var markers = [];
				    	var poolLocations = [<c:forEach items="${pools}" var = "pool" >{
		                    coords: {lat:${pool.lat}, lng:${pool.lng}},
		                    iconImg:'https://png.icons8.com/metro/50/000000/swimming.png',
		                    iconYes: 'https://png.icons8.com/metro/50/0D9834/swimming.png',
		                    iconNo: 'https://png.icons8.com/metro/50/F31E1E/swimming.png',
							content: 	'<a href="/pools/${pool.id}"><h3>${pool.name}</h3></a>'+
		                    			'<p><a href="${pool.website}" target="_blank">${pool.website}</a><br>'+
		                    			'${pool.address} ${pool.city}, ${pool.state} ${pool.postcode}<br>'+
		                    			'${pool.phone}</p>'+
		                    			'<p><a href="https://www.google.com/maps/dir/?api=1&destination=${pool.lat},${pool.lng}" target="_blank">Get Directions</a></p>'+
		                    			'<c:if test="${pool.seasonal == true}"><span id="seasonal">${pool.note}</span></c:if>'+  			
		                    			'<table id="schedTable">'+
		                    			'<c:forEach items="${schedulesNow}" var = "schedule">'+ 			
		                    			'<c:if test="${pool.id == schedule.pool.id}">'+
		                    			'<tr><td>${schedule.swim} </td><td><fmt:formatDate value="${schedule.start}" pattern="h:mm a"/> - '+
		                    			'<fmt:formatDate value="${schedule.end}" pattern="h:mm a"/></td><c:if test="${schedule.note != null}"><td>${schedule.note}</td></c:if></tr>'+
		                    			'</c:if></c:forEach></table><br>'+
		                    			'<a href="/pools/${pool.id}">View Full Schedule</a>'
		      				
											},
											</c:forEach>
						];
				    	var mapCenter = {lat: 47.607, lng: -122.339}; //seattle
	
				    	function initMap() {
				    	  var map = new google.maps.Map(document.getElementById('mapOnly'), {
				    		  center: mapCenter,
					          zoom: 11
				    	  });
							
				    	  setMarkers(map);
					      
				    	}
	 
				    	function setMarkers(map) {
				    		for(var idx = 0; idx < poolLocations.length; idx++){
				    			var poolLocation = poolLocations[idx];
					    	    var poolInfo = new google.maps.InfoWindow({
					    	    	content: poolLocation.content
					    	    });
		
					    	    var marker = new google.maps.Marker({
					    	    	position: poolLocation.coords,
						        	map: map,
							        icon: poolLocation.iconImg,
					    	      	infowindow: poolInfo
					    	    });
					    	    
					    	    
					    	  	if(poolLocation.content.includes("tr")) {
									//set custom icon green if swim times available
									marker.setIcon(poolLocation.iconYes);	
								} else if(!poolLocation.content.includes("tr")) {
									//set custom icon red if swim times NOT available
									marker.setIcon(poolLocation.iconNo);
									
									if(poolLocation.content.includes("seasonal")) {
									//set custom icon green if seasonal pool open and swim times are available
									marker.setIcon(poolLocation.iconImg);
									}
								} 				
					    	    markers.push(marker);
		
					    	    google.maps.event.addListener(marker, 'click', function() {
					    	      hideAllInfoWindows(map);
					    	      this.infowindow.open(map, this);
					    	    });
				    		}
				    	}
	
				    	function hideAllInfoWindows(map) {
				    	   markers.forEach(function(marker) {
				    	     marker.infowindow.close(map, marker);
				    	  }); 
				    	}    	
				    	
			    	</script>
			    	
				    <script async defer
				    	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyB6qRfQukE8p0wquYwtTalMrjFggF4iXMk&libraries=places&callback=initMap">
				    </script>
					    

		<div class="bg-primary" id="footer">
			<a class="navbar-brand" href="/about">About SwimPal</a>	
			<p>Developed by Sara Roepe</p>
		</div>
		
		<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
	    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
	    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
	</body>
</html>