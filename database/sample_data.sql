-- Updated Sample Data with Image Paths
-- This replaces the previous sample data with actual image references

USE movie_review_db;

-- Clear existing data
DELETE FROM review_comments;
DELETE FROM review_votes;
DELETE FROM reviews;
DELETE FROM watchlist;
DELETE FROM favorites;
DELETE FROM user_followers;
DELETE FROM movie_cast;
DELETE FROM movie_crew;
DELETE FROM movie_genres;
DELETE FROM movie_production_companies;
DELETE FROM movie_streaming;
DELETE FROM movie_collections;
DELETE FROM awards;
DELETE FROM movies;
DELETE FROM users;
DELETE FROM people;

-- Reset auto increment
ALTER TABLE movies AUTO_INCREMENT = 1;
ALTER TABLE users AUTO_INCREMENT = 1;
ALTER TABLE people AUTO_INCREMENT = 1;
ALTER TABLE reviews AUTO_INCREMENT = 1;

-- ============================================
-- INSERT USERS
-- ============================================
INSERT INTO users (username, email, password_hash, first_name, last_name, bio, role, is_verified) VALUES
('moviebuff2024', 'john.doe@email.com', '$2y$10$abcdefghijklmnopqrstuvwxyz123456', 'John', 'Doe', 'Passionate about cinema and storytelling. Love all genres!', 'user', TRUE),
('criticalreviewer', 'jane.smith@email.com', '$2y$10$abcdefghijklmnopqrstuvwxyz123456', 'Jane', 'Smith', 'Professional film critic with 10 years experience.', 'critic', TRUE),
('cinephile_alex', 'alex.johnson@email.com', '$2y$10$abcdefghijklmnopqrstuvwxyz123456', 'Alex', 'Johnson', 'Sci-fi and fantasy enthusiast. Always looking for hidden gems.', 'user', TRUE),
('admin_user', 'admin@moviereview.com', '$2y$10$abcdefghijklmnopqrstuvwxyz123456', 'Admin', 'User', 'Site administrator', 'admin', TRUE),
('horror_fan_mike', 'mike.wilson@email.com', '$2y$10$abcdefghijklmnopqrstuvwxyz123456', 'Mike', 'Wilson', 'Horror movie collector. The scarier, the better!', 'user', TRUE),
('sarah_cinema', 'sarah.lee@email.com', '$2y$10$abcdefghijklmnopqrstuvwxyz123456', 'Sarah', 'Lee', 'Love romantic comedies and dramas!', 'user', TRUE),
('action_lover_tom', 'tom.brown@email.com', '$2y$10$abcdefghijklmnopqrstuvwxyz123456', 'Tom', 'Brown', 'Action movies are my life! Explosions and car chases!', 'user', TRUE),
('indie_film_fan', 'emma.davis@email.com', '$2y$10$abcdefghijklmnopqrstuvwxyz123456', 'Emma', 'Davis', 'Independent cinema enthusiast. Supporting small filmmakers.', 'critic', TRUE);

-- ============================================
-- INSERT PEOPLE (Actors/Directors)
-- ============================================
INSERT INTO people (name, birth_date, biography) VALUES
('Christopher Nolan', '1970-07-30', 'British-American filmmaker known for his cerebral, often nonlinear storytelling.'),
('Leonardo DiCaprio', '1974-11-11', 'American actor and film producer known for his versatile roles.'),
('Margot Robbie', '1990-07-02', 'Australian actress and producer known for her roles in both blockbusters and independent films.'),
('Greta Gerwig', '1983-08-04', 'American actress, screenwriter, and director.'),
('Ryan Gosling', '1980-11-12', 'Canadian actor known for his roles in both independent and mainstream films.'),
('Denis Villeneuve', '1967-10-03', 'Canadian filmmaker known for his visually stunning science fiction films.'),
('Timothée Chalamet', '1995-12-27', 'American actor known for his roles in coming-of-age dramas and period pieces.'),
('Zendaya', '1996-09-01', 'American actress and singer known for her versatile performances.'),
('Martin Scorsese', '1942-11-17', 'American film director, producer, and screenwriter, one of the major figures of the New Hollywood era.'),
('Robert De Niro', '1943-08-17', 'American actor known for his collaborations with Martin Scorsese.'),
('Tom Cruise', '1962-07-03', 'American actor and producer, one of the world''s highest-paid actors.'),
('Scarlett Johansson', '1984-11-22', 'American actress and singer, one of the world''s highest-grossing box office stars.'),
('Keanu Reeves', '1964-09-02', 'Canadian actor known for his roles in action films.'),
('Emma Stone', '1988-11-06', 'American actress known for her versatile performances.');

