/*Your manager wants to find all of the non-English books that the store stocks.
They have asked you to write a query to find details of books 
that are written in languages other than English (this includes all variations of English).*/

SELECT * FROM book_language;
SELECT 
b.title,
b.publication_date,
b.num_pages,
l.language_name
FROM book b
INNER JOIN book_language l ON l.language_id = b.language_id
WHERE language_code NOT IN(
SELECT 
language_code
FROM book_language
WHERE language_code LIKE 'en%');

/*Your manager was thinking about recent orders and wants to see a list of them.
They have asked you to write a query to find the details of orders, which customers placed them, 
starting with the most recent orders.*/

SELECT
c.first_name,
c.last_name,
co.order_id,
co.order_date
FROM customer c
INNER JOIN cust_order co ON co.customer_id = c.customer_id
ORDER BY order_date ASC;

/*Your manager has been asked to provide information about large orders to another department.
They have asked you to write a query to find orders that have the most books in the order, 
with the orders with most books shown first.*/

SELECT * FROM order_line;
SELECT distinct
COUNT(*) AS most_order,
order_id
FROM order_line
GROUP BY order_id
ORDER BY most_order DESC;

/*You’ve been asked by another team to find orders placed s
ince 1 July 2020 where the shipping cost more than $10.00.
`Note: the shipping_method.cost column is in $.*/

SELECT * FROM shipping_method;
SELECT 
co.order_id,
co.order_date,
s.cost,
s.method_name
FROM cust_order co
INNER JOIN shipping_method s ON s.method_id = co.shipping_method_id
WHERE order_date >= '20200701' AND s.cost > 10;

/*You’ve been asked about books and authors and your manager wants to get a list of these.
You’ll need to write a query to find a list of book titles and authors, 
sorted by the book title in alphabetical order.*/

SELECT 
b.title,
a.author_name
FROM book b
INNER JOIN book_author ba ON ba.book_id = b.book_id
INNER JOIN author a ON ba.author_id = a.author_id
ORDER BY b.title ASC;

/* Your manager has asked for a list of books and related information about languages and publishers.
You’ll need to write a query to find book titles, ISBNs, publisher names of those books, and 
the language name of those books. */
SELECT 
b.title,
b.isbn13,
p.publisher_name,
l.language_name
FROM book b
INNER JOIN book_language l ON l.language_id = b.language_id
INNER JOIN publisher p ON p.publisher_id = b.publisher_id;

/*You’ve seen some information about orders but want to know more about the books that are part of the order.
You want to write a query that shows recent orders, the dates, the books that were ordered, and 
the price of each book.*/
SELECT 
o.order_id,
o.order_date,
b.title,
ol.price
FROM cust_order o
INNER JOIN order_line ol ON ol.order_id = o.order_id
INNER JOIN book b ON b.book_id = ol.book_id
ORDER BY order_date DESC;

/*Your manager wants to know about the shipping costs of each order and 
how they compare to the total sales price of the order.
You’ll need to write a query to find the order id and date, the shipping cost, and 
the total price of all books in the order.*/

SELECT 
o.order_id,
o.order_date,
s.cost AS shipping_cost,
SUM(ol.price) AS total_price
FROM cust_order o
INNER JOIN order_line ol ON ol.order_id = o.order_id
INNER JOIN shipping_method s ON o.shipping_method_id = s.method_id
GROUP BY o.order_id,o.order_date;

/*Your manager wants to find all information about customer addresses that we have.
You’ll need to write a query to find a list of customers, addresses, the status of the address, and 
the country of the address.*/
SELECT 
c.first_name,
c.last_name,
CONCAT(a.street_number,' ',a.street_name,' ',a.city) AS cust_address,
s.address_status,
con.country_name
FROM customer c
INNER JOIN  customer_address ca ON ca.customer_id = c.customer_id
INNER JOIN address a ON a.address_id = ca.address_id
INNER JOIN address_status s ON s.status_id = ca.status_id
INNER JOIN country con ON con.country_id = a.country_id;

/*Your manager wants to know if there are any publishers whose books we don’t sell.
You’ll need to write a query to find a list of publishers 
that don’t have any of their published books in our system.*/

SELECT
p.publisher_id,
p.publisher_name 
FROM publisher p
WHERE p.publisher_id NOT IN
(SELECT publisher_id FROM book);

