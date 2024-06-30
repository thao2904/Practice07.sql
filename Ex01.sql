SELECT 
  EXTRACT(YEAR from transaction_date) AS year,
  product_id, 
  spend AS curr_year_spend, 
  LAG(spend) OVER (PARTITION BY product_id ORDER BY EXTRACT(YEAR from transaction_date)) AS prev_year_spend,
  ROUND(
    ((spend - LAG(spend) OVER (PARTITION BY product_id ORDER BY EXTRACT(YEAR from transaction_date)))/ 
    LAG(spend) OVER (PARTITION BY product_id ORDER BY EXTRACT(YEAR from transaction_date))) * 100, 2) 
    AS yoy_rate
  from user_transactions
