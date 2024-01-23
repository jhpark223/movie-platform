document.addEventListener('DOMContentLoaded', function() { // Event listener for the home button
    var homeButton = document.getElementById('home-btn');
    homeButton.addEventListener('click', function() {
        window.location.href = 'loggedin.html';
    });
});

// Fetch and display user information
function fetchUserInfo() {
    fetch('getUserInfo.jsp')
        .then(response => response.json())
        .then(data => {
            document.getElementById('nickname').textContent = 'Nickname: ' + data.nickname;
            document.getElementById('phone').textContent = 'Phone Number: ' + data.phone;
        })
        .catch(error => {
            console.error('Error:', error);
        });
}

// Fetch and display movies added by the user
function fetchUserMovies() {
    fetch('getUserMovies.jsp')
        .then(response => response.json())
        .then(data => {
            var movieCount = data.length; 

            // Check if the user has added any movies and display a message to add movies if none are found
            if (movieCount === 0) {
                document.getElementById('user-movies').innerHTML = '<h2 style="color: rgb(59, 94, 235);">Add your movies!</h2>';
            } else {
                var gridStyle = 'repeat(3, 1fr)';  // Create a grid layout for displaying movies
                var moviesHtml = `<div class="movies-grid" style="grid-template-columns: ${gridStyle}">`;

                // Loop through each movie and create HTML content
                data.forEach(function(movie) {
                    var starsHtml = getStarsHtml(movie.rating);
                    moviesHtml += `<div class="movie-card">
                                      <div class="movie-content">
                                          <h4 class="movie-title">${movie.movieTitle}</h4>
                                          <div class="movie-rating">${starsHtml}</div>
                                          <p class="movie-review"><Review> ${movie.review}</p>
                                      </div>
                                  </div>`;
                });
                moviesHtml += '</div>';
                document.getElementById('user-movies').insertAdjacentHTML('beforeend', moviesHtml);
            }
        })
        .catch(error => {
            console.error('Error:', error);
            document.getElementById('user-movies').innerHTML = '<p>Error loading movies.</p>';
        });
}

// make HTML for star ratings
function getStarsHtml(rating) {
    var starsHtml = '';
    for (var i = 1; i <= 5; i++) {
        starsHtml += `<span class="star ${i <= rating ? 'selected' : ''}">&#9733;</span>`;
    }
    return starsHtml;
}

document.addEventListener('DOMContentLoaded', function() {
    fetchUserInfo();
    fetchUserMovies(); 
});

