/**
 * MovieHub - Main JavaScript
 * Handles search, movie loading, and modal interactions
 */

// API Base URL - Update this if your PHP files are in a different location
const API_BASE = 'api/movies.php';

// DOM Elements
const searchInput = document.getElementById('search-input');
const searchResults = document.getElementById('search-results');
const popularContent = document.getElementById('popular-content');
const trendingContent = document.getElementById('trending-content');
const allMoviesContent = document.getElementById('all-movies-content');
const movieModal = document.getElementById('movie-modal');
const modalBody = document.getElementById('modal-body');
const closeModal = document.querySelector('.close-modal');

// Search functionality
let searchTimeout;
searchInput.addEventListener('input', (e) => {
    const query = e.target.value.trim();
    
    // Clear previous timeout
    clearTimeout(searchTimeout);
    
    if (query.length < 2) {
        searchResults.classList.remove('active');
        return;
    }
    
    // Debounce search
    searchTimeout = setTimeout(() => {
        searchMovies(query);
    }, 300);
});

// Close search results when clicking outside
document.addEventListener('click', (e) => {
    if (!searchInput.contains(e.target) && !searchResults.contains(e.target)) {
        searchResults.classList.remove('active');
    }
});

/**
 * Search movies by query
 */
async function searchMovies(query) {
    try {
        const response = await fetch(`${API_BASE}?action=search&q=${encodeURIComponent(query)}`);
        const data = await response.json();
        
        if (data.success && data.movies.length > 0) {
            displaySearchResults(data.movies);
        } else {
            displayNoResults();
        }
    } catch (error) {
        console.error('Search error:', error);
        displayNoResults('Error searching movies');
    }
}

/**
 * Display search results
 */
function displaySearchResults(movies) {
    searchResults.innerHTML = movies.map(movie => `
        <div class="search-result-item" onclick="showMovieDetails(${movie.movie_id})">
            <img src="${movie.poster_url || 'img/movie-1.jpg'}" alt="${movie.title}">
            <div class="search-result-info">
                <h4>${movie.title}</h4>
                <p>${movie.release_date ? new Date(movie.release_date).getFullYear() : 'N/A'} • ${movie.genres || 'N/A'}</p>
                <p>⭐ ${movie.average_rating ? parseFloat(movie.average_rating).toFixed(1) : 'N/A'}/5</p>
            </div>
        </div>
    `).join('');
    
    searchResults.classList.add('active');
}

/**
 * Display no results message
 */
function displayNoResults(message = 'No movies found') {
    searchResults.innerHTML = `<div class="search-no-results">${message}</div>`;
    searchResults.classList.add('active');
}

/**
 * Load popular movies
 */
async function loadPopularMovies() {
    try {
        const response = await fetch(`${API_BASE}?action=get_popular`);
        const data = await response.json();
        
        if (data.success && data.movies.length > 0) {
            displayMovies(data.movies, popularContent);
        } else {
            popularContent.innerHTML = '<p class="loading-spinner">No popular movies found</p>';
        }
    } catch (error) {
        console.error('Error loading popular movies:', error);
        popularContent.innerHTML = '<p class="loading-spinner">Error loading movies</p>';
    }
}

/**
 * Load trending movies
 */
async function loadTrendingMovies() {
    try {
        const response = await fetch(`${API_BASE}?action=get_trending`);
        const data = await response.json();
        
        if (data.success && data.movies.length > 0) {
            displayMovies(data.movies, trendingContent);
        } else {
            // If no trending movies, show popular instead
            const popularResponse = await fetch(`${API_BASE}?action=get_popular`);
            const popularData = await popularResponse.json();
            if (popularData.success) {
                displayMovies(popularData.movies, trendingContent);
            }
        }
    } catch (error) {
        console.error('Error loading trending movies:', error);
        trendingContent.innerHTML = '<p class="loading-spinner">Error loading movies</p>';
    }
}

/**
 * Load all movies
 */
