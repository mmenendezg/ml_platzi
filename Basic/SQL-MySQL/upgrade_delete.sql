USE curso_mysql;

-- There are no inactive clients, Let's update 10 random clients and change to inactive
-- First let's obtain 10 random clients
SELECT
	client_id,
	name,
	active
FROM
	clients
ORDER BY
	rand()
LIMIT 10;
-- Then, Let's update the information of the customers
-- The client_id are the ids obtained in the query above
UPDATE
	clients
SET
	active = 0
WHERE
	client_id IN (800, 136, 315, 318, 531, 55, 84, 247, 705, 409);
-- Now, let's verify 
SELECT
	client_id,
	name,
	active
FROM
	clients
WHERE
	active = 0;

