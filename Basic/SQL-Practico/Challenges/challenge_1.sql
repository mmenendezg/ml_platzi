-- Obtain the first row in the table
SELECT
	*
FROM
	alumnos FETCH FIRST 1 ROWS ONLY;

SELECT
	*
FROM
	alumnos
LIMIT 1;

SELECT
	*
FROM (
	SELECT
		ROW_NUMBER() OVER () AS row_id,
		*
	FROM
		alumnos) AS alumnos_with_row_number
WHERE
	row_id = 1;

/*
 ** Obtain the first 5 records in the table
 */
SELECT
	*
FROM
	alumnos FETCH FIRST 5 ROWS ONLY;

SELECT
	*
FROM
	alumnos
LIMIT 5;

SELECT
	*
FROM (
	SELECT
		ROW_NUMBER() OVER () AS row_id,
		*
	FROM
		alumnos) AS alumnos_with_row_number
WHERE
	row_id <= 5;