async function loadAllMovies() {
    try {
        const response = await fetch(`${API_BASE}?action=get_all`);
        const data = await response.json();
        
        if (data.success && data.movies.length > 0) {
            displayMovies(data.movies, allMoviesContent);
        } else {
            allMoviesContent.innerHTML = '<p class="loading-spinner">No movies found</p>';
        }
    } catch (error) {
        console.error('Error loading all movies:', error);
        allMoviesContent.innerHTML = '<p class="loading-spinner">Error loading movies</p>';
    }
}

/**
 * Display movies in a container
 */
function displayMovies(movies, container) {
    const moviesHTML = movies.map(movie => createMovieCard(movie)).join('');
    
    // Check if container has swiper-wrapper
    const wrapper = container.querySelector('.swiper-wrapper');
    if (wrapper) {
        wrapper.innerHTML = moviesHTML;
    } else {
        container.innerHTML = moviesHTML;
    }
}

/**
 * Create a movie card HTML
 */
function createMovieCard(movie) {
    const rating = movie.average_rating ? parseFloat(movie.average_rating).toFixed(1) : 'N/A';
    const year = movie.release_date ? new Date(movie.release_date).getFullYear() : 'N/A';
    
    return `
        <div class="movie-box" onclick="showMovieDetails(${movie.movie_id})">
            <img src="${movie.poster_url || 'img/movie-1.jpg'}" alt="${movie.title}">
            <div class="movie-box-overlay">
                <h3 class="movie-title">${movie.title}</h3>
                <div class="movie-info">
                    <span class="movie-rating">
                        <i class='bx bxs-star'></i>
                        ${rating}
                    </span>
                    <span>${year}</span>
                    <span>${movie.runtime ? movie.runtime + ' min' : ''}</span>
                </div>
            </div>
        </div>
    `;
}

/**
 * Show movie details in modal
 */
async function showMovieDetails(movieId) {
    try {
        // Show modal with loading state
        movieModal.classList.add('active');
        modalBody.innerHTML = '<div class="loading-spinner"><i class="bx bx-loader-alt bx-spin"></i><p>Loading movie details...</p></div>';
        
        // Fetch movie details
        const response = await fetch(`${API_BASE}?action=get_movie&id=${movieId}`);
        const data = await response.json();
        
        if (data.success && data.movie) {
            displayMovieDetails(data.movie);
            
            // Load reviews
            loadMovieReviews(movieId);
        } else {
            modalBody.innerHTML = '<p>Error loading movie details</p>';
        }
    } catch (error) {
        console.error('Error loading movie details:', error);
        modalBody.innerHTML = '<p>Error loading movie details</p>';
    }
}

/**
 * Display movie details in modal
 */
