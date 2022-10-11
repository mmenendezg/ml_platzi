-- Create complex SELECT queries

-- Create a SELECT query and JOIN between the tables books and authors using book as pivot
SELECT b.book_id, b.title, a.author_id, a.name, b.price
FROM books as b
join authors as a 
	on a.author_id = b.author_id
WHERE a.author_id BETWEEN 1 AND 5
ORDER BY b.title;

-- Create SELECT query using INNER JOIN among operations, books, users using operations as pivot
SELECT c.name as Client, b.title as Book, a.name as Writer, t.operation_type as Operation
FROM operations as t
JOIN books as b 
	ON t.book_id = b.book_id
JOIN clients as c 
	ON t.client_id = c.client_id
JOIN authors as a 
	on b.author_id = a.author_id
WHERE c.gender = 'F' AND t.operation_type IN ('Sell', 'Rent');

-- Create SELECT query using LEFT JOIN between authors and books using authors as pivot
SELECT a.author_id as Id, a.name as Author, a.nationality as Nationality, b.title as Book
FROM `authors` as a 
LEFT JOIN books as b 
	ON a.author_id = b.author_id
WHERE a.author_id BETWEEN 1 AND 5
ORDER BY a.author_id;

-- Create SELECT query to count the books by author
SELECT a.author_id as Id, a.name as Author, a.nationality as Nationality, COUNT(b.book_id) as Books
FROM `authors` as a 
LEFT JOIN books as b 
	ON a.author_id = b.author_id
WHERE a.author_id BETWEEN 1 AND 5
GROUP BY a.author_id
ORDER BY a.author_id;