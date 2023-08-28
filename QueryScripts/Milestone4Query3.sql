use chess_db;
WITH RatingRanges AS (
    SELECT 
        g.game_id,
        gd.time_control,
        CASE
            WHEN p.rating < 2000 THEN '<2000'
            WHEN p.rating BETWEEN 2000 AND 2049 THEN '2000-2049'
            WHEN p.rating BETWEEN 2050 AND 2099 THEN '2050-2099'
            WHEN p.rating BETWEEN 2100 AND 2149 THEN '2100-2149'
            WHEN p.rating BETWEEN 2150 AND 2199 THEN '2150-2199'
            WHEN p.rating BETWEEN 2200 AND 2249 THEN '2200-2249'
            WHEN p.rating BETWEEN 2250 AND 2299 THEN '2250-2299'
            WHEN p.rating BETWEEN 2300 AND 2349 THEN '2300-2349'
            WHEN p.rating BETWEEN 2350 AND 2399 THEN '2350-2399'
            ELSE '2400 and above'
        END AS rating_range
    FROM Game g
    JOIN Players p ON g.white = p.username OR g.black = p.username
    JOIN Game_details gd ON g.game_id = gd.game_id
),
TimeControlCounts AS (
    SELECT 
        rating_range,
        time_control,
        COUNT(game_id) AS games_played
    FROM RatingRanges
    GROUP BY rating_range, time_control
)
SELECT 
    rating_range,
    time_control,
    MAX(games_played) as games_played
FROM TimeControlCounts
GROUP BY rating_range
ORDER BY FIELD(rating_range, '<2000', '2000-2049', '2050-2099', '2100-2149', '2150-2199', '2200-2249', '2250-2299', '2300-2349', '2350-2399', '2400 and above');
