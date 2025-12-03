-- Update Movies with Correct Titles and Images
-- Based on user's image mapping

USE movie_review_db;

-- 1. Jumanji: Welcome to the Jungle
UPDATE movies 
SET title = 'Jumanji: Welcome to the Jungle',
    original_title = 'Jumanji: Welcome to the Jungle',
    release_date = '2017-12-20',
    runtime = 119,
    plot_summary = 'Four teenagers are sucked into a magical video game, and the only way they can escape is to work together to finish the game.',
    tagline = 'The game has evolved.',
    poster_url = 'img/movie-1.jpg',
    rating = 'PG-13'
WHERE movie_id = 1;

-- 2. Hitman''s Wife''s Bodyguard
UPDATE movies 
SET title = 'Hitman''s Wife''s Bodyguard',
    original_title = 'Hitman''s Wife''s Bodyguard',
    release_date = '2021-06-16',
    runtime = 100,
    plot_summary = 'The bodyguard Michael Bryce continues his friendship with assassin Darius Kincaid as they try to save Darius'' wife Sonia.',
    tagline = 'The world''s most lethal odd couple is back.',
    poster_url = 'img/movie-2.jpg',
    rating = 'R'
WHERE movie_id = 2;

-- 3. Shang-Chi and the Legend of the Ten Rings
UPDATE movies 
SET title = 'Shang-Chi and the Legend of the Ten Rings',
    original_title = 'Shang-Chi and the Legend of the Ten Rings',
    release_date = '2021-09-03',
    runtime = 132,
    plot_summary = 'Shang-Chi, the master of weaponry-based Kung Fu, is forced to confront his past after being drawn into the Ten Rings organization.',
    tagline = 'A Marvel Legend Will Rise.',
    poster_url = 'img/movie-3.jpg',
    rating = 'PG-13'
WHERE movie_id = 3;

-- 4. Eternals
UPDATE movies 
SET title = 'Eternals',
    original_title = 'Eternals',
    release_date = '2021-11-05',
    runtime = 156,
    plot_summary = 'The saga of the Eternals, a race of immortal beings who lived on Earth and shaped its history and civilizations.',
    tagline = 'In the beginning...',
    poster_url = 'img/movie-4.jpg',
    rating = 'PG-13'
WHERE movie_id = 4;

-- 5. Spectre
UPDATE movies 
SET title = 'Spectre',
    original_title = 'Spectre',
    release_date = '2015-10-26',
    runtime = 148,
    plot_summary = 'A cryptic message from James Bond''s past sends him on a trail to uncover the existence of a sinister organisation named SPECTRE.',
    tagline = 'A Plan No One Escapes',
    poster_url = 'img/movie-5.jpg',
    rating = 'PG-13'
WHERE movie_id = 5;

-- 6. Money Heist (La Casa de Papel)
UPDATE movies 
SET title = 'Money Heist',
    original_title = 'La Casa de Papel',
    release_date = '2017-05-02',
    runtime = 70,
    plot_summary = 'An unusual group of robbers attempt to carry out the most perfect robbery in Spanish history - stealing 2.4 billion euros from the Royal Mint of Spain.',
    tagline = 'The perfect robbery.',
    poster_url = 'img/movie-6.jpg',
    rating = 'TV-MA'
WHERE movie_id = 6;

-- 7. The Wolverine
UPDATE movies 
SET title = 'The Wolverine',
    original_title = 'The Wolverine',
    release_date = '2013-07-26',
    runtime = 126,
    plot_summary = 'Wolverine comes to Japan to meet an old friend whose life he saved years ago, and gets embroiled in a conspiracy involving yakuza and mutants.',
    tagline = 'The past is always behind you, but the future is yet to be written.',
    poster_url = 'img/movie-7.jpg',
    rating = 'PG-13'
WHERE movie_id = 7;

-- 8. Johnny English Strikes Again
UPDATE movies 
SET title = 'Johnny English Strikes Again',
    original_title = 'Johnny English Strikes Again',
    release_date = '2018-10-05',
    runtime = 89,
    plot_summary = 'After a cyber-attack reveals the identity of all of the active undercover agents in Britain, Johnny English is forced to come out of retirement to find the mastermind hacker.',
    tagline = 'He knows no fear. He knows no danger. He knows nothing.',
    poster_url = 'img/movie-8.jpg',
    rating = 'PG'
