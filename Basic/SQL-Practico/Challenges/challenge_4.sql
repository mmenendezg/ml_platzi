-- Extract the year from a datetime field

SELECT
	EXTRACT(YEAR FROM fecha_incorporacion) AS year_incorporacion
FROM
	alumnos;

SELECT
	DATE_PART('YEAR', fecha_incorporacion) AS year_incorporacion
FROM
	alumnos;

SELECT
	DATE_PART('YEAR', fecha_incorporacion) AS year_incorporacion,
	DATE_PART('MONTH', fecha_incorporacion) AS month_incorporacion,
	DATE_PART('DAY', fecha_incorporacion) AS day_incorporacion
FROM
	alumnos;

-- Extract the hour, minutes and seconds from a datetime field 

SELECT
	DATE_PART('YEAR', fecha_incorporacion) AS year_incorporacion,
	DATE_PART('MONTH', fecha_incorporacion) AS month_incorporacion,
	DATE_PART('DAY', fecha_incorporacion) AS day_incorporacion,
	DATE_PART('HOUR', fecha_incorporacion) AS hour_incorporacion,
	DATE_PART('MINUTE', fecha_incorporacion) AS minute_incorporacion,
	DATE_PART('SECOND', fecha_incorporacion) AS second_incorporacion
FROM
	alumnos;