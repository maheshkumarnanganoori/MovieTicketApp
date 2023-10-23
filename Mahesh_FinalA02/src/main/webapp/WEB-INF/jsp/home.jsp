<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" 
  rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">

<title>Home</title>
<link rel="stylesheet" type="text/css" href="/css/allmovies.css">
<style>
.nav-link.active {
    font-weight: bold;
     text-decoration: underline;
}
</style>
</head>
<body>
		<nav class="navbar navbar-expand-lg bg-body-tertiary">
<!-- 		<nav class="navbar bg-dark border-bottom border-body" data-bs-theme="dark"> -->
<!-- 		<nav class="navbar"> -->
		  <div class="container-fluid">
		    <div class="collapse navbar-collapse justify-content-center" id="navbarNavAltMarkup">
		      <div class="navbar-nav">
		        <a class="nav-link active" aria-current="page" href="/">Home</a>
		        <a class="nav-link" aria-current="page" href="/addmovie">Add Movie</a>
		        <a class="nav-link" href="/viewallmovies">All Movies</a>
		        <a class="nav-link" href="/viewmoviebyid">By Id</a>
		        <a class="nav-link" href="/viewmoviebycategory">By Category</a>
		        <a class="nav-link" href="/viewmoviesbylanguage">By Language</a>
		        <a class="nav-link" href="/viewmoviebyscreename">By Screen Name</a>
		        <a class="nav-link" href="/contactus">Contact Us</a>
		      </div>
		    </div>
		  </div>
		</nav>
		<br><br>

		<table class="movie-table ${empty responseList ? 'center-table' : ''}">
			<c:choose>
				<c:when test="${empty responseList }">
					<tr>
						<td colspan="2">No Movies Found</td>
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
		            <th>Select</th>
		        </tr>
		    </thead>
		    <tbody>
		        <c:forEach var="movie" items="${responseList}">
		            <tr>
		            	
		                <td><img alt="image" src="data:image/jpeg;base64,${movie.encodedImage}" style="width: 170px; height: 110px" /></td>
		                <td>${movie.moviename}</td>
		                <td>${movie.movieCategory}</td>
		                <td>${movie.movieLanguage}</td>
		                <td>${movie.screenName}</td>
		                <td>${movie.movieDescription}</td>
		                <td>&#36 ${movie.price}</td>
		                <td>
		                    <input type="checkbox" class="movie-checkbox" data-movie-id="${movie.id}" />
		                </td>
		            </tr>
		            <tr class="movie-details" style="display: none;">
		                <td colspan="8">
		                    <div class="details-container">
		                         <p><strong>Movie Name:</strong> ${movie.moviename}</p>
		                        <p><strong>Movie Category:</strong> ${movie.movieCategory}</p>
		                        <p><strong>Movie Language:</strong> ${movie.movieLanguage}</p>
		                        <p><strong>Screen Name:</strong> ${movie.screenName}</p>
		                        <p><strong>Movie Description:</strong> ${movie.movieDescription}</p>
		                        <p><strong>Price:</strong><span id="movie-price"> $${movie.price}</span></p>	
		                        	<div>
									    <input type="number" id="quantity" value="1" min="1">
									    <button id="increment">+</button>
										<button id="decrement">-</button>
										Total Price: <span id="calculated-price">$${movie.price }</span>
									</div>   
									<div>
		                                <button id="make-payment">Make Payment</button>
		                            </div> 
		                    </div>
		                </td>
		            </tr>
		        </c:forEach>
		        </c:otherwise>
		        </c:choose>
		    </tbody>
		</table>
		<script>
        document.addEventListener('DOMContentLoaded', function () {
        	const checkboxes = document.querySelectorAll('.movie-checkbox');
            let lastCheckedIndex = -1;

	        const prices = [];
            checkboxes.forEach(function (checkbox, index) {
                checkbox.addEventListener('change', function () {
                    const detailsDiv = document.querySelectorAll('.movie-details')[index];
                    if (this.checked) {
                        if (lastCheckedIndex >= 0) {
                            checkboxes[lastCheckedIndex].checked = false;
                            document.querySelectorAll('.movie-details')[lastCheckedIndex].style.display = 'none';
                        }
                        lastCheckedIndex = index;
                        detailsDiv.style.display = 'table-row';
                        
                    } else {
                        detailsDiv.style.display = 'none';
                        lastCheckedIndex = -1;
                    }
                });
            });
            const incrementButtons = document.querySelectorAll("#increment");
            const decrementButtons = document.querySelectorAll("#decrement");
            const textFields = document.querySelectorAll("#quantity");
            const calculatedPriceElements = document.querySelectorAll("#calculated-price");
            
            const paymentBTN = document.querySelectorAll('#make-payment');
            
            incrementButtons.forEach((incrementButton, index) => {
                incrementButton.addEventListener('click', function () {
                	const detailsDiv = document.querySelectorAll('.movie-details')[index];
                    let count = parseInt(textFields[index].value);
                    count++;
                    textFields[index].value = count;
                    const priceElement = detailsDiv.querySelector('#movie-price');
                 const priceText = priceElement.textContent;
                  const price = parseFloat(priceText.replace(/[^0-9.]/g, ''));
                    prices[index] = price;
                    console.log("price value in increment"+price);
                    console.log("count value in increment"+count);
                    updateCalculatedPrice(index,count, price);
                });
            });

            decrementButtons.forEach((decrementButton, index) => {
                decrementButton.addEventListener('click', function () {
                	const detailsDiv = document.querySelectorAll('.movie-details')[index];
                    let count = parseInt(textFields[index].value);
                    if (count > 1) {
                        count--;
                        textFields[index].value = count;
                        const priceElement = detailsDiv.querySelector('#movie-price');
                        const priceText = priceElement.textContent;
                         const price = parseFloat(priceText.replace(/[^0-9.]/g, ''));
                        prices[index] = price;
                        console.log("price value in decrement"+price);
                        console.log("count value in decrement"+count);
                        updateCalculatedPrice(index,count, price);
                    }
                });
            });
            
            
            paymentBTN.forEach((paymentBt, index) => {
            	paymentBt.addEventListener('click', function(){
            		confirm("Thank you..., Payment Successfull");
            		window.location.reload();

            	});
            });
           
            
            function updateCalculatedPrice(index,count, price) {
            	const calculatedPrice = (count*price).toFixed(2);
                console.log(calculatedPrice);
                calculatedPriceElements[index].textContent = '$' + calculatedPrice;
            }
        });
    </script>
</body>
</html>