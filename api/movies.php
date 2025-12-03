<?php
/**
 * Movie API Endpoints
 * Handles all movie-related requests
 */

header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');

require_once '../config/database.php';

// Get request method and action
$method = $_SERVER['REQUEST_METHOD'];
$action = isset($_GET['action']) ? $_GET['action'] : '';

$pdo = getDBConnection();

// Route requests
switch ($action) {
    case 'search':
        searchMovies($pdo);
        break;
    case 'get_all':
        getAllMovies($pdo);
        break;
    case 'get_movie':
        getMovieById($pdo);
        break;
    case 'get_popular':
        getPopularMovies($pdo);
        break;
    case 'get_trending':
        getTrendingMovies($pdo);
        break;
    case 'get_reviews':
        getMovieReviews($pdo);
        break;
    default:
        echo json_encode(['error' => 'Invalid action']);
        break;
}

/**
 * Search movies by title
 */
function searchMovies($pdo) {
    $searchTerm = isset($_GET['q']) ? $_GET['q'] : '';
    
    if (empty($searchTerm)) {
        echo json_encode(['error' => 'Search term is required']);
        return;
    }
    
    try {
        $sql = "SELECT 
                    m.movie_id,
                    m.title,
                    m.release_date,
                    m.runtime,
                    m.plot_summary,
                    m.tagline,
                    m.poster_url,
                    m.average_rating,
                    m.total_reviews,
                    m.rating as mpaa_rating,
                    GROUP_CONCAT(DISTINCT g.genre_name ORDER BY g.genre_name SEPARATOR ', ') AS genres
                FROM movies m
                LEFT JOIN movie_genres mg ON m.movie_id = mg.movie_id
                LEFT JOIN genres g ON mg.genre_id = g.genre_id
                WHERE m.title LIKE :search
                GROUP BY m.movie_id
                ORDER BY m.average_rating DESC, m.total_reviews DESC
                LIMIT 20";
        
        $stmt = $pdo->prepare($sql);
        $stmt->execute(['search' => '%' . $searchTerm . '%']);
        $movies = $stmt->fetchAll();
        
        echo json_encode([
            'success' => true,
            'count' => count($movies),
            'movies' => $movies
        ]);
    } catch (PDOException $e) {
        echo json_encode(['error' => $e->getMessage()]);
    }
}

/**
 * Get all movies
 */
function getAllMovies($pdo) {
    try {
        $sql = "SELECT 
                    m.movie_id,
                    m.title,
                    m.release_date,
                    m.runtime,
                    m.plot_summary,
                    m.tagline,
                    m.poster_url,
                    m.average_rating,
                    m.total_reviews,
                    m.rating as mpaa_rating,
                    GROUP_CONCAT(DISTINCT g.genre_name ORDER BY g.genre_name SEPARATOR ', ') AS genres
                FROM movies m
                LEFT JOIN movie_genres mg ON m.movie_id = mg.movie_id
                LEFT JOIN genres g ON mg.genre_id = g.genre_id
                GROUP BY m.movie_id
                ORDER BY m.release_date DESC
                LIMIT 50";
        
        $stmt = $pdo->query($sql);
        $movies = $stmt->fetchAll();
        
        echo json_encode([
            'success' => true,
            'count' => count($movies),
            'movies' => $movies
        ]);
    } catch (PDOException $e) {
        echo json_encode(['error' => $e->getMessage()]);
    }
}

/**
 * Get movie by ID with full details
 */
function getMovieById($pdo) {
    $movieId = isset($_GET['id']) ? intval($_GET['id']) : 0;
    
    if ($movieId <= 0) {
        echo json_encode(['error' => 'Valid movie ID is required']);
        return;
    }
    
    try {
        // Get movie details
        $sql = "SELECT 
                    m.*,
                    GROUP_CONCAT(DISTINCT g.genre_name ORDER BY g.genre_name SEPARATOR ', ') AS genres
                FROM movies m
                LEFT JOIN movie_genres mg ON m.movie_id = mg.movie_id
                LEFT JOIN genres g ON mg.genre_id = g.genre_id
                WHERE m.movie_id = :id
                GROUP BY m.movie_id";
        
        $stmt = $pdo->prepare($sql);
        $stmt->execute(['id' => $movieId]);
        $movie = $stmt->fetch();
        
        if (!$movie) {
            echo json_encode(['error' => 'Movie not found']);
            return;
        }
        
        // Get cast
        $castSql = "SELECT p.name, mc.character_name, mc.cast_order
                    FROM movie_cast mc
                    JOIN people p ON mc.person_id = p.person_id
                    WHERE mc.movie_id = :id
                    ORDER BY mc.cast_order
                    LIMIT 10";
        $stmt = $pdo->prepare($castSql);
        $stmt->execute(['id' => $movieId]);
        $movie['cast'] = $stmt->fetchAll();
        
        // Get crew
        $crewSql = "SELECT p.name, mcr.job_title, mcr.department
                    FROM movie_crew mcr
                    JOIN people p ON mcr.person_id = p.person_id
                    WHERE mcr.movie_id = :id
                    ORDER BY mcr.department";
        $stmt = $pdo->prepare($crewSql);
        $stmt->execute(['id' => $movieId]);
        $movie['crew'] = $stmt->fetchAll();
        
        echo json_encode([
            'success' => true,
            'movie' => $movie
        ]);
    } catch (PDOException $e) {
        echo json_encode(['error' => $e->getMessage()]);
    }
}

