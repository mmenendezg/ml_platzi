-- Obtain only the rows in a subset

SELECT * 
FROM (
	SELECT ROW_NUMBER() over() as row_id, *
	from alumnos
) as alumnos_with_rows
WHERE row_id IN (1,5,10,12,15,20);

-- Obtain the alumnos where the tutor_id = 30

SELECT
	*
FROM
	alumnos
WHERE
	id IN(
		SELECT
			id FROM alumnos
		WHERE
			tutor_id = 30);

/*
 ** Obtain the records where the tutor_id is different than 30
 */
 
SELECT
	*
FROM
	alumnos
WHERE
	id NOT in(
		SELECT
			id FROM alumnos
		WHERE
			tutor_id = 30);

SELECT
	*
FROM
	alumnos AS a
	LEFT JOIN (
		SELECT
			id
		FROM
			alumnos
		WHERE
			tutor_id = 30) AS b ON a.id = b.id
where b.id IS NULL
ORDER BY
	a.tutor_id;