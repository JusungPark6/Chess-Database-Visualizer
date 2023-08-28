use chess_db;
WITH FilteredGames AS (
    SELECT
        gd.game_id,
        gd.moves,
        p.rating AS black_rating
    FROM Game g
    JOIN Game_details gd ON g.game_id = gd.game_id
    JOIN Players p ON g.black = p.username
    WHERE gd.winner = 'White' AND p.rating > 2000 AND gd.moves LIKE '1. d4 d5 2. c4%'
),
MoveSequences AS (
    SELECT
        game_id,
        SUBSTRING_INDEX(SUBSTRING_INDEX(moves, '1. d4 d5 2. c4', -1), ' ', 11) AS next_5_moves
    FROM FilteredGames
)
SELECT
    next_5_moves,
    COUNT(*) AS count_occurrences
FROM MoveSequences
GROUP BY next_5_moves
ORDER BY count_occurrences DESC
LIMIT 10;  -- adjust this limit to get the number of sequences you want
