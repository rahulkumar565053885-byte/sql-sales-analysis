--create table 
DROP TABLE IF EXISTS BOOKS;

CREATE TABLE BOOKS (
	BOOK_ID SERIAL PRIMARY KEY,
	TITLE VARCHAR(111),
	AUTHOR VARCHAR(111),
	GENRE VARCHAR(111),
	PUBLISHED_YEAR INT,
	PRICE NUMERIC(10, 2),
	STOK INT
);

SELECT
	*
FROM
	BOOKS;

-- create table customers 
DROP TABLE IF EXISTS CUSTOMERS;

CREATE TABLE CUSTOMERS (
	CUSTOMER_ID SERIAL PRIMARY KEY,
	NAME VARCHAR(111),
	EMAIL VARCHAR(111),
	PHONE VARCHAR(111),
	CITY VARCHAR(111),
	COUNTRY VARCHAR(111)
);

SELECT
	*
FROM
	CUSTOMERS;

-- create table order
CREATE TABLE ORDERS (
	ORDER_ID SERIAL PRIMARY KEY,
	CUSTOMER_ID INT REFERENCES CUSTOMERS (CUSTOMER_ID),
	BOOK_ID INT REFERENCES BOOKS (BOOK_ID),
	ORDER_DATE DATE,
	QUANTITY INT,
	TOTAL_AMOUNT NUMERIC(11, 2)
);

SELECT
	*
FROM
	BOOKS;

SELECT
	*
FROM
	CUSTOMERS;

SELECT
	*
FROM
	ORDERS;

--1. retrieve all books in the " fiction" genre:
SELECT
	*
FROM
	BOOKS
WHERE
	GENRE = 'Fiction';

--2. find books published after the year 1950
SELECT
	*
FROM
	BOOKS
WHERE
	PUBLISHED_YEAR > 1950;

--3. list all customer from cannada
SELECT
	*
FROM
	CUSTOMERS
WHERE
	COUNTRY = 'Canada';

--4. show orders placed in november 2023
SELECT
	*
FROM
	ORDERS
WHERE
	ORDER_DATE BETWEEN '2023-11-01' AND '2023-11-30';

SELECT
	*
FROM
	BOOKS;

--5. retrive the total stock of books avaiable :
SELECT
	SUM(STOK) AS STOCK_BOOOKS
FROM
	BOOKS;

--6. find the details of the most expensive book
SELECT
	*
FROM
	BOOKS
ORDER BY
	PRICE DESC
LIMIT
	2;

SELECT
	*
FROM
	BOOKS;

--7. show all customer who ordered more than 1 quantity of a books 
SELECT
	*
FROM
	ORDERS
WHERE
	QUANTITY > 1;

--8. retrieve all orders where the total amount exceed $20
SELECT
	*
FROM
	ORDERS
WHERE
	TOTAL_AMOUNT > 20;

--9. list all genre available in the books table 
SELECT DISTINCT
	(GENRE)
FROM
	BOOKS;

--10. find the book with the lowest stock 
SELECT
	*
FROM
	BOOKS
ORDER BY
	STOK ASC
LIMIT
	11;

--11. calculate the total revanue generated from all orders 
SELECT
	*
FROM
	ORDERS;

SELECT
	SUM(TOTAL_AMOUNT) AS TOTAL_REVANUE
FROM
	ORDERS;

-- advance qsns
--1. retrieve the total number of books sold for each genre
SELECT
	*
FROM
	BOOKS
SELECT
	GENRE,
	COUNT(GENRE)
FROM
	BOOKS
GROUP BY
	GENRE;

SELECT
	*
FROM
	BOOKS;

SELECT
	*
FROM
	CUSTOMERS;

SELECT
	*
FROM
	ORDERS;

SELECT
	B.GENRE,
	SUM(O.QUANTITY) AS TOTAL_BOOKS_SOLD
FROM
	ORDERS O
	JOIN BOOKS B ON O.BOOK_ID = B.BOOK_ID
GROUP BY
	B.GENRE;

--2. find the avrg price of books in the 'Fantasy' genre
SELECT
	*
FROM
	BOOKS
SELECT
	ROUND(AVG(PRICE), 2) AS AVG_PRICE
FROM
	BOOKS
WHERE
	GENRE = 'Fantasy';

--3. list customers who have placed atleast 2 orders 
SELECT
	*
FROM
	CUSTOMERS
WHERE
	QUANTITY >= 2;

SELECT
	C.NAME,
	O.CUSTOMER_ID,
	COUNT(O.ORDER_ID) AS ORDER_COUNT
FROM
	ORDERS O
	JOIN CUSTOMERS C ON O.CUSTOMER_ID = C.CUSTOMER_ID
GROUP BY
	O.CUSTOMER_ID,
	C.NAME
HAVING
	COUNT(O.ORDER_ID) >= 2;

--4. find the most frequently orders book
SELECT
	B.TITLE,
	O.BOOK_ID,
	COUNT(O.ORDER_ID) AS ORDER_COUNT
FROM
	ORDERS O
	JOIN BOOKS B ON O.BOOK_ID = B.BOOK_ID
GROUP BY
	O.BOOK_ID,
	B.TITLE
ORDER BY
	ORDER_COUNT DESC;

--5. show the top 3 most expensive books of 'fantasy' genre
SELECT
	*
FROM
	BOOKS
WHERE
	GENRE = 'Fantasy'
ORDER BY
	PRICE DESC
LIMIT
	3;

--6. retrieve the total quantity of books sold by each author
SELECT
	*
FROM
	BOOKS;

SELECT
	*
FROM
	ORDERS
SELECT
	B.AUTHOR,
	SUM(O.QUANTITY) AS TOTAL_SUM
FROM
	ORDERS O
	JOIN BOOKS B ON B.BOOK_ID = O.BOOK_ID
GROUP BY
	B.AUTHOR;

--7. list the cities where customers who spent over $30 are located;
SELECT DISTINCT
	C.CITY,
	TOTAL_AMOUNT
FROM
	ORDERS O
	JOIN CUSTOMERS C ON O.CUSTOMER_ID = C.CUSTOMER_ID
WHERE
	O.TOTAL_AMOUNT > 30
	--8. find the customers who spent the most on orders
SELECT
	C.CUSTOMER_ID,
	C.NAME,
	SUM(O.TOTAL_AMOUNT) AS TOTAL_SPENT
FROM
	ORDERS O
	JOIN CUSTOMERS C ON O.CUSTOMER_ID = C.CUSTOMER_ID
GROUP BY
	C.CUSTOMER_ID,
	C.NAME
ORDER BY
	TOTAL_SPENT DESC
LIMIT
	1;

--9. calculate the stock remaining after fullfilling all orders
SELECT DISTINCT
	(B.BOOK_ID),
	B.TITLE,
	B.STOK,
	COALESCE(SUM(O.QUANTITY), 0) AS TOTAL_Q,
	B.STOK - COALESCE(SUM(O.QUANTITY), 0) AS REMAING_STOCK
FROM
	BOOKS B
	LEFT JOIN ORDERS O ON B.BOOK_ID = O.BOOK_ID
GROUP BY
	B.BOOK_ID
ORDER BY
	BOOK_ID ASC;