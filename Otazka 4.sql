-- Otazka 4 - Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?
	
WITH abc AS (
	SELECT 
		payroll_year ,
		round(avg(average_gross_salary),0) AS avg_gross_salary,
		grocery_price_measured_from,
		round(avg(grocery_price),0) AS avg_grocery_price
	FROM t_lenka_babboni_project_sql_primary_final tlb
	GROUP BY
		payroll_year,
		grocery_price_measured_from)	
SELECT
	a.payroll_year AS measured_year,
	round((a.avg_gross_salary - a2.avg_gross_salary)/a2.avg_gross_salary * 100,0) AS salary_difference_percent,
	round((a.avg_grocery_price - a2.avg_grocery_price) / a2.avg_grocery_price * 100,0) AS grocery_difference_percent
FROM abc a
JOIN  abc a2
	ON a.payroll_year = a2.payroll_year + 1
	AND a.grocery_price_measured_from = a2.grocery_price_measured_from + 1
HAVING  
	grocery_difference_percent > 10;