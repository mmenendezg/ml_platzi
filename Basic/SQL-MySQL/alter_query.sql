DESC authors;

-- Update the structure of the table authors

ALTER TABLE authors
	ADD COLUMN birthyear INTEGER DEFAULT 1930 AFTER name;

desc authors;

-- Modify the default value for birthyear

ALTER TABLE authors 
	MODIFY COLUMN birthyear year DEFAULT 1920;

DESC authors;

-- Drop the column of birthyear

ALTER TABLE authors 
	DROP COLUMN birthyear;

DESC authors;