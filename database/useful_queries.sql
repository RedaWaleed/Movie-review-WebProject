-- Useful Queries for Movie Review Database
-- Common queries you'll need for your movie review website

USE movie_review_db;

-- ============================================
-- MOVIE QUERIES
-- ============================================

-- Get all movies with their average ratings and review counts
SELECT 
    m.movie_id,
    m.title,
    m.release_date,
    m.runtime,
    m.average_rating,
    m.total_reviews,
    m.poster_url,
    GROUP_CONCAT(DISTINCT g.genre_name ORDER BY g.genre_name SEPARATOR ', ') AS genres
FROM movies m
LEFT JOIN movie_genres mg ON m.movie_id = mg.movie_id
LEFT JOIN genres g ON mg.genre_id = g.genre_id
GROUP BY m.movie_id
ORDER BY m.average_rating DESC;

-- Get top rated movies (minimum 5 reviews)
SELECT 
    m.movie_id,
    m.title,
    m.average_rating,
    m.total_reviews,
    m.release_date
FROM movies m
WHERE m.total_reviews >= 5
ORDER BY m.average_rating DESC, m.total_reviews DESC
LIMIT 10;

-- Get recently released movies
SELECT 
    m.movie_id,
    m.title,
    m.release_date,
    m.average_rating,
    m.total_reviews
FROM movies m
WHERE m.release_date <= CURDATE()
ORDER BY m.release_date DESC
LIMIT 20;

-- Get upcoming movies
SELECT 
    m.movie_id,
    m.title,
    m.release_date,
    m.tagline
FROM movies m
WHERE m.release_date > CURDATE()
ORDER BY m.release_date ASC;

-- Search movies by title
SELECT 
    m.movie_id,
    m.title,
    m.release_date,
    m.average_rating
FROM movies m
WHERE m.title LIKE '%search_term%'
ORDER BY m.average_rating DESC;

-- Get movies by genre
SELECT 
    m.movie_id,
    m.title,
    m.release_date,
    m.average_rating,
    m.total_reviews
FROM movies m
JOIN movie_genres mg ON m.movie_id = mg.movie_id
JOIN genres g ON mg.genre_id = g.genre_id
WHERE g.genre_name = 'Action'
ORDER BY m.average_rating DESC;

-- Get movie details with full information
SELECT 
    m.*,
    GROUP_CONCAT(DISTINCT g.genre_name ORDER BY g.genre_name SEPARATOR ', ') AS genres,
    GROUP_CONCAT(DISTINCT pc.company_name ORDER BY pc.company_name SEPARATOR ', ') AS production_companies
FROM movies m
LEFT JOIN movie_genres mg ON m.movie_id = mg.movie_id
LEFT JOIN genres g ON mg.genre_id = g.genre_id
LEFT JOIN movie_production_companies mpc ON m.movie_id = mpc.movie_id
LEFT JOIN production_companies pc ON mpc.company_id = pc.company_id
WHERE m.movie_id = 1
GROUP BY m.movie_id;

-- ============================================
-- CAST & CREW QUERIES
-- ============================================

-- Get cast for a specific movie
SELECT 
    p.person_id,
    p.name,
    mc.character_name,
    mc.cast_order,
    p.profile_picture
FROM movie_cast mc
JOIN people p ON mc.person_id = p.person_id
WHERE mc.movie_id = 1
ORDER BY mc.cast_order;

-- Get crew for a specific movie
SELECT 
    p.person_id,
    p.name,
    mcr.job_title,
    mcr.department
FROM movie_crew mcr
JOIN people p ON mcr.person_id = p.person_id
WHERE mcr.movie_id = 1
ORDER BY mcr.department, mcr.job_title;

-- Get all movies by a specific actor
SELECT 
    m.movie_id,
    m.title,
    m.release_date,
    mc.character_name,
    m.average_rating
FROM movies m
JOIN movie_cast mc ON m.movie_id = mc.movie_id
WHERE mc.person_id = 2
ORDER BY m.release_date DESC;

-- Get all movies directed by a specific person
SELECT 
    m.movie_id,
    m.title,
    m.release_date,
    m.average_rating