-- ============================================
-- INSERT MOVIES WITH ACTUAL IMAGE PATHS
-- ============================================
INSERT INTO movies (title, original_title, release_date, runtime, plot_summary, tagline, poster_url, rating, language, country, status) VALUES
('Inception', 'Inception', '2010-07-16', 148, 
'A thief who steals corporate secrets through the use of dream-sharing technology is given the inverse task of planting an idea into the mind of a C.E.O.', 
'Your mind is the scene of the crime', 
'img/movie-1.jpg', 'PG-13', 'en', 'USA', 'released'),

('Barbie', 'Barbie', '2023-07-21', 114,
'Barbie and Ken are having the time of their lives in the colorful and seemingly perfect world of Barbie Land. However, when they get a chance to go to the real world, they soon discover the joys and perils of living among humans.',
'She''s everything. He''s just Ken.', 
'img/movie-2.jpg', 'PG-13', 'en', 'USA', 'released'),

('Dune: Part Two', 'Dune: Part Two', '2024-03-01', 166,
'Paul Atreides unites with Chani and the Fremen while seeking revenge against the conspirators who destroyed his family. Facing a choice between the love of his life and the fate of the universe, he must prevent a terrible future only he can foresee.',
'Long live the fighters', 
'img/movie-3.jpg', 'PG-13', 'en', 'USA', 'released'),

('Oppenheimer', 'Oppenheimer', '2023-07-21', 180,
'The story of American scientist J. Robert Oppenheimer and his role in the development of the atomic bomb during World War II.',
'The world changes forever', 
'img/movie-4.jpg', 'R', 'en', 'USA', 'released'),

('The Shawshank Redemption', 'The Shawshank Redemption', '1994-09-23', 142,
'Two imprisoned men bond over a number of years, finding solace and eventual redemption through acts of common decency.',
'Fear can hold you prisoner. Hope can set you free.', 
'img/movie-5.jpg', 'R', 'en', 'USA', 'released'),

('Top Gun: Maverick', 'Top Gun: Maverick', '2022-05-27', 131,
'After thirty years, Maverick is still pushing the envelope as a top naval aviator, but must confront ghosts of his past when he leads TOP GUN''s elite graduates on a mission that demands the ultimate sacrifice.',
'Feel the need... The need for speed.', 
'img/movie-6.jpg', 'PG-13', 'en', 'USA', 'released'),

('The Dark Knight', 'The Dark Knight', '2008-07-18', 152,
'When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, Batman must accept one of the greatest psychological and physical tests of his ability to fight injustice.',
'Why so serious?', 
'img/movie-7.jpg', 'PG-13', 'en', 'USA', 'released'),

('Interstellar', 'Interstellar', '2014-11-07', 169,
'A team of explorers travel through a wormhole in space in an attempt to ensure humanity''s survival.',
'Mankind was born on Earth. It was never meant to die here.', 
'img/movie-8.jpg', 'PG-13', 'en', 'USA', 'released'),

