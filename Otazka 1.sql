-- OTAZKA 1 - Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?

WITH abc AS (
	SELECT 
		industry_category,
		payroll_year,
		round(avg(average_gross_salary),0) AS avg_gross_salary
	FROM t_lenka_babboni_project_sql_primary_final tlb
	GROUP BY
	industry_category,
	payroll_year)
SELECT 
	a.industry_category,
	a.payroll_year,
	a.avg_gross_salary AS avg_salary,
	a2.avg_gross_salary AS avg_salary_previous_year,	
	a.avg_gross_salary - a2.avg_gross_salary AS salary_difference
FROM abc a
JOIN abc a2
	ON a.industry_category = a2.industry_category
	AND a.payroll_year = a2.payroll_year + 1;
	
