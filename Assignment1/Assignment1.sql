CREATE TABLE IF NOT EXISTS hc.users (
	user_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	email VARCHAR(50) NOT NULL UNIQUE,
	password VARCHAR(100) NOT NULL,
	created_by UUID,
	created_date TIMESTAMP DEFAULT now(),
	modified_by UUID,
	modified_date TIMESTAMP,
	is_active BOOLEAN NOT NULL DEFAULT TRUE,
	is_deleted BOOLEAN NOT NULL DEFAULT FALSE,
	birth_date DATE,
	address VARCHAR(300),
	mobile_number VARCHAR(20) NOT NULL
)

INSERT INTO hc.users ( first_name, last_name, email, password, birth_date, address, mobile_number) 
VALUES ('Bhargav', 'Maru', 'bhargav@gmail.com', 'bhargav123', '2005-02-02', 'porbandar', '1234567890');

SELECT * FROM hc.users;

INSERT INTO hc.users(first_name, last_name, email, password, is_active, is_deleted, birth_date, address, mobile_number)
VALUES 
('parth', 'savaliya', 'parth@gmail.com', 'parth123', TRUE, FALSE, '2003-03-09', 'dhari', '1234567899'),
('Aarsi', 'ukani', 'aarsi@gmail.com', 'aarsi123', TRUE, FALSE, '2004-03-09', 'amreli', '1237567899'),
('ankit', 'parmar', 'ankit@gmail.com', 'ankit', FALSE, TRUE, '2001-03-09', 'upleta', '3334567899'),
('Akash', 'virani', 'akash@gmail.com', 'akash123', TRUE, FALSE, '2005-03-09', 'dhari', '1234567899'),
('jay', 'odedra', 'jay@example.com', 'jay', TRUE, FALSE, '2007-03-09', 'porbandar', '2345678865'),
('keval', 'savaliya', 'keval@example.com', 'keval', TRUE, FALSE, '2003-07-09', 'bhavnagar', '1234567899'),
('riya', 'maru', 'riya@gmail.com', 'riya123', TRUE, FALSE, '2003-09-09', 'baroda', '123456646'),
('prakash', 'parmar', 'parakash@example.com', 'prakash1234', FALSE, TRUE, '2009-03-09', 'rajkot', '3334567899'),
('raj', 'baldha', 'raj@gmail.com', 'raj34', TRUE, FALSE, '2000-03-12', 'gondal', '345679876');


--SQL Queries
--i. Fetch all users
SELECT * FROM hc.users;

--ii. Fetch only user name (first_name + last_name) and email
SELECT CONCAT(first_name,' ',last_name)  AS name , email FROM hc.users;

--iii. Fetch only inactive users
SELECT first_name, last_name, email, is_active FROM hc.users WHERE is_active = FALSE;

--iv. Users whose first_name starts with 'A' and last_name ends with 'i'
SELECT first_name, last_name, email FROM hc.users WHERE first_name LIKE 'A%' AND last_name LIKE '%i'; 

--v. Users whose email contains '@example
SELECT first_name, last_name, email FROM hc.users WHERE email LIKE '%@example%';

--vi. Case-insensitive search for first_name starting with 'A'
SELECT first_name, last_name FROM hc.users WHERE first_name ILIKE 'A%';

--vii. Users ordered by created_date (descending)
SELECT first_name, last_name, created_date FROM hc.users ORDER BY created_date DESC;

--viii. Top 5 latest created users
SELECT first_name, last_name, created_date FROM hc.users ORDER BY created_date DESC LIMIT 5;

--ix. Second page of results (5 records per page)
SELECT first_name, last_name, email, created_date FROM hc.users LIMIT 5 OFFSET 5;

