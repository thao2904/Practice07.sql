-- số lần bài hát nằm trong top 10
-- rank nghệ sĩ theo số thứ tự
SELECT artist_name, artist_rank FROM
(SELECT a.artist_name,
COUNT(*) as amount,
DENSE_RANK () OVER (ORDER BY COUNT(*) DESC) AS artist_rank 
from artists AS a 
JOIN songs AS b ON a.artist_id = b.artist_id
JOIN global_song_rank AS c ON b.song_id = c.song_id 
WHERE c.rank <= 10 
GROUP BY a.artist_name ) AS d 
WHERE artist_rank <= 5