WHERE movie_id = 8;

-- 9. Spider-Man: No Way Home
UPDATE movies 
SET title = 'Spider-Man: No Way Home',
    original_title = 'Spider-Man: No Way Home',
    release_date = '2021-12-17',
    runtime = 148,
    plot_summary = 'With Spider-Man''s identity now revealed, Peter asks Doctor Strange for help. When a spell goes wrong, dangerous foes from other worlds start to appear.',
    tagline = 'The Multiverse unleashed.',
    poster_url = 'img/popular-movie-1.jpg',
    rating = 'PG-13'
WHERE movie_id = 9;

-- 10. Jungle Cruise
UPDATE movies 
SET title = 'Jungle Cruise',
    original_title = 'Jungle Cruise',
    release_date = '2021-07-30',
    runtime = 127,
    plot_summary = 'Based on Disneyland''s theme park ride where a small riverboat takes a group of travelers through a jungle filled with dangerous animals and reptiles but with a supernatural element.',
    tagline = 'Adventure awaits.',
    poster_url = 'img/popular-movie-2.jpg',
    rating = 'PG-13'
WHERE movie_id = 10;

-- 11. Loki
UPDATE movies 
SET title = 'Loki',
    original_title = 'Loki',
    release_date = '2021-06-09',
    runtime = 50,
    plot_summary = 'The mercurial villain Loki resumes his role as the God of Mischief in a new series that takes place after the events of "Avengers: Endgame".',
    tagline = 'Loki''s time has come.',
    poster_url = 'img/popular-movie-3.jpg',
    rating = 'TV-14'
WHERE movie_id = 11;

-- 12. Squid Game
UPDATE movies 
SET title = 'Squid Game',
    original_title = 'Ojing-eo Geim',
    release_date = '2021-09-17',
    runtime = 55,
    plot_summary = 'Hundreds of cash-strapped players accept a strange invitation to compete in children''s games. Inside, a tempting prize awaits with deadly high stakes.',
    tagline = '45.6 Billion Won is Child''s Play.',
    poster_url = 'img/popular-movie-4.jpg',
    rating = 'TV-MA'
WHERE movie_id = 12;

-- 13. The Falcon and the Winter Soldier
UPDATE movies 
SET title = 'The Falcon and the Winter Soldier',
    original_title = 'The Falcon and the Winter Soldier',
    release_date = '2021-03-19',
    runtime = 50,
    plot_summary = 'Following the events of "Avengers: Endgame," Sam Wilson/Falcon and Bucky Barnes/Winter Soldier team up in a global adventure that tests their abilities -- and their patience.',
    tagline = 'Honor the shield.',
    poster_url = 'img/popular-movie-5.jpg',
    rating = 'TV-14'
WHERE movie_id = 13;

-- 14. Hawkeye
UPDATE movies 
SET title = 'Hawkeye',
    original_title = 'Hawkeye',
    release_date = '2021-11-24',
    runtime = 50,
    plot_summary = 'Series based on the Marvel Comics superhero Hawkeye, centering on the adventures of Young Avenger, Kate Bishop, who took on the role after the original Avenger, Clint Barton.',
    tagline = 'This holiday season, the best gifts come with a bow.',
    poster_url = 'img/popular-movie-6.jpg',
    rating = 'TV-14'
WHERE movie_id = 14;

-- 15. Agents of S.H.I.E.L.D.
UPDATE movies 
SET title = 'Agents of S.H.I.E.L.D.',
    original_title = 'Agents of S.H.I.E.L.D.',
    release_date = '2013-09-24',
    runtime = 45,
    plot_summary = 'The missions of the Strategic Homeland Intervention, Enforcement and Logistics Division.',
    tagline = 'Not All Heroes Are Super.',
    poster_url = 'img/popular-movie-7.jpg',
    rating = 'TV-PG'
WHERE movie_id = 15;

-- 16. The Flash: Armageddon
UPDATE movies 
SET title = 'The Flash: Armageddon',
    original_title = 'The Flash',
    release_date = '2021-11-16',
    runtime = 42,
    plot_summary = 'A powerful alien threat arrives on Earth under mysterious circumstances and Barry, Iris and the rest of Team Flash are pushed to their limits in a desperate battle to save the world.',
    tagline = 'Run.',
    poster_url = 'img/popular-movie-8.jpg',
    rating = 'TV-PG'
WHERE movie_id = 16;