('Avengers: Endgame', 'Avengers: Endgame', '2019-04-26', 181,
'After the devastating events of Infinity War, the Avengers assemble once more to reverse Thanos'' actions and restore balance to the universe.',
'Part of the journey is the end.', 
'img/popular-movie-1.jpg', 'PG-13', 'en', 'USA', 'released'),

('Spider-Man: No Way Home', 'Spider-Man: No Way Home', '2021-12-17', 148,
'With Spider-Man''s identity now revealed, Peter asks Doctor Strange for help. When a spell goes wrong, dangerous foes from other worlds start to appear.',
'The Multiverse unleashed.', 
'img/popular-movie-2.jpg', 'PG-13', 'en', 'USA', 'released'),

('The Batman', 'The Batman', '2022-03-04', 176,
'When a sadistic serial killer begins murdering key political figures in Gotham, Batman is forced to investigate the city''s hidden corruption and question his family''s involvement.',
'Unmask the truth.', 
'img/popular-movie-3.jpg', 'PG-13', 'en', 'USA', 'released'),

('John Wick: Chapter 4', 'John Wick: Chapter 4', '2023-03-24', 169,
'John Wick uncovers a path to defeating The High Table. But before he can earn his freedom, Wick must face off against a new enemy with powerful alliances across the globe.',
'No way back. One way out.', 
'img/popular-movie-4.jpg', 'R', 'en', 'USA', 'released'),

('Guardians of the Galaxy Vol. 3', 'Guardians of the Galaxy Vol. 3', '2023-05-05', 150,
'Still reeling from the loss of Gamora, Peter Quill rallies his team to defend the universe and one of their own - a mission that could mean the end of the Guardians if not successful.',
'Once more with feeling.', 
'img/popular-movie-5.jpg', 'PG-13', 'en', 'USA', 'released'),

('Mission: Impossible - Dead Reckoning', 'Mission: Impossible - Dead Reckoning Part One', '2023-07-12', 163,
'Ethan Hunt and his IMF team must track down a terrifying new weapon that threatens all of humanity if it falls into the wrong hands.',
'We all share the same fate.', 
'img/popular-movie-6.jpg', 'PG-13', 'en', 'USA', 'released'),

('The Super Mario Bros. Movie', 'The Super Mario Bros. Movie', '2023-04-05', 92,
'A plumber named Mario travels through an underground labyrinth with his brother, Luigi, trying to save a captured princess.',
'Let''s-a-go!', 
'img/popular-movie-7.jpg', 'PG', 'en', 'USA', 'released'),

('Wonka', 'Wonka', '2023-12-15', 116,
'The story focuses on a young Willy Wonka and how he met the Oompa-Loompas on one of his earliest adventures.',
'Every good thing in this world started with a dream.', 
'img/wonka-movie-poster-5120x2880-13327.jpg', 'PG', 'en', 'USA', 'released');

-- ============================================
-- LINK MOVIES TO GENRES
-- ============================================
INSERT INTO movie_genres (movie_id, genre_id) VALUES
-- Inception: Action, Sci-Fi, Thriller
(1, 1), (1, 6), (1, 8),
-- Barbie: Comedy, Fantasy, Adventure
(2, 3), (2, 7), (2, 2),
-- Dune Part Two: Sci-Fi, Adventure, Drama
(3, 6), (3, 2), (3, 4),
-- Oppenheimer: Drama
(4, 4),
-- Shawshank: Drama, Crime
(5, 4), (5, 11),
-- Top Gun Maverick: Action, Drama
(6, 1), (6, 4),
-- Dark Knight: Action, Crime, Thriller
(7, 1), (7, 11), (7, 8),
-- Interstellar: Sci-Fi, Drama, Adventure
(8, 6), (8, 4), (8, 2),
-- Avengers Endgame: Action, Sci-Fi, Adventure
(9, 1), (9, 6), (9, 2),
-- Spider-Man: Action, Sci-Fi, Adventure
(10, 1), (10, 6), (10, 2),
-- The Batman: Action, Crime, Thriller
(11, 1), (11, 11), (11, 8),
-- John Wick 4: Action, Thriller, Crime
(12, 1), (12, 8), (12, 11),
-- Guardians Vol 3: Action, Sci-Fi, Comedy
(13, 1), (13, 6), (13, 3),
-- Mission Impossible: Action, Thriller, Adventure
(14, 1), (14, 8), (14, 2),
-- Super Mario: Animation, Adventure, Comedy
(15, 12), (15, 2), (15, 3),
-- Wonka: Musical, Fantasy, Comedy
(16, 14), (16, 7), (16, 3);

