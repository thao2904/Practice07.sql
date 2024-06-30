SELECT transaction_date, user_id, purchase_count FROM 
(SELECT transaction_date, user_id, COUNT(*) as purchase_count,
ROW_NUMBER () OVER (PARTITION BY user_id ORDER BY transaction_date DESC) as stt 
FROM user_transactions AS b 
GROUP BY b.transaction_date, b.user_id) AS a
WHERE stt = 1 
ORDER BY transaction_date 
