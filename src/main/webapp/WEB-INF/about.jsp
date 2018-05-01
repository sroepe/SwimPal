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
		<link rel="stylesheet" type="text/css" href="/css/style.css">
		<link rel="shortcut icon" href="/images/swimblack.ico">
		<title>About SwimPal</title>
	</head>
	<body>
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
		 	<img src="/images/watchWhite.png">  <fmt:formatDate pattern="h:mm a"  value="${now}" /></p>
		    <a class="navbar-brand" href="/">Home</a>
		    <a class="navbar-brand" href="/pools">Seattle Pools</a>
  			<c:if test="${sessionAttribute != 'noLoggedUser'}">
	  			<a class="navbar-brand" href="/mySwims">My Swims</a>
  				<div class="logged">
		  			<p class="navbar-brand">Hello <c:out value="${sessionAttribute.firstName}"></c:out>!</p>
		  			<p><a class="navbar-brand-sm" href="/logout">Logout</a><p>
	  			</div>
			</c:if>
		</nav>
		<div class="container-fluid" id="about">
			<h1>About SwimPal</h1>
			<div id="aboutText">
				<p>The inspiration for SwimPal came after I took up swimming a few months ago and found that I could not easily and quickly determine which pool had an open swim available. I would have to visit each pool's website, then search through the schedule to determine where and when I could swim.  I wanted to be able to look at a map and see where I could go swim at the current time.   </p>
				<h4>Credits</h4>
				<p>Swim and Clock Icons Provided By: <a href="https://icons8.com">Icon pack by Icons8</a></p>
				<p>Header Pool Image Provided By: <a href="https://pixabay.com/en/swimming-pool-water-blue-athlete-924895/">Pixabay</a></p>
			</div>
		</div>
	</body>
</html>