-- ============================================
-- LINK MOVIES TO CAST
-- ============================================
INSERT INTO movie_cast (movie_id, person_id, character_name, cast_order) VALUES
-- Inception
(1, 2, 'Dom Cobb', 1),
-- Barbie
(2, 3, 'Barbie', 1),
(2, 5, 'Ken', 2),
-- Dune Part Two
(3, 7, 'Paul Atreides', 1),
(3, 8, 'Chani', 2),
-- Oppenheimer
(4, 2, 'J. Robert Oppenheimer', 1),
-- Top Gun Maverick
(6, 11, 'Pete "Maverick" Mitchell', 1),
-- Dark Knight
(7, 2, 'Bruce Wayne / Batman', 1),
-- Interstellar
(8, 2, 'Cooper', 1),
-- John Wick 4
(12, 13, 'John Wick', 1),
-- Mission Impossible
(14, 11, 'Ethan Hunt', 1);

-- ============================================
-- LINK MOVIES TO CREW
-- ============================================
INSERT INTO movie_crew (movie_id, person_id, job_title, department) VALUES
-- Inception
(1, 1, 'Director', 'Directing'),
(1, 1, 'Writer', 'Writing'),
-- Barbie
(2, 4, 'Director', 'Directing'),
(2, 4, 'Writer', 'Writing'),
-- Dune Part Two
(3, 6, 'Director', 'Directing'),
-- Oppenheimer
(4, 1, 'Director', 'Directing'),
-- Dark Knight
(7, 1, 'Director', 'Directing'),
-- Interstellar
(8, 1, 'Director', 'Directing');

-- ============================================
-- INSERT COMPREHENSIVE REVIEWS
-- ============================================
INSERT INTO reviews (movie_id, user_id, rating, title, review_text, is_spoiler, status) VALUES
-- Inception Reviews
(1, 1, 5.0, 'A Mind-Bending Masterpiece', 
'Inception is one of the most original and thought-provoking films of the 21st century. Christopher Nolan crafts a complex narrative that keeps you engaged from start to finish. The visual effects are stunning, and the performances are top-notch. A must-watch!', 
FALSE, 'published'),

(1, 2, 4.5, 'Complex but Rewarding', 
'While the plot can be confusing at times, Inception rewards viewers who pay attention. The dream-within-a-dream concept is executed brilliantly, and the action sequences are spectacular. Hans Zimmer''s score is unforgettable.', 
FALSE, 'published'),

(1, 3, 5.0, 'Nolan at His Best',
'This movie changed how I think about cinema. The layers of storytelling, the incredible cinematography, and that ending! I''ve watched it 5 times and still discover new details.',
FALSE, 'published'),

-- Barbie Reviews
(2, 3, 4.0, 'Surprisingly Deep and Fun', 
'Barbie exceeded all my expectations! It''s not just a fun, colorful movie - it has real depth and commentary on modern society. Margot Robbie and Ryan Gosling are perfect in their roles. The production design is absolutely incredible.', 
FALSE, 'published'),

(2, 6, 4.5, 'More Than Just Pink',
'I went in expecting a silly movie and left with tears in my eyes. Greta Gerwig created something truly special - a film that''s both hilarious and deeply moving. The musical numbers are fantastic!',
FALSE, 'published'),