/**
 * Get popular movies (highest rated with minimum reviews)
 */
function getPopularMovies($pdo) {
    try {
        $sql = "SELECT 
                    m.movie_id,
                    m.title,
                    m.release_date,
                    m.poster_url,
                    m.average_rating,
                    m.total_reviews,
                    GROUP_CONCAT(DISTINCT g.genre_name ORDER BY g.genre_name SEPARATOR ', ') AS genres
                FROM movies m
                LEFT JOIN movie_genres mg ON m.movie_id = mg.movie_id
                LEFT JOIN genres g ON mg.genre_id = g.genre_id
                GROUP BY m.movie_id
                ORDER BY m.average_rating DESC, m.total_reviews DESC
                LIMIT 8";
        
        $stmt = $pdo->query($sql);
        $movies = $stmt->fetchAll();
        
        echo json_encode([
            'success' => true,
            'count' => count($movies),
            'movies' => $movies
        ]);
    } catch (PDOException $e) {
        echo json_encode(['error' => $e->getMessage()]);
    }
}

/**
 * Get trending movies (most reviewed in last 30 days)
 */
function getTrendingMovies($pdo) {
    try {
        $sql = "SELECT 
                    m.movie_id,
                    m.title,
                    m.release_date,
                    m.poster_url,
                    m.average_rating,
                    m.total_reviews,
                    COUNT(r.review_id) as recent_reviews,
                    GROUP_CONCAT(DISTINCT g.genre_name ORDER BY g.genre_name SEPARATOR ', ') AS genres
                FROM movies m
                LEFT JOIN reviews r ON m.movie_id = r.movie_id 
                    AND r.created_at >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
                    AND r.status = 'published'
                LEFT JOIN movie_genres mg ON m.movie_id = mg.movie_id
                LEFT JOIN genres g ON mg.genre_id = g.genre_id
                GROUP BY m.movie_id
                HAVING recent_reviews > 0
                ORDER BY recent_reviews DESC, m.average_rating DESC
                LIMIT 8";
        
        $stmt = $pdo->query($sql);
        $movies = $stmt->fetchAll();
        
        echo json_encode([
            'success' => true,
            'count' => count($movies),
            'movies' => $movies
        ]);
    } catch (PDOException $e) {
        echo json_encode(['error' => $e->getMessage()]);
    }
}

/**
 * Get reviews for a specific movie
 */
function getMovieReviews($pdo) {
    $movieId = isset($_GET['id']) ? intval($_GET['id']) : 0;
    
    if ($movieId <= 0) {
        echo json_encode(['error' => 'Valid movie ID is required']);
        return;
    }
    
    try {
        $sql = "SELECT 
                    r.review_id,
                    r.rating,
                    r.title AS review_title,
                    r.review_text,
                    r.is_spoiler,
                    r.helpful_count,
                    r.not_helpful_count,
                    r.created_at,
                    u.username,
                    u.profile_picture,
                    u.role
                FROM reviews r
                JOIN users u ON r.user_id = u.user_id
                WHERE r.movie_id = :id AND r.status = 'published'
                ORDER BY r.helpful_count DESC, r.created_at DESC
                LIMIT 20";
        
        $stmt = $pdo->prepare($sql);
        $stmt->execute(['id' => $movieId]);
        $reviews = $stmt->fetchAll();
        
        echo json_encode([
            'success' => true,
            'count' => count($reviews),
            'reviews' => $reviews
        ]);
    } catch (PDOException $e) {
        echo json_encode(['error' => $e->getMessage()]);
    }
}
?>
