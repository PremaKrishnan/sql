/* Write a query to show a list of all of the information about publishers. 
This is stored in the publisher table.*/

SELECT * FROM publisher;

/*Write a query to show a list of all of the publisher names. 
This is stored in the publisher table.*/

SELECT 
publisher_name
FROM publisher;

/*Write a query to show a list of customers in the database.
 However, only the name and email fields need to be shown, and not the id. */
 SELECT * FROM customer;
 SELECT 
 first_name,
 last_name,
 email
 FROM customer;
 
 /*Write a query to find all customers that have a first name of Jane.
 For these customers, show the first name, last name, and email address.*/
 SELECT 
 first_name,
 last_name
 email 
 FROM customer
 WHERE first_name='Jane';
 
/* Your manager has a feeling that books with a certain number of pages should be promoted more.
They have asked you to write a query to find the book ID and title of all books with exactly 208 pages.*/

SELECT 
book_id,
title
FROM book
WHERE num_pages=208;

/*Your manager wants to find some information about books published on a significant date in their history.
They have asked you to write a query to find the book ID, title, and ISBN of all books published on 5th September 2006.*/
SELECT 
book_id,
title,
isbn13
FROM book
WHERE publication_date='20060905';