(2, 1, 4.0, 'Clever and Entertaining',
'Barbie is a smart, witty film that works on multiple levels. It''s visually stunning, the performances are great, and it has something meaningful to say. Highly recommended!',
FALSE, 'published'),

-- Dune Part Two Reviews
(3, 1, 5.0, 'Epic Science Fiction at Its Best', 
'Dune Part Two is everything a sequel should be - bigger, better, and more emotionally resonant. Villeneuve''s vision is breathtaking, and the performances from the entire cast are phenomenal. The cinematography is absolutely stunning.', 
FALSE, 'published'),

(3, 3, 4.5, 'Visually Stunning Continuation', 
'Denis Villeneuve continues to prove why he''s one of the best directors working today. The scale of this film is massive, yet it never loses sight of the human story at its core. Can''t wait for Part Three!', 
FALSE, 'published'),

(3, 7, 5.0, 'A Sci-Fi Epic for the Ages',
'The world-building is incredible, the action is intense, and the emotional beats hit perfectly. Timothée Chalamet and Zendaya have amazing chemistry. This is cinema at its finest!',
FALSE, 'published'),

(3, 2, 4.5, 'Masterful Filmmaking',
'Villeneuve has created a visual masterpiece. Every frame could be a painting. The story is complex but never confusing, and the performances are outstanding.',
FALSE, 'published'),

-- Oppenheimer Reviews
(4, 2, 5.0, 'Nolan''s Best Work Yet', 
'Oppenheimer is a haunting, powerful film about one of history''s most consequential figures. Cillian Murphy delivers a career-best performance. The way Nolan handles the moral complexity of the atomic bomb is masterful.', 
FALSE, 'published'),

(4, 8, 5.0, 'Powerful and Thought-Provoking',
'This film stayed with me for days. The moral questions it raises are profound, and the performances are incredible. Nolan''s direction is impeccable.',
FALSE, 'published'),

(4, 1, 4.5, 'A Historical Epic',
'Oppenheimer is a masterclass in biographical filmmaking. The three-hour runtime flies by, and every scene serves a purpose. Cillian Murphy deserves all the awards!',
FALSE, 'published'),

-- Shawshank Redemption Reviews
(5, 5, 5.0, 'Timeless Classic', 
'The Shawshank Redemption is the perfect film. Every scene, every line of dialogue, every performance is pitch-perfect. It''s a story about hope, friendship, and redemption that never gets old no matter how many times you watch it.', 
FALSE, 'published'),

(5, 1, 5.0, 'The Greatest Film Ever Made',
'I''ve seen this movie at least 20 times, and it still makes me cry. The story of hope and friendship is timeless. Morgan Freeman and Tim Robbins are phenomenal.',
FALSE, 'published'),

(5, 2, 5.0, 'Perfection in Every Frame',
'There''s a reason this is #1 on so many "best movies" lists. It''s flawless. The writing, acting, direction - everything comes together perfectly.',
FALSE, 'published'),

-- Top Gun Maverick Reviews
(6, 7, 5.0, 'The Best Action Movie in Years',
'Top Gun: Maverick is pure adrenaline! The flight sequences are incredible, and Tom Cruise proves he''s still the king of action. The emotional story elevates it beyond just spectacle.',
FALSE, 'published'),

(6, 1, 4.5, 'A Worthy Sequel',
'After 36 years, they actually made a sequel that lives up to the original. The aerial cinematography is breathtaking, and the story has real heart.',
FALSE, 'published'),

(6, 3, 4.0, 'Pure Entertainment',
'This movie is exactly what summer blockbusters should be - exciting, emotional, and expertly crafted. Tom Cruise is at his best!',
FALSE, 'published'),

-- Dark Knight Reviews
(7, 1, 5.0, 'The Best Superhero Movie Ever',
'The Dark Knight transcends the superhero genre. Heath Ledger''s Joker is one of the greatest villain performances in cinema history. Nolan created a crime epic that happens to feature Batman.',
FALSE, 'published'),

