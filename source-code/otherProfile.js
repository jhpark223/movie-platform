document.addEventListener('DOMContentLoaded', function() {
    var queryString = window.location.search;
    var urlParams = new URLSearchParams(queryString);
    var nickname = urlParams.get('nickname'); // Getting the 'nickname' parameter to show other users profile

    fetchUserInfo(nickname);
    fetchUserMovies(nickname);
});

// Fetch and display information of a user based on their nickname
function fetchUserInfo(nickname) {
    fetch('getOtherInfo.jsp?nickname=' + encodeURIComponent(nickname))
        .then(response => response.json())
        .then(data => {
            document.getElementById('nickname').textContent = 'Nickname: ' + data.nickname;
            document.getElementById('phone').textContent = 'Phone Number: ' + data.phone;
        })
        .catch(error => {
            console.error('Error:', error);
        });
}

// Fetch and display movies added by another user
function fetchUserMovies(nickname) {
    fetch('getOtherMovies.jsp?nickname=' + encodeURIComponent(nickname))
        .then(response => response.json())
        .then(data => {
            var moviesHtml = '<div class="movies-grid">';
            data.forEach(function(movie) {  // Loop through each movie and create HTML content
                var starsHtml = getStarsHtml(movie.rating); 
                moviesHtml += '<div class="movie-card">' +
                                  '<div class="movie-content">' +
                                      '<h4 class="movie-title">' + movie.movieTitle + '</h4>' +
                                      '<div class="movie-rating">' + starsHtml + '</div>' + 
                                      '<p class="movie-review"><Review> ' + movie.review + '</p>' +
                                  '</div>' +
                              '</div>';
            });
            moviesHtml += '</div>';
            document.getElementById('user-movies').innerHTML += moviesHtml;
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

