use chess_db;
WITH FourMoveOpenings AS (
    -- Extract the first four moves for each game
    SELECT game_id,
           CONCAT(SUBSTRING_INDEX(SUBSTRING_INDEX(moves, ' ', 1), ' ', -1), ' ',
				  SUBSTRING_INDEX(SUBSTRING_INDEX(moves, ' ', 2), ' ', -1), ' ',
                  SUBSTRING_INDEX(SUBSTRING_INDEX(moves, ' ', 3), ' ', -1), ' ',
                  SUBSTRING_INDEX(SUBSTRING_INDEX(moves, ' ', 4), ' ', -1), ' ',
                  SUBSTRING_INDEX(SUBSTRING_INDEX(moves, ' ', 5), ' ', -1), ' ',
                  SUBSTRING_INDEX(SUBSTRING_INDEX(moves, ' ', 6), ' ', -1)) AS first_four_moves,
           CASE WHEN winner = 'White' THEN 1 ELSE 0 END AS white_win
    FROM Game_details
)

-- Calculate win rates for White for each sequence of four moves
SELECT first_four_moves,
       COUNT(*) AS total_games,
       SUM(white_win) AS white_wins,
       (SUM(white_win) / COUNT(*)) * 100 AS win_rate
FROM FourMoveOpenings
GROUP BY first_four_moves
ORDER BY win_rate DESC;