(7, 2, 5.0, 'A Masterpiece',
'Heath Ledger''s performance is legendary. This film raised the bar for what superhero movies could be. Dark, complex, and absolutely riveting.',
FALSE, 'published'),

(7, 7, 5.0, 'Unforgettable',
'The Joker is terrifying and mesmerizing. The action is incredible, and the moral dilemmas are thought-provoking. This is more than a comic book movie.',
FALSE, 'published'),

-- Interstellar Reviews
(8, 3, 5.0, 'Emotionally Powerful Sci-Fi',
'Interstellar combines mind-bending science fiction with a deeply emotional father-daughter story. The visuals are stunning, and the score by Hans Zimmer is incredible.',
FALSE, 'published'),

(8, 1, 4.5, 'Ambitious and Moving',
'Nolan tackles huge themes - love, time, survival - and mostly succeeds. The black hole sequence is one of the most beautiful things I''ve seen in cinema.',
FALSE, 'published'),

(8, 2, 4.0, 'Visually Stunning',
'The science is fascinating, the visuals are breathtaking, and the emotional core is strong. A bit long, but worth every minute.',
FALSE, 'published'),

-- Avengers Endgame Reviews
(9, 1, 5.0, 'The Perfect Conclusion',
'Endgame is everything Marvel fans could have hoped for. It''s epic, emotional, and satisfying. The final battle is incredible, and the character moments hit hard.',
FALSE, 'published'),

(9, 7, 5.0, 'Epic Finale',
'After 11 years and 22 movies, they stuck the landing! This movie is a love letter to fans. I laughed, I cried, I cheered. Perfect!',
FALSE, 'published'),

(9, 3, 4.5, 'Satisfying Conclusion',
'The Russo Brothers delivered an epic conclusion to the Infinity Saga. The three-hour runtime flies by, and the emotional payoffs are worth it.',
FALSE, 'published'),

-- Spider-Man No Way Home Reviews
(10, 1, 5.0, 'Multiverse Magic',
'Spider-Man: No Way Home is a love letter to Spider-Man fans. The nostalgia, the action, the emotion - it all works perfectly. Tom Holland gives his best performance yet.',
FALSE, 'published'),

(10, 3, 4.5, 'Fan Service Done Right',
'This movie could have been a mess, but instead it''s a triumph. The way they brought everything together is masterful. Pure joy!',
FALSE, 'published'),

-- The Batman Reviews
(11, 2, 4.5, 'Dark and Gripping',
'Matt Reeves created a noir detective story that happens to star Batman. Robert Pattinson is excellent, and the cinematography is gorgeous. A fresh take on the character.',
FALSE, 'published'),

(11, 1, 4.0, 'A Different Batman',
'This is Batman as a detective, and it works beautifully. The atmosphere is dark and moody, and the Riddler is genuinely creepy.',
FALSE, 'published'),

-- John Wick 4 Reviews
(12, 7, 5.0, 'Action Perfection',
'John Wick: Chapter 4 is the best action movie I''ve seen in years. The fight choreography is incredible, and Keanu Reeves is at the top of his game. Every action sequence tops the last!',
FALSE, 'published'),

(12, 1, 4.5, 'Spectacular Action',
'The John Wick franchise keeps getting better. The action is balletic and brutal, and the world-building is fascinating. A must-see for action fans!',
FALSE, 'published'),

-- Guardians Vol 3 Reviews
(13, 3, 4.5, 'Emotional and Fun',
'James Gunn delivers a perfect conclusion to the Guardians trilogy. It''s funny, action-packed, and surprisingly emotional. The best Guardians movie yet!',
FALSE, 'published'),

(13, 1, 4.0, 'A Fitting Farewell',
'Guardians Vol. 3 balances humor and heart perfectly. The soundtrack is great as always, and the character arcs are satisfying.',
FALSE, 'published'),

