-- Otazka cislo 5 - Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo násdujícím roce výraznějším růstem?

WITH abc AS (
	SELECT 
		payroll_year,
		round(avg(average_gross_salary),0) AS avg_gross_salary,
		grocery_price_measured_from,
		round(avg(grocery_price),0) AS avg_grocery_price
	FROM t_lenka_babboni_project_sql_primary_final tlb
	GROUP BY
		payroll_year,
		grocery_price_measured_from)	
SELECT
	a.payroll_year AS measured_year,
	tlb2.GDP_difference_percent,
	round((a.avg_gross_salary - a2.avg_gross_salary)/a2.avg_gross_salary * 100,2) AS salary_difference_percent,
	round((a.avg_grocery_price - a2.avg_grocery_price) / a2.avg_grocery_price * 100,2) AS grocery_difference_percent	
FROM abc a
JOIN  abc a2
	ON a.payroll_year = a2.payroll_year + 1
	AND a.grocery_price_measured_from = a2.grocery_price_measured_from + 1
JOIN t_lenka_babboni_project_sql_secondary_final tlb2
	ON a.payroll_year = tlb2.measured_year; 
