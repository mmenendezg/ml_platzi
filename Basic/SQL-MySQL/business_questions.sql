-- BUSINESS QUESTIONS

-- What nationalities are there?
SELECT DISTINCT
	nationality
FROM
	authors
ORDER BY nationality;

-- How many authors are there by nationality?
SELECT
	nationality,
	count(author_id) AS c_authors
FROM
	authors
WHERE
	nationality IS NOT NULL
GROUP BY
	nationality
ORDER BY
	c_authors DESC,
	nationality ASC;

-- What is the mean and standard deviation of the price of the books?
SELECT
	nationality,
	COUNT(b.book_id) AS books,
	ROUND(AVG(price), 2) AS mean_price,
	ROUND(STDDEV(price), 2) AS std_price
FROM
	books AS b
	JOIN authors AS a ON b.author_id = a.author_id
WHERE
	nationality IS NOT NULL
GROUP BY
	nationality
ORDER BY
	mean_price DESC;

-- What is the maximum and minimum price of a book?
SELECT
	a.nationality,
	MAX(b.price) AS max_price,
	MIN(b.price) AS min_price,
	ROUND(AVG(b.price), 2) AS mean_price,
	ROUND(STDDEV(b.price), 2) AS std_price
FROM
	books AS b
	JOIN authors AS a ON b.author_id = a.author_id
WHERE
	nationality IS NOT NULL
GROUP BY
	nationality
ORDER BY
	max_price DESC;

-- Final report for the transactions
SELECT
	c.name,
	o.operation_type,
	b.title,
	a.name,
	CONCAT(a.name, ' (', a.nationality, ')') AS author,
	TO_DAYS(NOW()) - TO_DAYS(o.created_at) AS ago
FROM
	operations AS o
	LEFT JOIN clients AS c ON c.client_id = o.client_id
	LEFT JOIN books AS b ON o.book_id = b.book_id
	LEFT JOIN authors AS a ON b.author_id = a.author_id;
