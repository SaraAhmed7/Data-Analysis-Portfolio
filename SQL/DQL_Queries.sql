/* =====================================================
   Author: SaraAhmed
   Database: SQL SERVER
   Sample DB: Customers.csv, Order.csv
   File: DQL_Queries
   Description: This file contains SQL Data Query Language (DQL) 
                statements such as SELECT with filtering, 
                sorting and aggregation
                and analyze data from Customers and Orders tables.
   ===================================================== */

-- Retrieve customers with a score not equal to 0

select * 
from Customers
where score != 0;

-- Retrieve customers from Germany
select * 
from Customers
where country = 'Germany';

-- Retrieve the name and country of customers from Germany

select firstname,lastname,country
from Customers
where country = 'Germany';
---- Retrieve all customers from either Germany or the USA.

select * 
from Customers
where country = 'Germany' or country = 'USA';

-- Retrieve all customers with a score not less than 500.
SELECT *
from Customers
where score !< 500;

-- Find all customers whose first name starts with 'M'.

SELECT *
from Customers
where firstname LIKE 'M%';
-- Find all customers whose first name ends with 'n'.

SELECT *
from Customers
where firstname LIKE '%n';

-- Find all customers whose first name contains 'r'.
SELECT *
from Customers
where firstname LIKE '%r%';

-- Find all customers whose first name has 'r' in the third position.

SELECT *
from Customers
where firstname LIKE '__r%';



-- Retrieve all customers whose score falls in the range between 100 and 500.

SELECT *
from Customers
where score between 100 and 500;



--Retrieve All Order Data
select * 
from Orders;

select firstname,lastname,country,score
from Customers;

-------------------------------------------------------------------------------
-- Retrieve all customers and sort the results by the highest score first. 

select *
from Customers
order by score desc;

-- Retrieve all customers and sort the results by the lowest score first. 
select *
from Customers
order by score asc;

-- Retrieve all customers and sort the results by the country. 
select *
from Customers
order by country ;

/* Retrieve all customers and 
   sort the results by the country and then by the highest score. */
  
select *
from Customers
order by country asc, score desc ;

/* Retrieve the name, country, and score of customers 
   whose score is not equal to 0
   and sort the results by the highest score first. */

   select firstname, country,score
   from Customers 
   where score != 0
   order by score desc;


   -----------------------------------------------
   -- Find the total score for each country
   select country, sum(score) as totalScore
   from Customers
   group by country;

/* This will not work because 'first_name' is neither part of the GROUP BY 
   nor wrapped in an aggregate function. SQL doesn't know how to handle this column. */


-- Find the total score and total number of customers for each country
select country, count(customerId) as numberOfCustomers, sum(score) as totalScore
from Customers
group by country;
------------------------------------------------------------------------

/* Find the average score for each country
   and return only those countries with an average score greater than 430 */

   select country , avg(score) as avgScore
   from Customers
   Group by country
   Having avg(score) > 430

/* Find the average score for each country
   considering only customers with a score not equal to 0
   and return only those countries with an average score greater than 430 */

   select country , avg(score) as avgScore
   from Customers
   where score IS NOT NULL and score != 0
   Group by country
   Having avg(score) > 430

   -----------------------------------------------------------------------------------

   -- Return Unique list of all countries

   select distinct country
   from Customers;


   
-- Retrieve the Top 3 Customers with the Highest Scores

select top 3*
from Customers
order by score desc

-- Retrieve the Lowest 2 Customers based on the score
select top 2*
from Customers
order by score asc

-- Get the Two Most Recent Orders
SELECT top 2*
FROM Orders
order by OrderDate desc;



/* Calculate the average score for each country 
   considering only customers with a score not equal to 0
   and return only those countries with an average score greater than 430
   and sort the results by the highest average score first. */

   select country, avg(score) as avgScore
   from Customers
   where score is not null and score != 0
   Group by country
   Having avg(score) > 430
   order by avgScore;


  

   