FROM movies m
JOIN movie_crew mcr ON m.movie_id = mcr.movie_id
WHERE mcr.person_id = 1 AND mcr.job_title = 'Director'
ORDER BY m.release_date DESC;

-- ============================================
-- REVIEW QUERIES
-- ============================================

-- Get all reviews for a specific movie
SELECT 
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
WHERE r.movie_id = 1 AND r.status = 'published'
ORDER BY r.helpful_count DESC, r.created_at DESC;

-- Get reviews by a specific user
SELECT 
    r.review_id,
    r.rating,
    r.title AS review_title,
    r.review_text,
    r.created_at,
    m.movie_id,
    m.title AS movie_title,
    m.poster_url
FROM reviews r
JOIN movies m ON r.movie_id = m.movie_id
WHERE r.user_id = 1 AND r.status = 'published'
ORDER BY r.created_at DESC;

-- Get most helpful reviews (across all movies)
SELECT 
    r.review_id,
    r.rating,
    r.title AS review_title,
    r.helpful_count,
    r.created_at,
    u.username,
    m.title AS movie_title
FROM reviews r
JOIN users u ON r.user_id = u.user_id
JOIN movies m ON r.movie_id = m.movie_id
WHERE r.status = 'published'
ORDER BY r.helpful_count DESC
LIMIT 10;

-- Get recent reviews from users you follow
SELECT 
    r.review_id,
    r.rating,
    r.title AS review_title,
    r.review_text,
    r.created_at,
    u.username,
    m.title AS movie_title,
    m.poster_url
FROM reviews r
JOIN users u ON r.user_id = u.user_id
JOIN movies m ON r.movie_id = m.movie_id
JOIN user_followers uf ON r.user_id = uf.following_id
WHERE uf.follower_id = 1 AND r.status = 'published'
ORDER BY r.created_at DESC
LIMIT 20;

-- Check if user has already reviewed a movie
SELECT COUNT(*) as has_reviewed
FROM reviews
WHERE user_id = 1 AND movie_id = 1;

-- Get rating distribution for a movie
SELECT 
    FLOOR(rating) as rating_value,
    COUNT(*) as count
FROM reviews
WHERE movie_id = 1 AND status = 'published'
GROUP BY FLOOR(rating)
ORDER BY rating_value DESC;

-- ============================================
-- USER QUERIES
-- ============================================

-- Get user profile with statistics
SELECT 
    u.user_id,
    u.username,
    u.first_name,
    u.last_name,
    u.bio,
    u.profile_picture,
    u.date_joined,
    u.role,
    COUNT(DISTINCT r.review_id) as total_reviews,
    COUNT(DISTINCT f.favorite_id) as total_favorites,
    COUNT(DISTINCT w.watchlist_id) as watchlist_count,
    (SELECT COUNT(*) FROM user_followers WHERE following_id = u.user_id) as followers_count,
    (SELECT COUNT(*) FROM user_followers WHERE follower_id = u.user_id) as following_count
FROM users u
LEFT JOIN reviews r ON u.user_id = r.user_id AND r.status = 'published'
LEFT JOIN favorites f ON u.user_id = f.user_id
LEFT JOIN watchlist w ON u.user_id = w.user_id
WHERE u.user_id = 1
GROUP BY u.user_id;

-- Get user's watchlist
SELECT 
    w.watchlist_id,
    w.priority,
    w.notes,
    w.added_at,
    m.movie_id,
    m.title,
    m.release_date,
    m.poster_url,
    m.average_rating
FROM watchlist w
JOIN movies m ON w.movie_id = m.movie_id
WHERE w.user_id = 1
ORDER BY w.priority DESC, w.added_at DESC;

-- Get user's favorite movies
SELECT 
    f.favorite_id,
    f.added_at,
    m.movie_id,
    m.title,
    m.release_date,
    m.poster_url,
    m.average_rating
FROM favorites f
JOIN movies m ON f.movie_id = m.movie_id
WHERE f.user_id = 1
ORDER BY f.added_at DESC;

-- Get users that a specific user is following
SELECT 
    u.user_id,
    u.username,
    u.profile_picture,
    u.bio,
    uf.followed_at,
    COUNT(DISTINCT r.review_id) as review_count
