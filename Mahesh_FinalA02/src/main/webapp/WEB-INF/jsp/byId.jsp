<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" 
  rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">

<title>Movies By ID</title>
<link rel="stylesheet" type="text/css" href="/css/movieByCategory.css">
</head>
<body>
		<nav class="navbar navbar-expand-lg bg-body-tertiary">
  <div class="container-fluid">
    <div class="collapse navbar-collapse justify-content-center" id="navbarNavAltMarkup">
      <div class="navbar-nav">
        <a class="nav-link" href="/">Home</a>
        <a class="nav-link" href="/addmovie">Add Movie</a>
        <a class="nav-link" href="/viewallmovies">All Movies</a>
        <a class="nav-link active" aria-current="page" href="/viewmoviebyid">By Id</a>
        <a class="nav-link" href="/viewmoviebycategory">By Category</a>
        <a class="nav-link" href="/viewmoviesbylanguage">By Language</a>
        <a class="nav-link" href="/viewmoviebyscreename">By Screen Name</a>
        <a class="nav-link" href="/contactus">Contact Us</a>
      </div>
    </div>
  </div>
</nav>

<br><br>
	<form action="/viewmoviebyid" method="get">
	    <div class="button-container">
            <c:forEach var="id1" items="${movieIds}" varStatus="loopStatus">
                <button class="movie-button ${param.id == id1 || (param.id == null && loopStatus.index == 0) ? 'active' : ''}" name="id" value="${id1}">
                    ${id1}
                </button>
            </c:forEach>
        </div>
</form>
<br>
	<table class="movie-table">
<c:choose>
		<c:when test="${empty movies }">
			<tr>
				<td colspan="2">No Movies found</td>
			</tr> 
		</c:when>
		<c:otherwise>
	<thead>
		<tr>
				<th>Movie Image</th>
				<th>Movie Name</th>
				<th>Movie Category</th>
				<th>Movie Language</th>
				<th>Screen Name</th>
				<th>Movie Description</th>
				<th>Price</th>
			</tr>
	</thead>
	<tbody>
			<c:forEach var="movie" items="${movies }">
				<tr>
						<td><img alt="image" src="data:image/jpeg;base64,${movie.encodedImage}" style="width: 170px; height:110px"/></td>
	                   	<td>${movie.moviename}</td>
	                   	<td>${movie.movieCategory}</td>
	                   	<td>${movie.movieLanguage}</td>
	                   	<td>${movie.screenName}</td>
	                   	<td>${movie.movieDescription}</td>
	                   	<td>&#36 ${movie.price}</td>
				</tr>
			</c:forEach>
		</c:otherwise>
		</c:choose>
	</tbody>
</table>
</body>
</html>