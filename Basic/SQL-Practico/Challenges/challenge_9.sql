-- Get the differences
SELECT
	carrera_id,
	COUNT(*) AS cuenta
FROM
	alumnos
GROUP BY
	carrera_id
ORDER BY
	cuenta DESC;

-- Left join exclusive
SELECT
	a.nombre,
	a.apellido,
	a.carrera_id,
	c.id,
	c.carrera
FROM
	alumnos AS a
	LEFT JOIN carreras AS c ON a.carrera_id = c.id
WHERE
	c.id IS NULL
ORDER BY
	a.carrera_id;

/*
**	Make a full outer join to retrieve all the information from both tables
*/
SELECT
	a.nombre,
	a.apellido,
	a.carrera_id,
	c.id,
	c.carrera
FROM
	alumnos AS a
	FULL OUTER JOIN carreras AS c ON a.carrera_id = c.id
ORDER BY
	a.carrera_id;
