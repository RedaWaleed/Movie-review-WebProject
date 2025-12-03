-- Step-by-Step Database Setup
-- Run each section separately to identify any issues

-- ============================================
-- STEP 1: Verify Database Exists
-- ============================================
USE movie_review_db;
SELECT 'Database exists!' as status;

-- ============================================
-- STEP 2: Check if tables exist
-- ============================================
SHOW TABLES;

-- ============================================
-- STEP 3: Check if genres exist (required for movie_genres)
-- ============================================
SELECT * FROM genres;

-- ============================================
-- STEP 4: Check if movies exist (required for movie_genres)
-- ============================================
SELECT movie_id, title FROM movies;

-- ============================================
-- STEP 5: Try inserting one movie_genre relationship
-- ============================================
-- This should work if movies and genres exist
INSERT INTO movie_genres (movie_id, genre_id) VALUES (1, 1);
SELECT 'First movie_genre inserted!' as status;

-- ============================================
-- STEP 6: Check the result
-- ============================================
SELECT 
    m.title,
    g.genre_name
FROM movie_genres mg
JOIN movies m ON mg.movie_id = m.movie_id
JOIN genres g ON mg.genre_id = g.genre_id;

-- ============================================
-- If all above works, the issue might be:
-- 1. Movies table is empty (run schema first)
-- 2. Genres table is empty (run schema first)
-- 3. Duplicate entries (clear and re-run)
-- ============================================
