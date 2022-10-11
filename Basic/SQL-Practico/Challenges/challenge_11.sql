-- lpad function

SELECT lpad('sql', 15, '*');

SELECT
	lpad('*', id, '*'),
	carrera_id
FROM
	alumnos
WHERE
	id < 20
ORDER BY
	carrera_id;

SELECT
	lpad('*', CAST(row_id AS INT), '*') AS triangle
FROM (
	SELECT
		ROW_NUMBER() OVER (ORDER BY carrera_id) AS row_id,
		*
	FROM
		alumnos) AS alumnos_with_row_id
WHERE
	row_id <= 20
ORDER BY
	carrera_id;

/*
** Using rpad function instead
*/

SELECT
	rpad('sql', CAST(row_id AS INT), '*') AS triangle
FROM (
	SELECT
		ROW_NUMBER() OVER (ORDER BY carrera_id) AS row_id,
		*
	FROM
		alumnos) AS alumnos_with_row_id
WHERE
	row_id <= 20
ORDER BY
	carrera_id;