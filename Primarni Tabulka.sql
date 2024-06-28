CREATE TABLE t_lenka_babboni_project_sql_primary_final
SELECT
	cpib.name AS industry_category,
	cpay.value AS average_gross_salary,
	cpay.payroll_year,
	cpc.name AS grocery_category, 
	cp.value AS grocery_price,
	YEAR(cp.date_from) AS grocery_price_measured_from   
FROM czechia_price cp
JOIN czechia_payroll cpay
    ON YEAR(cp.date_from) = cpay.payroll_year 
    AND cpay.value_type_code = 5958
    AND cp.region_code IS NULL
JOIN czechia_price_category cpc
    ON cp.category_code = cpc.code
    AND cp.region_code IS NULL
JOIN czechia_payroll_industry_branch cpib
    ON cpay.industry_branch_code = cpib.code
WHERE 
	cpay.payroll_year BETWEEN 2006 AND 2018
GROUP BY
	cpib.name,
	cpay.payroll_year,
	cpc.name,
	YEAR(cp.date_from);