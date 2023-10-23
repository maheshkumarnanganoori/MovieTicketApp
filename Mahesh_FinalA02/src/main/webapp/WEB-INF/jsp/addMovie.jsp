<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" 
  rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
<title>Register Movie</title>
<link rel="stylesheet" type="text/css" href="/css/home.css">
</head>
<body>
<nav class="navbar navbar-expand-lg bg-body-tertiary">
    <div class="collapse navbar-collapse justify-content-center" id="navbarNavAltMarkup">
      <div class="navbar-nav">
        <a class="nav-link" href="/">Home</a>
        <a class="nav-link active" aria-current="page" href="/addmovie">Add Movie</a>
        <a class="nav-link" href="/viewallmovies">All Movies</a>
        <a class="nav-link" href="/viewmoviebyid">By Id</a>
        <a class="nav-link" href="/viewmoviebycategory">By Category</a>
        <a class="nav-link" href="/viewmoviesbylanguage">By Language</a>
        <a class="nav-link" href="/viewmoviebyscreename">By Screen Name</a>
        <a class="nav-link" href="/contactus">Contact Us</a>
      </div>
    </div>
</nav>
<br>
<div id="successMessage" style="display: none; text-align: center; color: green; font-weight: bold;">
        Successfully inserted
    </div>
	<form id="movieForm" action="/insertmovie" method="post" enctype="multipart/form-data" onsubmit="showSuccessMessage()">
		<label for="moviename">Movie Name: </label>
		 <input type="text" name="moviename" id="moviename" required> <br> <br>
			<label for="movieCategory">Movie Category: </label> 
			<select id="movieCategory" name="movieCategory"required>
			<option value="default">Select a option</option>
				<option value="action">Action</option>
				<option value="drama">Drama</option>
				<option value="comedy">Comedy</option>
				<option value="crime">Crime</option>
			</select>
			<br> <br>
			<label for="language">Language: </label><br>
			<input type="radio" id="hindi" name="movieLanguage" value="Hindi" required>
			<label for="hindi">Hindi</label><br>
			<input type="radio" id="english" name="movieLanguage" value="English" required>
			<label for="english">English</label><br>
			<input type="radio" id="telugu" name="movieLanguage" value="Telugu" required>
			<label for="telugu">Telugu</label><br>
			<input type="radio" id="others" name="movieLanguage" value="Others"required>
			<label for="others">Others</label><br><br>
			
			<label for="screenName">ScreenName: </label>
			<input type="text" name="screenName" id="screenName" required>
			<br>
			<label for="movieDescription">Movie Description: </label>
			<input type="text" id ="movieDescription"name="movieDescription" required></input><br>
			
			<label for="price">Price :</label>
			<input type="text" name="price" id="price" required><br><br>

			<label for="movieImg">Movie Poster: </label>
			<input type="file" id="movieImg" name="movieImg"><br><br>
			
			
			<button type="submit" id="submit" value="register movie"> Register Movie</button>
	</form>
</body>
<script>
function showSuccessMessage() {
    document.getElementById("successMessage").style.display = "block";
    setTimeout(function () {
        document.getElementById("successMessage").style.display = "none";
    }, 100000);
    return false;
}
</script>

</html>