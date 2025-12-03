-- Movie Review Website Database Schema
-- Created: 2025-12-03

-- Drop existing database if exists and create new one
DROP DATABASE IF EXISTS movie_review_db;
CREATE DATABASE movie_review_db;
USE movie_review_db;

-- ============================================
-- USERS TABLE
-- ============================================
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    profile_picture VARCHAR(255),
    bio TEXT,
    date_joined DATETIME DEFAULT CURRENT_TIMESTAMP,
    last_login DATETIME,
    is_active BOOLEAN DEFAULT TRUE,
    is_verified BOOLEAN DEFAULT FALSE,
    role ENUM('user', 'critic', 'admin') DEFAULT 'user',
    INDEX idx_username (username),
    INDEX idx_email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- MOVIES TABLE
-- ============================================
CREATE TABLE movies (
    movie_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    original_title VARCHAR(255),
    release_date DATE,
    runtime INT COMMENT 'Runtime in minutes',
    plot_summary TEXT,
    tagline VARCHAR(255),
    poster_url VARCHAR(255),
    backdrop_url VARCHAR(255),
    trailer_url VARCHAR(255),
    imdb_id VARCHAR(20),
    tmdb_id INT,
    budget DECIMAL(15, 2),
    revenue DECIMAL(15, 2),
    language VARCHAR(10) DEFAULT 'en',
    country VARCHAR(100),
    rating ENUM('G', 'PG', 'PG-13', 'R', 'NC-17', 'NR'),
    status ENUM('released', 'upcoming', 'in_production', 'post_production') DEFAULT 'released',
    average_rating DECIMAL(3, 2) DEFAULT 0.00 COMMENT 'Average rating out of 5',
    total_reviews INT DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_title (title),
    INDEX idx_release_date (release_date),
    INDEX idx_average_rating (average_rating)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- GENRES TABLE
-- ============================================
CREATE TABLE genres (
    genre_id INT AUTO_INCREMENT PRIMARY KEY,
    genre_name VARCHAR(50) NOT NULL UNIQUE,
    description TEXT,
    INDEX idx_genre_name (genre_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- MOVIE_GENRES (Many-to-Many relationship)
-- ============================================
CREATE TABLE movie_genres (
    movie_id INT,
    genre_id INT,
    PRIMARY KEY (movie_id, genre_id),
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id) ON DELETE CASCADE,
    FOREIGN KEY (genre_id) REFERENCES genres(genre_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- CAST & CREW TABLES
-- ============================================
CREATE TABLE people (
    person_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    birth_date DATE,
    biography TEXT,
    profile_picture VARCHAR(255),
    imdb_id VARCHAR(20),
    INDEX idx_name (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE movie_cast (
    cast_id INT AUTO_INCREMENT PRIMARY KEY,
    movie_id INT,
    person_id INT,
    character_name VARCHAR(255),
    cast_order INT COMMENT 'Order of appearance in credits',
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id) ON DELETE CASCADE,
    FOREIGN KEY (person_id) REFERENCES people(person_id) ON DELETE CASCADE,
    INDEX idx_movie_cast (movie_id, person_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE movie_crew (
    crew_id INT AUTO_INCREMENT PRIMARY KEY,
    movie_id INT,
    person_id INT,
    job_title VARCHAR(100) COMMENT 'Director, Producer, Writer, etc.',
    department VARCHAR(50) COMMENT 'Production, Directing, Writing, etc.',
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id) ON DELETE CASCADE,
    FOREIGN KEY (person_id) REFERENCES people(person_id) ON DELETE CASCADE,
    INDEX idx_movie_crew (movie_id, person_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- REVIEWS TABLE
-- ============================================
CREATE TABLE reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    movie_id INT NOT NULL,
    user_id INT NOT NULL,
    rating DECIMAL(2, 1) NOT NULL COMMENT 'Rating out of 5.0',
    title VARCHAR(255),
    review_text TEXT,
    is_spoiler BOOLEAN DEFAULT FALSE,
    helpful_count INT DEFAULT 0,
    not_helpful_count INT DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    status ENUM('published', 'pending', 'flagged', 'deleted') DEFAULT 'published',
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    UNIQUE KEY unique_user_movie_review (user_id, movie_id),
    INDEX idx_movie_reviews (movie_id),
    INDEX idx_user_reviews (user_id),
    INDEX idx_rating (rating),
    INDEX idx_created_at (created_at),
    CONSTRAINT chk_rating CHECK (rating >= 0.0 AND rating <= 5.0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- REVIEW HELPFULNESS (Users can mark reviews as helpful)
-- ============================================
CREATE TABLE review_votes (
    vote_id INT AUTO_INCREMENT PRIMARY KEY,
    review_id INT NOT NULL,
    user_id INT NOT NULL,
    vote_type ENUM('helpful', 'not_helpful') NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (review_id) REFERENCES reviews(review_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    UNIQUE KEY unique_user_review_vote (user_id, review_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- COMMENTS ON REVIEWS
-- ============================================
CREATE TABLE review_comments (
    comment_id INT AUTO_INCREMENT PRIMARY KEY,
    review_id INT NOT NULL,
    user_id INT NOT NULL,
    comment_text TEXT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (review_id) REFERENCES reviews(review_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    INDEX idx_review_comments (review_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- WATCHLIST (Users can add movies to their watchlist)
-- ============================================
CREATE TABLE watchlist (
    watchlist_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    movie_id INT NOT NULL,
    added_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    priority ENUM('low', 'medium', 'high') DEFAULT 'medium',
    notes TEXT,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id) ON DELETE CASCADE,
    UNIQUE KEY unique_user_watchlist (user_id, movie_id),
    INDEX idx_user_watchlist (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- FAVORITES (Users can favorite movies)
-- ============================================
CREATE TABLE favorites (
    favorite_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    movie_id INT NOT NULL,
    added_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id) ON DELETE CASCADE,
    UNIQUE KEY unique_user_favorite (user_id, movie_id),
    INDEX idx_user_favorites (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- USER FOLLOWERS (Social feature)
-- ============================================
CREATE TABLE user_followers (
    follower_id INT,
    following_id INT,
    followed_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (follower_id, following_id),
    FOREIGN KEY (follower_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (following_id) REFERENCES users(user_id) ON DELETE CASCADE,
    INDEX idx_follower (follower_id),
    INDEX idx_following (following_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- AWARDS TABLE
-- ============================================
CREATE TABLE awards (
    award_id INT AUTO_INCREMENT PRIMARY KEY,
    award_name VARCHAR(100) NOT NULL,
    category VARCHAR(100),
    year INT,
    movie_id INT,
    person_id INT,
    won BOOLEAN DEFAULT FALSE COMMENT 'TRUE if won, FALSE if nominated',
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id) ON DELETE CASCADE,
    FOREIGN KEY (person_id) REFERENCES people(person_id) ON DELETE CASCADE,
    INDEX idx_movie_awards (movie_id),
    INDEX idx_person_awards (person_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- MOVIE COLLECTIONS/SERIES
-- ============================================
CREATE TABLE collections (
    collection_id INT AUTO_INCREMENT PRIMARY KEY,
    collection_name VARCHAR(255) NOT NULL,
    description TEXT,
    poster_url VARCHAR(255),
    backdrop_url VARCHAR(255)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE movie_collections (
    movie_id INT,
    collection_id INT,
    sequence_order INT COMMENT 'Order in the collection',
    PRIMARY KEY (movie_id, collection_id),
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id) ON DELETE CASCADE,
    FOREIGN KEY (collection_id) REFERENCES collections(collection_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- PRODUCTION COMPANIES
-- ============================================
CREATE TABLE production_companies (
    company_id INT AUTO_INCREMENT PRIMARY KEY,
    company_name VARCHAR(255) NOT NULL,
    logo_url VARCHAR(255),
    country VARCHAR(100),
    INDEX idx_company_name (company_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE movie_production_companies (
    movie_id INT,
    company_id INT,
    PRIMARY KEY (movie_id, company_id),
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id) ON DELETE CASCADE,
    FOREIGN KEY (company_id) REFERENCES production_companies(company_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- STREAMING PLATFORMS
-- ============================================
CREATE TABLE streaming_platforms (
    platform_id INT AUTO_INCREMENT PRIMARY KEY,
    platform_name VARCHAR(100) NOT NULL UNIQUE,
    logo_url VARCHAR(255),
    website_url VARCHAR(255)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE movie_streaming (
    movie_id INT,
    platform_id INT,
    available_from DATE,
    available_until DATE,
    streaming_url VARCHAR(255),
    PRIMARY KEY (movie_id, platform_id),
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id) ON DELETE CASCADE,
    FOREIGN KEY (platform_id) REFERENCES streaming_platforms(platform_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- ACTIVITY LOG (Track user activities)
-- ============================================
CREATE TABLE activity_log (
    activity_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    activity_type ENUM('review', 'comment', 'watchlist_add', 'favorite_add', 'follow') NOT NULL,
    reference_id INT COMMENT 'ID of the related entity (review_id, movie_id, etc.)',
    activity_timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    INDEX idx_user_activity (user_id, activity_timestamp)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- TRIGGERS TO UPDATE MOVIE RATINGS
-- ============================================
DELIMITER //

CREATE TRIGGER update_movie_rating_after_insert
AFTER INSERT ON reviews
FOR EACH ROW
BEGIN
    UPDATE movies
    SET average_rating = (
        SELECT AVG(rating)
        FROM reviews
        WHERE movie_id = NEW.movie_id AND status = 'published'
    ),
    total_reviews = (
        SELECT COUNT(*)
        FROM reviews
        WHERE movie_id = NEW.movie_id AND status = 'published'
    )
    WHERE movie_id = NEW.movie_id;
END//

CREATE TRIGGER update_movie_rating_after_update
AFTER UPDATE ON reviews
FOR EACH ROW
BEGIN
    UPDATE movies
    SET average_rating = (
        SELECT AVG(rating)
        FROM reviews
        WHERE movie_id = NEW.movie_id AND status = 'published'
    ),
    total_reviews = (
        SELECT COUNT(*)
        FROM reviews
        WHERE movie_id = NEW.movie_id AND status = 'published'
    )
    WHERE movie_id = NEW.movie_id;
END//

CREATE TRIGGER update_movie_rating_after_delete
AFTER DELETE ON reviews
FOR EACH ROW
BEGIN
    UPDATE movies
    SET average_rating = (
        SELECT COALESCE(AVG(rating), 0)
        FROM reviews
        WHERE movie_id = OLD.movie_id AND status = 'published'
    ),
    total_reviews = (
        SELECT COUNT(*)
        FROM reviews
        WHERE movie_id = OLD.movie_id AND status = 'published'
    )
    WHERE movie_id = OLD.movie_id;
END//

-- ============================================
-- TRIGGER TO UPDATE REVIEW HELPFULNESS COUNTS
-- ============================================
CREATE TRIGGER update_review_helpful_after_insert
AFTER INSERT ON review_votes
FOR EACH ROW
BEGIN
    IF NEW.vote_type = 'helpful' THEN
        UPDATE reviews
        SET helpful_count = helpful_count + 1
        WHERE review_id = NEW.review_id;
    ELSE
        UPDATE reviews
        SET not_helpful_count = not_helpful_count + 1
        WHERE review_id = NEW.review_id;
    END IF;
END//

CREATE TRIGGER update_review_helpful_after_update
AFTER UPDATE ON review_votes
FOR EACH ROW
BEGIN
    IF OLD.vote_type = 'helpful' THEN
        UPDATE reviews
        SET helpful_count = helpful_count - 1
        WHERE review_id = OLD.review_id;
    ELSE
        UPDATE reviews
        SET not_helpful_count = not_helpful_count - 1
        WHERE review_id = OLD.review_id;
    END IF;
    
    IF NEW.vote_type = 'helpful' THEN
        UPDATE reviews
        SET helpful_count = helpful_count + 1
        WHERE review_id = NEW.review_id;
    ELSE
        UPDATE reviews
        SET not_helpful_count = not_helpful_count + 1
        WHERE review_id = NEW.review_id;
    END IF;
END//

CREATE TRIGGER update_review_helpful_after_delete
AFTER DELETE ON review_votes
FOR EACH ROW
BEGIN
    IF OLD.vote_type = 'helpful' THEN
        UPDATE reviews
        SET helpful_count = helpful_count - 1
        WHERE review_id = OLD.review_id;
    ELSE
        UPDATE reviews
        SET not_helpful_count = not_helpful_count - 1
        WHERE review_id = OLD.review_id;
    END IF;
END//

DELIMITER ;
