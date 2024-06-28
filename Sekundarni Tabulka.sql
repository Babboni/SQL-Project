CREATE TABLE t_lenka_babboni_project_SQL_secondary_final
SELECT 
	e.country,
	e.`year` AS measured_year,
	e2.`year` AS previous_measured_year,
	e.GDP, 
	e2.GDP AS GDP_previous_year,
	round((e.GDP - e2.GDP) / e2.GDP * 100,2) AS GDP_difference_percent
FROM economies e
JOIN economies e2 
	ON e.`year` = e2.`year`+ 1
	AND e.country = e2.country 
WHERE 
	e.country LIKE 'czech republic' 
	AND e.`year` BETWEEN 2006 AND 2018
GROUP BY 
	e.country,
	e.`year`,
	e2.`year`,
	e.GDP,
	e2.GDP;