-- Mission Impossible Reviews
(14, 7, 5.0, 'Tom Cruise Does It Again',
'Mission: Impossible - Dead Reckoning is pure entertainment. The stunts are insane (that motorcycle jump!), and the story keeps you engaged. Tom Cruise is ageless!',
FALSE, 'published'),

(14, 1, 4.5, 'Thrilling Adventure',
'The action sequences are incredible, and the plot is surprisingly engaging. Tom Cruise continues to push the boundaries of what''s possible in action cinema.',
FALSE, 'published'),

-- Super Mario Movie Reviews
(15, 6, 4.0, 'Fun for the Whole Family',
'The Super Mario Bros. Movie is a delightful animated adventure. It''s colorful, funny, and full of Easter eggs for fans. My kids loved it!',
FALSE, 'published'),

(15, 1, 3.5, 'Entertaining Adaptation',
'A fun, energetic movie that captures the spirit of the games. The animation is gorgeous, and the voice cast is great. Simple but enjoyable!',
FALSE, 'published'),

-- Wonka Reviews
(16, 6, 4.5, 'Magical and Charming',
'Wonka is a delightful musical that captures the magic of Willy Wonka''s origin story. Timothée Chalamet is charming, and the songs are catchy!',
FALSE, 'published'),

(16, 1, 4.0, 'Sweet and Fun',
'A heartwarming origin story with great musical numbers. Timothée Chalamet brings a youthful energy to the character. Perfect family entertainment!',
FALSE, 'published');

-- ============================================
-- INSERT WATCHLIST ITEMS
-- ============================================
INSERT INTO watchlist (user_id, movie_id, priority, notes) VALUES
(1, 4, 'high', 'Must watch this weekend!'),
(3, 2, 'medium', 'Heard great things about this'),
(5, 3, 'high', 'Been waiting for this sequel'),
(6, 16, 'high', 'Love musicals!'),
(7, 12, 'high', 'Action movie night!');

-- ============================================
-- INSERT FAVORITES
-- ============================================
INSERT INTO favorites (user_id, movie_id) VALUES
(1, 1), (1, 5), (1, 7),
(2, 4), (2, 5),
(3, 3), (3, 8),
(5, 5), (5, 7),
(6, 2), (6, 16),
(7, 6), (7, 12), (7, 14);

-- ============================================
-- INSERT REVIEW VOTES
-- ============================================
INSERT INTO review_votes (review_id, user_id, vote_type) VALUES
(1, 2, 'helpful'), (1, 3, 'helpful'), (1, 5, 'helpful'),
(2, 1, 'helpful'), (2, 3, 'helpful'),
(3, 1, 'helpful'), (3, 2, 'helpful'),
(4, 1, 'helpful'), (4, 5, 'helpful'),
(7, 2, 'helpful'), (7, 3, 'helpful'), (7, 5, 'helpful'),
(11, 1, 'helpful'), (11, 3, 'helpful'),
(14, 1, 'helpful'), (14, 2, 'helpful'), (14, 3, 'helpful');

-- ============================================
-- INSERT FOLLOWERS
-- ============================================
INSERT INTO user_followers (follower_id, following_id) VALUES
(1, 2), (3, 2), (1, 3), (5, 1), (6, 2), (7, 1), (7, 2);

-- ============================================
-- INSERT REVIEW COMMENTS
-- ============================================
INSERT INTO review_comments (review_id, user_id, comment_text) VALUES
(1, 3, 'Great review! I completely agree about the visual effects.'),
(4, 1, 'Thanks for the recommendation, definitely going to watch this now!'),
(14, 2, 'Couldn''t have said it better myself. This movie is perfect.'),
(7, 2, 'Excellent analysis! Villeneuve is a master filmmaker.'),
(19, 3, 'Heath Ledger was incredible. This performance is legendary!');
