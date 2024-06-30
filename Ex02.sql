-- Cách 1
SELECT card_name, issued_amount FROM
(SELECT card_name, issued_amount,
ROW_NUMBER () OVER (PARTITION BY card_name ORDER BY issue_year, issue_month)
AS stt from monthly_cards_issued) AS a 
WHERE stt = 1
ORDER BY issued_amount DESC 
-- Cách 2
WITH card_launch AS
(SELECT card_name,
FIRST_VALUE(issued_amount) OVER (PARTITION BY card_name
ORDER BY issue_year, issue_month) AS issued_amount
FROM monthly_cards_issued)
SELECT card_name,
MAX(issued_amount) AS issued_amount
FROM card_launch
GROUP BY card_name
ORDER BY issued_amount DESC
