use chess_db;
SELECT 
    gd.move_count AS number_of_moves,
    pb.username AS black_player,
    pb.rating AS black_player_rating,
    pw.username AS white_player,
    pw.rating AS white_player_rating
FROM Game g
JOIN Players pw ON g.white = pw.username
JOIN Players pb ON g.black = pb.username
JOIN Game_details gd ON g.game_id = gd.game_id
WHERE gd.moves LIKE '1. e4 c5%'
