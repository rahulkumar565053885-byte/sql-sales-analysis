# sql-sales-analysis
--create table 
drop table if exists Books;
create table Books(
Book_ID serial primary key ,
Title varchar(111),
Author varchar(111),
Genre varchar(111),
Published_year int ,
Price numeric(10,2),
Stok int 

);
select* from Books; 
-- create table customers 
drop table if exists customers;
create table Customers(
Customer_ID  serial primary key ,	
Name	varchar(111),
Email	varchar(111),
Phone	varchar(111),
City	varchar(111),
Country varchar(111)


);
select*from Customers;
-- create table order

create table Orders(


Order_ID serial primary key,
Customer_ID int references Customers(Customer_id),
Book_ID	int references Books(Book_id),
Order_Date date,
Quantity	int,
Total_Amount numeric(11,2)

);
select* from Books; 
select*from Customers;
select*from Orders;

--1. retrieve all books in the " fiction" genre:

select *from books
where genre='Fiction';

--2. find books published after the year 1950
select* from books 
where published_year>1950;

--3. list all customer from cannada

select*from customers
where country='Canada';

--4. show orders placed in november 2023

select*from Orders
where Order_date between '2023-11-01' and '2023-11-30';
select*from books;

--5. retrive the total stock of books avaiable :

select sum(stok) as stock_boooks from Books;

--6. find the details of the most expensive book

select*from books order by price desc limit 2;

select *from Books;

--7. show all customer who ordered more than 1 quantity of a books 

select*from orders
where quantity>1;

--8. retrieve all orders where the total amount exceed $20

select*from orders
where total_amount>20;

--9. list all genre available in the books table 

select distinct(genre) from books;

--10. find the book with the lowest stock 

select*from books order by stok asc limit 11;

--11. calculate the total revanue generated from all orders 

select*from orders;
select sum(total_amount) as total_revanue from orders;

-- advance qsns

--1. retrieve the total number of books sold for each genre

select * from books

select genre,count(genre) from books
 group by genre;
select* from Books; 
select*from Customers;
select*from Orders;

select b.genre, sum(o.quantity) as total_books_sold
from orders o
join books b on o.book_id=b.book_id
group by b.genre;

--2. find the avrg price of books in the 'Fantasy' genre

select*from books
SELECT
	ROUND(AVG(PRICE), 2) AS AVG_PRICE
FROM
	BOOKS
WHERE
	GENRE = 'Fantasy';

--3. list customers who have placed atleast 2 orders 

select* from customers
where quantity>=2;

select c.name,o.customer_id ,count(o.order_id) as order_count from orders o
join customers c on o.customer_id=c.customer_id
group by o.customer_id, c.name
having count(o.order_id)>=2;


--4. find the most frequently orders book
SELECT
	b.title ,o.BOOK_ID,
	COUNT(o.ORDER_ID) AS ORDER_COUNT
FROM
	ORDERS o 
	join books b on o.book_id=b.book_id
GROUP BY
	o.BOOK_ID,b.title
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

	select*from books;
	select* from orders
	select b.author,sum(o.quantity) as total_sum 
	from orders o
	join books b on b.book_id=o.book_id
	group by b.author; 


	--7. list the cities where customers who spent over $30 are located;

	select distinct c.city,total_amount
	from orders o
	join customers c on o.customer_id=c.customer_id
	where o.total_amount>30

	--8. find the customers who spent the most on orders

	select c.customer_id,c.name ,sum(o.total_amount) as total_spent
	from orders o
	join customers c on o.customer_id=c.customer_id
	group by c.customer_id,c.name
	order by total_spent desc limit 1;

	--9. calculate the stock remaining after fullfilling all orders

select 
distinct(b.book_id) ,b.title,b.stok,coalesce (sum(o.quantity),0) as total_q ,b.stok-coalesce (sum(o.quantity),0) as remaing_stock	from books b
	left join orders o on b.book_id=o.book_id
	group by b.book_id order by book_id asc;

