SELECT category, product, total_spend FROM
(SELECT category, product, 
SUM(spend) AS total_spend, 
RANK() OVER (PARTITION BY category ORDER BY SUM(spend) DESC) as stt 
FROM product_spend 
WHERE EXTRACT(year FROM transaction_date) = 2022 
GROUP BY category, product) AS a    
WHERE stt <= 2 
