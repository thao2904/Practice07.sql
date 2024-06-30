SELECT user_id, spend,transaction_date from 
(SELECT user_id, spend, transaction_date,
ROW_NUMBER () OVER (PARTITION BY user_id ORDER BY transaction_date) AS stt 
FROM transactions) AS a 
WHERE stt = 3
