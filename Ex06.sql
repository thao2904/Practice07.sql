SELECT
COUNT(*) AS payment_count FROM
(SELECT merchant_id, credit_card_id, amount, COUNT(*)
transaction_timestamp, 
LAG(transaction_timestamp) OVER (PARTITION BY merchant_id,
credit_card_id, amount ORDER BY transaction_timestamp) 
AS previous_transaction,
EXTRACT(EPOCH from transaction_timestamp  -
LAG(transaction_timestamp) OVER (PARTITION BY merchant_id,
credit_card_id, amount ORDER BY transaction_timestamp)) / 60
AS time_diff
FROM transactions AS b 
GROUP BY merchant_id, credit_card_id, amount, transaction_timestamp) AS a         
WHERE previous_transaction IS NOT NULL
AND time_diff <= 10