function displayMovieDetails(movie) {
    const rating = movie.average_rating ? parseFloat(movie.average_rating).toFixed(1) : 'N/A';
    const year = movie.release_date ? new Date(movie.release_date).getFullYear() : 'N/A';
    
    let castHTML = '';
    if (movie.cast && movie.cast.length > 0) {
        castHTML = `
            <div class="modal-section">
                <h3>Cast</h3>
                <div class="cast-list">
                    ${movie.cast.map(actor => `
                        <div class="cast-item">
                            <strong>${actor.name}</strong><br>
                            <span>${actor.character_name || 'Unknown Role'}</span>
                        </div>
                    `).join('')}
                </div>
            </div>
        `;
    }
    
    let crewHTML = '';
    if (movie.crew && movie.crew.length > 0) {
        crewHTML = `
            <div class="modal-section">
                <h3>Crew</h3>
                <div class="crew-list">
                    ${movie.crew.map(member => `
                        <div class="crew-item">
                            <strong>${member.name}</strong><br>
                            <span>${member.job_title || 'Unknown'}</span>
                        </div>
                    `).join('')}
                </div>
            </div>
        `;
    }
    
    modalBody.innerHTML = `
        <div class="modal-header">
            <img src="${movie.poster_url || 'img/movie-1.jpg'}" alt="${movie.title}" class="modal-poster">
            <div class="modal-info">
                <h2 class="modal-title">${movie.title}</h2>
                ${movie.tagline ? `<p class="modal-tagline">"${movie.tagline}"</p>` : ''}
                <div class="modal-meta">
                    <span><i class='bx bx-calendar'></i> ${year}</span>
                    <span><i class='bx bx-time'></i> ${movie.runtime ? movie.runtime + ' min' : 'N/A'}</span>
                    <span><i class='bx bx-category'></i> ${movie.genres || 'N/A'}</span>
                    ${movie.rating ? `<span><i class='bx bx-shield'></i> ${movie.rating}</span>` : ''}
                </div>
                <div class="modal-rating">
                    <i class='bx bxs-star'></i>
                    <span>${rating}/5</span>
                    <span style="color: #b7b7b7; font-size: 0.9rem;">(${movie.total_reviews || 0} reviews)</span>
                </div>
                ${movie.plot_summary ? `<p class="modal-plot">${movie.plot_summary}</p>` : ''}
            </div>
        </div>
        ${castHTML}
        ${crewHTML}
        <div class="reviews-section" id="reviews-section">
            <h3>Reviews</h3>
            <div class="loading-spinner"><i class="bx bx-loader-alt bx-spin"></i><p>Loading reviews...</p></div>
        </div>
    `;
}

/**
 * Load movie reviews
 */
async function loadMovieReviews(movieId) {
    try {
        const response = await fetch(`${API_BASE}?action=get_reviews&id=${movieId}`);
        const data = await response.json();
        
        const reviewsSection = document.getElementById('reviews-section');
        
        if (data.success && data.reviews.length > 0) {
            const reviewsHTML = data.reviews.map(review => `
                <div class="review-item">
                    <div class="review-header">
                        <span class="review-author">${review.username}</span>
                        <div class="review-rating">
                            <i class='bx bxs-star'></i>
                            <span>${parseFloat(review.rating).toFixed(1)}</span>
                        </div>
                    </div>
                    ${review.review_title ? `<h4 class="review-title">${review.review_title}</h4>` : ''}
                    <p class="review-text">${review.review_text}</p>
                    <div class="review-meta" style="margin-top: 0.5rem; font-size: 0.8rem; color: #b7b7b7;">
                        <span>${new Date(review.created_at).toLocaleDateString()}</span>
                        ${review.helpful_count > 0 ? `<span> • ${review.helpful_count} found helpful</span>` : ''}
                    </div>
                </div>
            `).join('');
            
            reviewsSection.innerHTML = `<h3>Reviews</h3>${reviewsHTML}`;
        } else {
            reviewsSection.innerHTML = '<h3>Reviews</h3><p style="color: #b7b7b7;">No reviews yet. Be the first to review!</p>';
        }
    } catch (error) {
        console.error('Error loading reviews:', error);
        const reviewsSection = document.getElementById('reviews-section');
        reviewsSection.innerHTML = '<h3>Reviews</h3><p style="color: #b7b7b7;">Error loading reviews</p>';
    }
}

/**
 * Close modal
 */
closeModal.addEventListener('click', () => {
    movieModal.classList.remove('active');
});

// Close modal when clicking outside
movieModal.addEventListener('click', (e) => {
    if (e.target === movieModal) {
        movieModal.classList.remove('active');
    }
});

// Close modal with Escape key
document.addEventListener('keydown', (e) => {
    if (e.key === 'Escape' && movieModal.classList.contains('active')) {
        movieModal.classList.remove('active');
    }
});

/**
 * Initialize the page
 */
function init() {
    // Load all movie sections
    loadPopularMovies();
    loadTrendingMovies();
    loadAllMovies();
    
    console.log('MovieHub initialized!');
}

// Run initialization when DOM is ready
if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', init);
} else {
    init();
}

// Make showMovieDetails available globally
window.showMovieDetails = showMovieDetails;
