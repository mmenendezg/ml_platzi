-- Ranges in SQL

SELECT
	*
FROM
	alumnos
WHERE
	tutor_id in(1, 2, 3, 4);

SELECT
	*
FROM
	alumnos
WHERE
	tutor_id >= 1
	AND tutor_id <= 10;

SELECT
	*
FROM
	alumnos
WHERE
	tutor_id BETWEEN 1 AND 10;

-- Using numerical functions in SQL

SELECT int4range(10, 20) @> 15;

SELECT numrange(11.1, 22.2) && numrange(20.0, 30.0); 
-- Obtain the highest value in a RANGE

SELECT LOWER(int8range(15,25));

SELECT int4range(10, 20) * int4range(15, 25);

SELECT
	isempty(numrange(1, 5));

-- Obtain the alumnos where the tutor_id is between 10 and 20 
SELECT
	*
FROM
	alumnos
WHERE
	int4range(10, 20) @> tutor_id;

/*
 ** Obtain the intersection between the tutor_id and the carrera_id
 */
SELECT
	numrange(MIN(tutor_id), MAX(tutor_id)) * numrange(MIN(carrera_id), MAX(carrera_id)) AS intersection
FROM
	alumnos;