-- OTAZKA 2 - Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?

WITH abc AS 
	(SELECT 
		average_gross_salary,
		payroll_year ,
		grocery_category ,
		grocery_price,
		grocery_price_measured_from
	FROM t_lenka_babboni_project_sql_primary_final tlb 
	WHERE grocery_category IN ('Chléb konzumní kmínový', 'Mléko polotučné pasterované')
	)
SELECT 	
	min(a.average_gross_salary) AS min_salary,
	a.payroll_year, 
	a.grocery_category,
	a.grocery_price_measured_from,
	round(avg(a.grocery_price),2) AS avg_price,
	FLOOR(MIN(a.average_gross_salary) / round(avg(a.grocery_price),2)) AS quantity
FROM abc a 
GROUP BY 
	a.payroll_year ,
	a.grocery_category
HAVING 
	a.payroll_year IN (2006, 2018)	
	AND a.grocery_price_measured_from IN (2006,2018)
ORDER BY 
	a.payroll_year;
