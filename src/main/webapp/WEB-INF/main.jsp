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
	<body>
		<div class="container-fluid" id="header">
			<a href="/"><h1 class="align-text-middle"><img src="images/swim_white.png">SwimPal</h1></a>
			<h5>Swim Seattle Pools Now</h5>
			
			
		</div>
		
		<nav class="navbar navbar-dark bg-primary">
			<p class="navbar-brand" id="curTime"> <c:set var = "now" value = "<%= new java.util.Date()%>" />
		 	<img src="images/watchWhite.png">  <fmt:formatDate pattern="h:mm a"  value="${now}" /></p>
			<form class="form-inline my-2 my-lg-0">
		      <input class="form-control mr-sm-1" type="select" placeholder="Select a later time" aria-label="Search">
		      <button class="btn btn-outline-light my-2 my-sm-0" type="submit">Swim Later</button>
		    </form>
		    <a class="navbar-brand" href="/pools">Seattle Pools</a>
  			<a class="navbar-brand" href="#">My Swims</a>
  			<!-- <a class="navbar-brand" href="/about">About</a>  move to footer -->
		</nav>
		<div class="container-fluid" id="panels">
  			<div class="row">
			    <div class="col-8" id="map">
					<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.21.0/moment.js"></script> -->
			    	
			    	<script>
						
						var markers = [];
				    	var poolLocations = [<c:forEach items="${pools}" var = "pool" >{
		                    coords: {lat:${pool.lat}, lng:${pool.lng}},
		                    iconImg:'https://png.icons8.com/metro/50/000000/swimming.png',
		                    iconYes: 'https://png.icons8.com/metro/50/0D9834/swimming.png',
		                    iconNo: 'https://png.icons8.com/metro/50/F31E1E/swimming.png',
							iconMaybe: 'https://png.icons8.com/metro/50/E9EF29/swimming.png',
		                    content: 	'<a href="/pools/${pool.id}"><h3>${pool.name}</h3></a>'+
		                    			'<p><a href="${pool.website}" target="_blank">${pool.website}</a><br>'+
		                    			'${pool.address} ${pool.city}, ${pool.state} ${pool.postcode}<br>'+
		                    			'${pool.phone}</p>'+
		                    			'<c:if test="${pool.openDate != null}"><span id="seasonal">Pool opens for the season <fmt:formatDate pattern="M/d/y"  value="${pool.openDate}"/></span></c:if>'+
		                    			'<c:forEach items="${schedulesNow}" var = "schedule">'+
		                    			'<c:if test="${pool.id == schedule.pool.id}">'+		                    			             			
		                    			'<h6>Swims Available Now</h6>'+
		                    			'<table><th>Swim Type</th><th>Time</th><th>Details</th>'+		                    			
		                    			'<tr><td>${schedule.swimType}</td><td><fmt:formatDate value="${schedule.start}" pattern="h:mm a"/> - '+
		                    			'<fmt:formatDate value="${schedule.end}" pattern="h:mm a"/></td><td><a href="">Show Details</a></td></tr>'+
		                    			'</c:if></c:forEach></table>'
		      				
											},
											</c:forEach>
						];
				    	var mapCenter = {lat: 47.607, lng: -122.339}; //seattle
	
				    	function initMap() {
				    	  var map = new google.maps.Map(document.getElementById('map'), {
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
					    	    
					    	    
					    	    if(poolLocation.content.includes("seasonal")){
									marker.setIcon(poolLocation.iconImg);
								} 
					    	    else if(poolLocation.content.includes("td")){
									//set custom icon green if swim times available
									marker.setIcon(poolLocation.iconYes);	
									}
								else{
									marker.setIcon(poolLocation.iconNo);
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
					    
			    </div>
			    <div class="col bg-primary">
			      	<p>${log}</p>
					<fieldset><legend>Login</legend>
					    <form method="POST" action="/login">
					    	<div class="form-row">
						    	<p>Email: <input class="form-control form-control-sm" type="text" id="email" name="email"/></p>
						        <p>Password: <input class="form-control form-control-sm" type="password" id="password" name="password"/></p>
							</div>
							<div class="form-row">
						        <p><button class="btn btn-outline-light my-2 my-sm-0" type="submit">Login</button></p>
					        </div>
					    </form>
				    </fieldset>
				    
				    <p>${reg}</p>
				    <fieldset><legend>Register</legend>
				    
					<form:form method="POST" action="/register" modelAttribute="user">
						
						<div class="form-row">
							<p> <form:label path="firstName"/>First Name:
								<form:errors path="firstName"/>
								<form:input class="form-control form-control-sm" type="text" path="firstName"/></p>
								
							<p>	<form:label path="lastName"/>Last Name:
								<form:errors path="lastName"/>
								<form:input class="form-control form-control-sm" type="text" path="lastName"/></p>
						</div>
						<div class="form-row">
					        <p> <form:label path="alias"/>Alias:
					            <form:errors path="alias"/>
					            <form:input class="form-control form-control-sm" type="text" path="alias"/></p>
					            
					        <p> <form:label path="email"/>Email:
					        	<form:errors path="email"/>
					            <form:input class="form-control form-control-sm" type="text" path="email"/></p>
					    </div>
						<div class="form-row">     
					        <p> <form:label path="password"/>Password:
								<form:errors path="password"/>
					            <form:input class="form-control form-control-sm" type="password" path="password"/></p>
			
					            
					        <p>  Confirm PW: <input class="form-control form-control-sm" type="password" name="confirmPassword"/></p>
					    </div>
					    <div class="form-row">
					        <p><button class="btn btn-outline-light my-2 my-sm-0" " type="submit">Register</button></p>
					        
				        </div>
				    </form:form>
				    </fieldset>
			    </div>

  			</div>
		</div>
		
		
		<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
	    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
	    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
	</body>
</html>