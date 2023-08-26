USE db;
DESCRIBE chess_games_data_short;
SELECT * FROM chess_data;

#import script for Players Table
ALTER TABLE Players
MODIFY COLUMN player_id INT AUTO_INCREMENT;
INSERT INTO Players (username, rating)
SELECT  white AS username, white_rating AS rating
FROM chess_games_data_short
ON DUPLICATE KEY UPDATE rating = VALUES(rating);
INSERT INTO Players (username, rating)
SELECT black AS username, black_rating AS rating
FROM chess_games_data_short
ON DUPLICATE KEY UPDATE rating = VALUES(rating);

SELECT * FROM Game_details;


#import script for Game Table
ALTER TABLE Game
MODIFY COLUMN game_id INT AUTO_INCREMENT;
INSERT INTO Game (white, black)
SELECT 
    TRIM(BOTH '"' FROM SUBSTRING_INDEX(game_id, ' vs ', 1)) AS white,
    TRIM(BOTH '"' FROM SUBSTRING_INDEX(game_id, ' vs ', -1)) AS black
FROM chess_games_data_short;
UPDATE Game
SET white = TRIM(LEADING ' "' FROM white);



#import script for Game_Details Table
TRUNCATE Game_details;
DESCRIBE Game_details;
SELECT * FROM Game_details;
ALTER TABLE Game_details
MODIFY COLUMN game_id INT AUTO_INCREMENT;
ALTER TABLE Game_details
MODIFY COLUMN moves LONGTEXT;
ALTER TABLE Game_details
MODIFY COLUMN result VARCHAR(1000);
ALTER TABLE Game_details AUTO_INCREMENT =1;
INSERT INTO game_details (winner, result, time_control, move_count, moves)
SELECT winner, result, time_control, move_count, moves
FROM chess_games_data_short;