FROM user_followers uf
JOIN users u ON uf.following_id = u.user_id
LEFT JOIN reviews r ON u.user_id = r.user_id AND r.status = 'published'
WHERE uf.follower_id = 1
GROUP BY u.user_id
ORDER BY uf.followed_at DESC;

-- Get user's followers
SELECT 
    u.user_id,
    u.username,
    u.profile_picture,
    u.bio,
    uf.followed_at
FROM user_followers uf
JOIN users u ON uf.follower_id = u.user_id
WHERE uf.following_id = 1
ORDER BY uf.followed_at DESC;

-- ============================================
-- STREAMING & AVAILABILITY QUERIES
-- ============================================

-- Get streaming platforms for a specific movie
SELECT 
    sp.platform_id,
    sp.platform_name,
    sp.logo_url,
    ms.available_from,
    ms.available_until,
    ms.streaming_url
FROM movie_streaming ms
JOIN streaming_platforms sp ON ms.platform_id = sp.platform_id
WHERE ms.movie_id = 1
AND (ms.available_until IS NULL OR ms.available_until >= CURDATE());

-- ============================================
-- STATISTICS & ANALYTICS QUERIES
-- ============================================

-- Get most popular genres (by number of movies)
SELECT 
    g.genre_name,
    COUNT(mg.movie_id) as movie_count,
    AVG(m.average_rating) as avg_genre_rating
FROM genres g
LEFT JOIN movie_genres mg ON g.genre_id = mg.genre_id
LEFT JOIN movies m ON mg.movie_id = m.movie_id
GROUP BY g.genre_id
ORDER BY movie_count DESC;

-- Get most active reviewers
SELECT 
    u.user_id,
    u.username,
    u.profile_picture,
    COUNT(r.review_id) as review_count,
    AVG(r.rating) as avg_rating_given,
    SUM(r.helpful_count) as total_helpful_votes
FROM users u
JOIN reviews r ON u.user_id = r.user_id
WHERE r.status = 'published'
GROUP BY u.user_id
ORDER BY review_count DESC
LIMIT 10;

-- Get trending movies (most reviewed in last 30 days)
SELECT 
    m.movie_id,
    m.title,
    m.poster_url,
    m.average_rating,
    COUNT(r.review_id) as recent_reviews
FROM movies m
JOIN reviews r ON m.movie_id = r.movie_id
WHERE r.created_at >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
AND r.status = 'published'
GROUP BY m.movie_id
ORDER BY recent_reviews DESC
LIMIT 10;

-- Get movies similar to a specific movie (based on shared genres)
SELECT 
    m2.movie_id,
    m2.title,
    m2.poster_url,
    m2.average_rating,
    COUNT(DISTINCT mg2.genre_id) as shared_genres
FROM movies m1
JOIN movie_genres mg1 ON m1.movie_id = mg1.movie_id
JOIN movie_genres mg2 ON mg1.genre_id = mg2.genre_id
JOIN movies m2 ON mg2.movie_id = m2.movie_id
WHERE m1.movie_id = 1 
AND m2.movie_id != 1
GROUP BY m2.movie_id
ORDER BY shared_genres DESC, m2.average_rating DESC
LIMIT 5;

-- ============================================
-- ADMIN QUERIES
-- ============================================

-- Get flagged reviews for moderation
SELECT 
    r.review_id,
    r.title,
    r.review_text,
    r.created_at,
    u.username,
    m.title as movie_title
FROM reviews r
JOIN users u ON r.user_id = u.user_id
JOIN movies m ON r.movie_id = m.movie_id
WHERE r.status = 'flagged'
ORDER BY r.created_at DESC;

-- Get database statistics
SELECT 
    (SELECT COUNT(*) FROM users WHERE is_active = TRUE) as total_users,
    (SELECT COUNT(*) FROM movies) as total_movies,
    (SELECT COUNT(*) FROM reviews WHERE status = 'published') as total_reviews,
    (SELECT COUNT(*) FROM people) as total_people,
    (SELECT COUNT(*) FROM genres) as total_genres;
