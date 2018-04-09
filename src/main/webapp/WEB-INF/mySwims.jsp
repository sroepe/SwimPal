<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
		<link rel="stylesheet" type="text/css" href="css/style.css">
		<link rel="shortcut icon" href="images/swimblack.ico">
		<title>SwimPal - Pool List</title>
	</head>
	<body>
		<div class="container-fluid" id="header">
			<a href="/"><h1 class="align-text-middle"><img src="images/swim_white.png">SwimPal</h1></a>
			
			
		</div>
		
		<nav class="navbar navbar-dark bg-primary">
			<form class="form-inline my-2 my-lg-0">
		      <input class="form-control mr-sm-2" type="search" placeholder="Enter Zip Code" aria-label="Search">
		      <button class="btn btn-outline-light my-2 my-sm-0" type="submit">Swim Now!</button>
		    </form>
		    <a class="navbar-brand" href="/">Home</a>
  			<a class="navbar-brand" href="/mySwims">My Swims</a>
  			<a class="navbar-brand" href="/pools">Seattle Pools</a>
  			<a class="navbar-brand" href="">Resources</a>
  			<a class="navbar-brand" href="/about">About</a>
		</nav>
		<div id="poolList">
			<h1>My Swims</h1>
<%-- 		    <table class="table table-hover table-dark">
		    	<tr>
			    	<th>Pool Name</th>
			    	<th>Address</th>
			    	<th>Phone</th>
			    	
			    </tr>
			    <c:forEach items="${pools}" var = "pool">
			    	<tr>
			    		<td><a href="/pools/${pool.id}">${pool.name}</a></td>
			    		<td>${pool.address}, ${pool.city}, ${pool.state} ${pool.postcode}</td>
			    		<td>${pool.phone}</td>
			    	
			    	</tr>
			    </c:forEach>
			  </table> --%>

		</div>
		
		<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
	    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
	    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
	</body>
</html>