/* You’ve been asked to find the languages of the books that are stored in the system. 
Write a query to show all of the languages and the number of books in that language, 
including languages that have no books.*/
SELECT * FROM book_language;
SELECT 
COUNT(b.language_id) AS num_of_books,
bl.language_id,
bl.language_name
FROM book b
RIGHT JOIN book_language bl ON bl.language_id = b.language_id
GROUP BY bl.language_id, bl.language_name;

/*Someone at work was wondering about which orders have had multiple books.
 You’ve been asked to write a query to show the order date and order ID for orders that have more than one book.*/
SELECT * FROM order_line;
SELECT 
co.order_date,
co.order_id,
COUNT(o.book_id) 
FROM cust_order co 
INNER JOIN order_line o ON o.order_id = co.order_id
GROUP BY co.order_date, co.order_id
HAVING COUNT(o.book_id) >= 1;

/*You’ve been asked about order details for a specific month. 
Write a query that shows order information (ID and date), customer information (ID, name, email) 
and the shipping method for all orders in March 2021*/

SELECT
o.order_id,
o.order_date,
c.customer_id,
c.first_name,
c.last_name,
c.email,
m.method_name
FROM cust_order o 
INNER JOIN customer c ON c.customer_id = o.customer_id
INNER JOIN shipping_method m ON m.method_id = o.shipping_method_id
WHERE o.order_date >= '20210301' AND o.order_date <= '20210401';

/*Your company is preparing something for the author Margaret Weis. 
You’ve been asked to find a list of all books that Margaret Weis has written.*/

SELECT
b.title,
b.isbn13
FROM book b
INNER JOIN book_author ba ON ba.book_id = b.book_id
INNER JOIN author a ON a.author_id = ba.author_id
WHERE author_name = 'Margaret Weis';

/*Someone else in your team is creating a report of books and authors, 
but they are seeing the books shown on separate rows. They have asked you to help,
to write a query that shows the book ISBN and title and a list of all authors for the book in a single result.*/
SELECT
b.title,
b.isbn13,
GROUP_CONCAT(a.author_name) AS author_list
FROM book b
INNER JOIN book_author ba ON ba.book_id = b.book_id
INNER JOIN author a ON a.author_id = ba.author_id
GROUP BY b.title, b.isbn13;

/*You’ve been asked to help out with creating a report by writing a query 
to show the top 10 orders based on the total price.*/
SELECT 
order_id,
book_id,
SUM(price) AS total_price
FROM order_line
GROUP BY order_id,book_id
ORDER BY total_price DESC
LIMIT 10;

/*The company wants a new report based on an existing one. 
They want to see the top 10 orders, but want it based on the number of books in the order.*/
SELECT
order_id,
count(book_id) AS num_of_books
FROM order_line 
GROUP BY order_id
ORDER BY num_of_books DESC
LIMIT 10;

/*Someone has asked for a list of books that have been sold and their prices,
 but they only want to see the books that were sold higher than the average sale price for all books. 
You’ll write a query to get this list.*/
SELECT
ol.order_id,
b.title,
ol.price
FROM order_line ol 
INNER JOIN book b ON ol.book_id = b.book_id 
WHERE ol.price > (
  SELECT AVG(o.price)
  FROM order_line o
);

/*A team member needs help with a query. They have been asked to show all book sales, 
but only where each book has been sold for a price higher than the average sale price for that book.
So, if Book A has an average sale price of $10, then show all orders that were sold for that book for more than $10.
 If Book B has an average sale price of $15, then show all orders for that book where the price is more than $15.*/
 
SELECT
ol.order_id,
b.title,
ol.price
FROM order_line ol 
INNER JOIN book b ON ol.book_id = b.book_id 
WHERE ol.price > (
  SELECT AVG(o.price)
  FROM order_line o
  WHERE o.book_id = ol.book_id 
)
ORDER BY b.title ASC;

/*The system stores a history of order statuses, such as when the order was received and delivered.
You’ve been asked to show a list of orders and their history, with each step in an order shown in date order.*/
SELECT * FROM order_history;
SELECT 
h.order_id,
c.first_name,
c.last_name,
o.order_date,
h.status_date,
s.status_value
FROM order_history h
INNER JOIN cust_order o ON o.order_id = h.order_id
INNER JOIN order_status s ON s.status_id = h.status_id
INNER JOIN customer c ON c.customer_id = o.customer_id
ORDER BY h.order_id ASC, h.status_date ASC;