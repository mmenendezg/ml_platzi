-- Obtain the latest date

SELECT
	fecha_incorporacion
FROM
	alumnos
ORDER BY
	fecha_incorporacion DESC
LIMIT 1;

-- Obtain the latest date order by carrera_id
SELECT
	carrera_id,
	MAX(fecha_incorporacion) AS date_incorporation
FROM
	alumnos
GROUP BY
	carrera_id
ORDER BY
	carrera_id;

/*
 ** Obtain the minimum value for nombre of alumno of the table, and the minimum grouped by tutor_id
 */
SELECT
	nombre
FROM
	alumnos
ORDER BY
	nombre ASC
LIMIT 1;

SELECT
	tutor_id,
	MIN(nombre) AS primer_alumno
FROM
	alumnos
GROUP BY
	tutor_id
ORDER BY
	tutor_id;