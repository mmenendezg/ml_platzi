SELECT
	email
FROM
	alumnos
WHERE
	email ~* '[A-Z0-9._%+-]+@google[A-Z0-9.-]+\.[A-Z]{2,4}';