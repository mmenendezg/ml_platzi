-- Generate series

SELECT
	*
FROM
	generate_series(5, 1, - 2);

SELECT
	*
FROM
	generate_series(4, 3, - 1);

SELECT
	*
FROM
	generate_series(1.1, 4, 1.2);

SELECT
	CURRENT_DATE + s.a AS dates
FROM
	generate_series(0, 14, 7) AS s (a);


-- Generate dates
SELECT
	*
FROM
	generate_series('2021-01-01 00:00:00'::TIMESTAMP, '2021-01-04 12:00:00', '10 hours');

-- Make a join with a generated 
SELECT
	a.id,
	a.nombre,
	a.apellido,
	a.carrera_id,
	s.a
FROM
	alumnos AS a
	INNER JOIN generate_series(0, 10) AS s(a) ON a.carrera_id = s.a
ORDER BY
	a.carrera_id;

/*
 ** 	Generate the triangle with generate_series
 */
-- My solution

SELECT
	repeat('*', CAST(ORDINALITY AS INT)) AS triangle
FROM
	generate_series(0, 10)
	WITH ORDINALITY;

SELECT
	lpad('*', CAST(ORDINALITY AS INT), '*'), *
FROM
	generate_series(10, 2, -2)
	WITH ORDINALITY;