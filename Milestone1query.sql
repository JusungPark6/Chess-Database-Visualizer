WITH RelevantGames AS (
    -- Identify games where both players have a rating above 2400
    SELECT g.game_id, gd.winner, gd.moves
    FROM Game g
    JOIN Players pw ON g.white = pw.username
    JOIN Players pb ON g.black = pb.username
    JOIN Game_details gd ON g.game_id = gd.game_id
    WHERE pw.rating > 2400 AND pb.rating > 2400
      AND gd.moves LIKE '1. d4 %' -- Games where White's first move is d4
),

BlackOpenings AS (
    -- Extract the black response to 1. d4 as the opening
    SELECT game_id,
           winner,
           SUBSTRING_INDEX(SUBSTRING_INDEX(moves, ' ', 3), ' ', -1) AS opening
    FROM RelevantGames
)

-- Calculate win rates for Black for each opening
SELECT opening,
       COUNT(*) AS total_games,
       SUM(CASE WHEN winner = 'Black' THEN 1 ELSE 0 END) AS black_wins,
       (SUM(CASE WHEN winner = 'Black' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS win_rate
FROM BlackOpenings
GROUP BY opening
ORDER BY win_rate DESC
LIMIT 1;
