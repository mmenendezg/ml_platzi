-- Use the extract in the WHERE clause
SELECT
	*
FROM
	alumnos
WHERE (EXTRACT(YEAR FROM fecha_incorporacion)) = 2018;

SELECT
	*
FROM
	alumnos
WHERE (DATE_PART('YEAR', fecha_incorporacion)) = 2019;

SELECT
	*
FROM (
	SELECT
		*,
		DATE_PART('YEAR', fecha_incorporacion) AS year_incorporacion
	FROM
		alumnos) AS alumnos_with_year
WHERE
	year_incorporacion = 2020;

/*
 ** Extract the rows where the year is 2018 and month is May
 */
SELECT
	*
FROM (
	SELECT
		*,
		DATE_PART('YEAR', fecha_incorporacion) AS year_incorporacion,
		DATE_PART('MONTH', fecha_incorporacion) AS month_incorporacion
	FROM
		alumnos) AS alumnos_with_dates
WHERE
	year_incorporacion = 2018
	AND month_incorporacion = 5;

SELECT
	*
FROM
	alumnos
WHERE (EXTRACT(YEAR FROM fecha_incorporacion)) = 2018
	AND (EXTRACT(MONTH FROM fecha_incorporacion)) = 5;