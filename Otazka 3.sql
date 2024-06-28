-- Otazka 3 - Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?

WITH abc AS 
	(SELECT
		grocery_category ,
		avg(grocery_price) AS avg_grocery_price,
		grocery_price_measured_from 
	FROM t_lenka_babboni_project_sql_primary_final tlb
	GROUP BY
	grocery_category,
	grocery_price_measured_from)
SELECT
	a.grocery_category,
	round ((b.price_2018 - a.price_2006) / a.price_2006 * 100,0) AS price_diff_percent
FROM (
	SELECT 
		grocery_category, 
		avg_grocery_price AS price_2006,
		grocery_price_measured_from AS year_2006
	FROM abc 
	WHERE grocery_price_measured_from = 2006) a
JOIN( 
	SELECT 
		grocery_category,
		avg_grocery_price AS price_2018, 
		grocery_price_measured_from AS year_2018
	FROM abc
	WHERE grocery_price_measured_from = 2018) b
	ON 
		a.grocery_category = b.grocery_category;