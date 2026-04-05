-- ======================================================
-- Project: Spotify Data Engineering & Advanced Analytics
-- Script: Full Analytical Pipeline (Easy to Advanced)
-- ======================================================

-- 1. DATABASE SETUP & NORMALIZATION
-- ------------------------------------------------------
DROP TABLE IF EXISTS spotify;
CREATE TABLE spotify (
    artist VARCHAR(255),
    track VARCHAR(255),
    album VARCHAR(255),
    album_type VARCHAR(50),
    danceability FLOAT,
    energy FLOAT,
    loudness FLOAT,
    speechiness FLOAT,
    acousticness FLOAT,
    instrumentalness FLOAT,
    liveness FLOAT,
    valence FLOAT,
    tempo FLOAT,
    duration_min FLOAT,
    title VARCHAR(255),
    channel VARCHAR(255),
    views FLOAT,
    likes BIGINT,
    comments BIGINT,
    licensed BOOLEAN,
    official_video BOOLEAN,
    stream BIGINT,
    energy_liveness FLOAT,
    most_played_on VARCHAR(50)
);

-- 2. EASY LEVEL QUERIES
-- ------------------------------------------------------
-- Q1: Retrieve tracks with more than 1 billion streams
SELECT track, artist, stream 
FROM spotify 
WHERE stream > 1000000000;

-- Q2: List all albums along with their respective artists
SELECT DISTINCT album, artist 
FROM spotify;

-- Q3: Get the total number of comments for licensed tracks
SELECT SUM(comments) AS total_comments 
FROM spotify 
WHERE licensed = TRUE;

-- Q4: Find all tracks that belong to the 'single' album type
SELECT track 
FROM spotify 
WHERE album_type = 'single';

-- Q5: Count the total number of tracks by each artist
SELECT artist, COUNT(track) AS total_tracks 
FROM spotify 
GROUP BY artist 
ORDER BY total_tracks DESC;


-- 3. MEDIUM LEVEL QUERIES
-- ------------------------------------------------------
-- Q6: Calculate the average danceability of tracks in each album
SELECT album, AVG(danceability) AS avg_danceability 
FROM spotify 
GROUP BY album 
ORDER BY avg_danceability DESC;

-- Q7: Find the top 5 tracks with the highest energy values
SELECT track, energy 
FROM spotify 
ORDER BY energy DESC 
LIMIT 5;

-- Q8: List tracks with views and likes where official_video = TRUE
SELECT track, views, likes 
FROM spotify 
WHERE official_video = TRUE 
ORDER BY views DESC;

-- Q9: Calculate total views for all tracks associated with each album
SELECT album, SUM(views) AS total_views 
FROM spotify 
GROUP BY album 
ORDER BY total_views DESC;

-- Q10: Retrieve track names streamed more on Spotify than YouTube
SELECT track, stream, views 
FROM spotify 
WHERE most_played_on = 'Spotify' AND stream > views;


-- 4. ADVANCED LEVEL QUERIES (CTEs & Window Functions)
-- ------------------------------------------------------
-- Q11: Top 3 most-viewed tracks for each artist using Window Functions
SELECT artist, track, views
FROM (
    SELECT artist, track, views,
           DENSE_RANK() OVER(PARTITION BY artist ORDER BY views DESC) as rank
    FROM spotify
) AS ranked_tracks
WHERE rank <= 3;

-- Q12: Find tracks where the liveness score is above the global average
SELECT track, artist, liveness 
FROM spotify 
WHERE liveness > (SELECT AVG(liveness) FROM spotify);

-- Q13: Calculate the Energy Difference per Album (using WITH clause)
WITH album_energy_stats AS (
    SELECT 
        album,
        MAX(energy) AS highest_energy,
        MIN(energy) AS lowest_energy
    FROM spotify
    GROUP BY album
)
SELECT 
    album,
    (highest_energy - lowest_energy) AS energy_variance
FROM album_energy_stats
ORDER BY energy_variance DESC;

-- Q14: Find tracks where the energy-to-liveness ratio is > 1.2
SELECT track, artist, (energy / liveness) AS energy_liveness_ratio
FROM spotify
WHERE liveness > 0 AND (energy / liveness) > 1.2;

-- Q15: Cumulative sum of likes ordered by views
SELECT track, views, likes,
       SUM(likes) OVER(ORDER BY views DESC) AS cumulative_likes
FROM spotify;
-- Creating Index to optimize filtering performance
CREATE INDEX idx_spotify_artist ON spotify(artist);

-- Verifying Optimization
EXPLAIN ANALYZE 
SELECT artist, track, views 
FROM spotify 
WHERE artist = 'Drake';
