-- Obtain the second higher colegiatura 

SELECT DISTINCT
	colegiatura
FROM
	alumnos AS a1
WHERE
	2 = (
		SELECT
			count(DISTINCT colegiatura)
		FROM
			alumnos AS a2
		WHERE
			a1.colegiatura <= a2.colegiatura);

-- Obtain the 2nd highest colegiatura for the tutor with id = 20 

SELECT DISTINCT
	colegiatura, tutor_id
FROM
	alumnos
WHERE
	tutor_id = 20
ORDER BY
	colegiatura DESC OFFSET 1
LIMIT 1;

-- Obtain all the alumnos with the 2nd highest colegiatura and tutor id = 20

SELECT
	*
FROM
	alumnos AS datos_alumnos
	INNER JOIN ( SELECT DISTINCT
			colegiatura
		FROM
			alumnos
		WHERE
			tutor_id = 20
		ORDER BY
			colegiatura DESC OFFSET 1
		LIMIT 1) AS segunda_mayor_colegiatura ON datos_alumnos.colegiatura = segunda_mayor_colegiatura.colegiatura;

SELECT
	*
FROM
	alumnos AS datos_alumnos
WHERE
	colegiatura = ( SELECT DISTINCT
			colegiatura
		FROM
			alumnos
		WHERE
			tutor_id = 20
		ORDER BY
			colegiatura DESC OFFSET 1
		LIMIT 1);

/*
 ** Obtain the 2nd half of the table
 */
-- Just the 2nd half of the TABLE

SELECT
	ROW_NUMBER() OVER() AS row_id,
	*
FROM
	alumnos AS datos_alumnos 
OFFSET (
	SELECT
		ROW_NUMBER() OVER () AS row_id
	FROM
		alumnos ORDER BY
			row_id DESC
		LIMIT 1) / 2;

SELECT
	ROW_NUMBER() OVER () AS row_id,
	*
FROM
	alumnos AS datos_alumnos OFFSET (
		SELECT
			COUNT(*) / 2
		FROM
			alumnos);