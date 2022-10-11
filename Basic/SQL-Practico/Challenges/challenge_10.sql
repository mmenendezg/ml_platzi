-- Exclusive left join
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
	c.id IS NULL;

-- Left Join 
SELECT
	a.nombre,
	a.apellido,
	a.carrera_id,
	c.id,
	c.carrera
FROM
	alumnos AS a
	LEFT JOIN carreras AS c ON a.carrera_id = c.id;

-- Exclusive Right Join
SELECT
	a.nombre,
	a.apellido,
	a.carrera_id,
	c.id,
	c.carrera
FROM
	alumnos AS a
	RIGHT JOIN carreras AS c ON a.carrera_id = c.id
WHERE
	a.id IS NULL
ORDER BY
	c.id DESC;

-- Right Join 
SELECT
	a.nombre,
	a.apellido,
	a.carrera_id,
	c.id,
	c.carrera
FROM
	alumnos AS a
	RIGHT JOIN carreras AS c ON a.carrera_id = c.id
ORDER BY
	c.id DESC;

-- Inner Join 
SELECT
	a.nombre,
	a.apellido,
	a.carrera_id,
	c.id,
	c.carrera
FROM
	alumnos AS a
	INNER JOIN carreras AS c ON a.carrera_id = c.id
ORDER BY
	c.id DESC;

-- Full Outer 
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
	c.id DESC;

-- Full Outer Exclusive
SELECT
	a.nombre,
	a.apellido,
	a.carrera_id,
	c.id,
	c.carrera
FROM
	alumnos AS a
	FULL OUTER JOIN carreras AS c ON a.carrera_id = c.id
WHERE
	a.id IS NULL
	OR c.id IS NULL
ORDER BY
	a.carrera_id DESC, c.id DESC;