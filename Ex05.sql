WITH first_count AS
(SELECT user_id, tweet_date, tweet_count,
LAG(tweet_count, 1) OVER (PARTITION BY user_id ORDER BY tweet_date) 
AS tweet_count1,
LAG(tweet_count, 2) OVER (PARTITION BY user_id ORDER BY tweet_date) 
AS tweet_count2
from tweets) 
SELECT user_id, tweet_date,
ROUND(
CAST((tweet_count + COALESCE(tweet_count1, 0) + COALESCE(tweet_count2, 0))
AS DECIMAL)/ 
( 1+ CASE WHEN tweet_count1 IS NOT NULL THEN 1 ELSE 0 END
+ CASE WHEN tweet_count2 is NOT NULL THEN 1 ELSE 0 END) 
, 2)
AS rolling_agv_3d 
from first_count
