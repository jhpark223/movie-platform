document.addEventListener('DOMContentLoaded', function() {
    loadTrendingMovies();
    fetchUserMovies();

    // Set up search functionality for movies.
    var movieSearchInput = document.getElementById('movie-search');
    var movieSearchButton = document.getElementById('movie-search-btn');
    
    movieSearchInput.addEventListener('keypress', function(e) {
        if (e.key === 'Enter') {
            var searchTerm = movieSearchInput.value;
            searchMovies(searchTerm);
        }
    });

    movieSearchButton.addEventListener('click', function() {
        var searchTerm = movieSearchInput.value;
        searchMovies(searchTerm);
    });

    //Redirect to the page of the buttons
    var profileButton = document.getElementById('profile-btn');
    profileButton.addEventListener('click', function() {
        window.location.href = 'profile.html';
    });

    var aboutButton = document.getElementById('about-btn');
    aboutButton.addEventListener('click', function() {
            window.location.href = 'about.html';
    });

     var newsButton = document.getElementById('news-btn');
     newsButton.addEventListener('click', function() {
             window.location.href = 'news.html';
     });

    // Set up friend search functionality.
    var friendSearchInput = document.getElementById('friend-search');
    var friendSearchButton = document.getElementById('friend-search-btn');

    friendSearchInput.addEventListener('keypress', function(e) {
        if (e.key === 'Enter') {
            var nickname = friendSearchInput.value;
            searchUserByNickname(nickname);
        }
    });

    friendSearchButton.addEventListener('click', function() {
        var nickname = friendSearchInput.value;
        searchUserByNickname(nickname);
    });

    var homeButton = document.getElementById('home-btn');
    homeButton.addEventListener('click', function() {
        loadTrendingMovies();
        fetchUserMovies();
    });
});

var userReviewedMovies = [];

// Fetches movies reviewed by the user
function fetchUserMovies() {
    fetch('getUserMovies.jsp')
        .then(response => response.json())
        .then(data => {
            userReviewedMovies = data; 
            loadTrendingMovies();
        })
        .catch(error => console.error('Error:', error));
}

// Fetches and displays trending movies using The Movie Database(TMDB) API
function loadTrendingMovies() {
    var apiKey = '3f58bf20f15ffef77c4ff8e4849551ac';
    var url = 'https://api.themoviedb.org/3/trending/movie/week?api_key=' + apiKey;

    fetch(url)
        .then(response => response.json())
        .then(data => displayMovies(data.results, userReviewedMovies))
        .catch(error => console.error('Error:', error));
}

// Searches movies based on a search term using TMDB API
function searchMovies(searchTerm) {
    var apiKey = '3f58bf20f15ffef77c4ff8e4849551ac';
    var url = 'https://api.themoviedb.org/3/search/movie?api_key=' + apiKey + '&query=' + encodeURIComponent(searchTerm);

    fetch(url)
        .then(response => response.json())
        .then(data => displayMovies(data.results, userReviewedMovies))
        .catch(error => console.error('Error:', error));
}

// Adds event listeners to all 'Add Review' buttons
function setupAddReviewButtonListeners() {
    document.querySelectorAll('.add-review-btn').forEach(button => {
        button.addEventListener('click', function() {
            this.nextElementSibling.style.display = 'block'; 
            this.style.display = 'none';
        });
    });
}

// Displays a list of movies and review buttons
function displayMovies(movies, userMovies) {
    var moviesHtml = '';
    movies.forEach(function(movie) {
        var releaseYear = movie.release_date ? movie.release_date.split('-')[0] : 'Unknown';
        var isReviewed = userMovies.some(userMovie => userMovie.movieTitle === movie.title);
        var buttonHtml = isReviewed ? '<button class="added-review-btn" disabled>Added</button>' : '<button class="add-review-btn">Add</button>';
        // make movie card HTML
        moviesHtml += '<div class="movie-card">' +
                        '<img src="https://image.tmdb.org/t/p/w500' + movie.poster_path + '" alt="' + movie.title + '" class="movie-poster">' +
                        '<p class="movie-title">' + movie.title + ' (' + releaseYear + ')</p>' +
                        buttonHtml +
                        '<form action="submitReview.jsp" method="post" class="review-form" style="display: none;">' +
                          '<input type="hidden" name="movieId" value="' + movie.id + '">' +
                          '<input type="hidden" name="movieTitle" value="' + movie.title + '">' +
                          '<div class="rating-stars">' +
                          '<span class="star" data-value="1">&#9733;</span>' +
                          '<span class="star" data-value="2">&#9733;</span>' +
                          '<span class="star" data-value="3">&#9733;</span>' +
                          '<span class="star" data-value="4">&#9733;</span>' +
                          '<span class="star" data-value="5">&#9733;</span>' +
                        '</div>' +
                        '<input type="hidden" name="rating" value="">' +
                          '<textarea name="review" placeholder="Your Review"></textarea>' +
                          '<button type="submit">Submit Review</button>' +
                        '</form>' +
                      '</div>';
    });
    document.getElementById('search-results').innerHTML = moviesHtml;
    setupAddReviewButtonListeners();
    setupStarRatingListeners();
}

// Fetches and displays user information based on their nickname
function searchUserByNickname(nickname) {
    fetch('getUserNickname.jsp?nickname=' + encodeURIComponent(nickname))
        .then(response => response.json())
        .then(data => {
            displayUserSearchResult(data);
        })
        .catch(error => console.error('Error:', error));
}

// Displays user search results
function displayUserSearchResult(user) {
    var resultContainer = document.getElementById('search-results');
    var html = '<div class="user-info">' +
    '<p>Nickname: ' + user.nickname + '</p>' +
    '<p>Phone: ' + user.phone + '</p>' +
    '<button style="background-color: rgb(59, 94, 235);" onclick="redirectToUserProfile(\'' + user.nickname + '\')">View Profile</button>' +
    '</div>';
    resultContainer.innerHTML = html;
}

// Redirects to other user's profile page
function redirectToUserProfile(nickname) {
    window.location.href = 'otherProfile.html?nickname=' + encodeURIComponent(nickname);
}

// Setup event listeners for star rating in review forms
function setupStarRatingListeners() {
    document.querySelectorAll('.rating-stars').forEach(starContainer => {
        starContainer.querySelectorAll('.star').forEach(star => {
            star.addEventListener('mouseover', function() {
                fillStarsUpTo(star, starContainer);
            });

            star.addEventListener('mouseout', function() {
                clearStars(starContainer);
                fillStarsBasedOnSelected(starContainer);
            });

            star.addEventListener('click', function() {
                var rating = this.dataset.value;
                starContainer.nextSibling.value = rating; 

                starContainer.querySelectorAll('.star').forEach(s => {
                    if (s.dataset.value <= rating) {
                        s.classList.add('selected');
                    } else {
                        s.classList.remove('selected');
                    }
                });
            });
        });
    });
}

// Fills stars up to the selected one
function fillStarsUpTo(star, container) {
    container.querySelectorAll('.star').forEach(s => {
        s.classList[s.dataset.value <= star.dataset.value ? 'add' : 'remove']('selected');
    });
}

// Clears all star highlights
function clearStars(container) {
    container.querySelectorAll('.star').forEach(s => {
        s.classList.remove('selected');
    });
}

// Fills stars based on the selected rating
function fillStarsBasedOnSelected(container) {
    var selectedRating = container.nextSibling.value;
    if (selectedRating) {
        container.querySelectorAll('.star').forEach(s => {
            s.classList[s.dataset.value <= selectedRating ? 'add' : 'remove']('selected');
        });
    }
}
