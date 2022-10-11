-- Create a duplicate value for testing purposes only 
INSERT into alumnos values (1001,'Vincent', 'Blizard', 'vblizard1d@phpbb.com', 3000, '2018-05-12 03:28:38', 3, 1);

-- Looking for the duplicates rows with equal id
SELECT
	*
FROM
	alumnos AS ou
WHERE (
	SELECT
		COUNT(*)
	FROM
		alumnos AS inr
	WHERE
		ou.id = inr.id) > 1;

SELECT
	COUNT(*)
FROM
	alumnos
GROUP BY
	alumnos.nombre,
	alumnos.apellido,
	alumnos.email,
	alumnos.colegiatura,
	alumnos.fecha_incorporacion,
	alumnos.carrera_id,
	alumnos.tutor_id
HAVING
	COUNT(*) > 1;

SELECT
	id
FROM (
	SELECT
		ROW_NUMBER() OVER (PARTITION BY nombre,
			apellido,
			email,
			colegiatura,
			fecha_incorporacion,
			carrera_id,
			tutor_id ORDER BY id ASC) AS row_id,
		*
	FROM
		alumnos) AS duplicados
WHERE
	duplicados.row_id > 1;

/*
 ** Delete the duplicated row
 */
DELETE FROM alumnos
WHERE id IN(
		SELECT
			id FROM (
				SELECT
					ROW_NUMBER() OVER (PARTITION BY nombre, apellido, email, colegiatura, fecha_incorporacion, carrera_id, tutor_id ORDER BY id ASC) AS row_id, * FROM alumnos) AS duplicados
			WHERE
				duplicados.row_id > 1);