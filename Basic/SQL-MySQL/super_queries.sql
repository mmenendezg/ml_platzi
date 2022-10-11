USE curso_mysql;

-- Let's update nationality ENG to GBR as ISO standard
UPDATE
	authors
SET
	nationality = 'GBR'
WHERE
	nationality = 'ENG';

-- Obtain the total value for the books that are sellable or not
SELECT
	sellable,
	CONCAT('$', sum(price * copies))
FROM
	books
GROUP BY
	sellable;

-- Get the total of books by year
SELECT
	a.nationality,
	COUNT(book_id) AS Books,
	SUM( if(year < 1950, 1, 0)) AS `< 1950`,
	SUM( if(year >= 1950 AND year < 1990, 1, 0)) AS `< 1990`,
	SUM( if(year >= 1990 AND year < 2000, 1, 0)) AS `< 2000`,
	SUM( if(year >= 2000, 1, 0)) AS `>2000`
FROM
	books AS b
	JOIN authors AS a ON b.author_id = a.author_id
WHERE
	a.nationality IS NOT NULL
GROUP BY
	nationality
ORDER BY
	Books DESC;