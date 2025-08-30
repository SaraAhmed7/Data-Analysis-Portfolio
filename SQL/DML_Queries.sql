--DML
-- Insert new records into the customers table

-- Insert a new record with full column values

select * from customers;

   INSERT INTO customers (customerId ,firstname, lastname, country, score) 
   VALUES( '7','Sara', 'Ahmed', 'Egypt', 1000);


  

   INSERT INTO customers (customerId ,firstname, lastname, country, score) 
   VALUES( '10','Ahmed', 'Sayed', 'Egypt', 900);


-- Insert a record with only id and first_name (other columns will be NULL or default values)

INSERT INTO customers ( customerId,firstname,country) 
   VALUES( '7','Zain','Egypt' );


-- Change the score of customer with ID 6 to 0
UPDATE Customers 
set score = 0
where customerId = 6 ; 

-- Change the score of customer with ID 10 to 0 and update the country to 'UK'
UPDATE Customers 
set country = 'UK',score = 0
where customerId = 10 ; 

 
-- Update all customers with a NULL score by setting their score to 0
UPDATE Customers
SET score = 0
Where score IS NULL;

-- Verify the update
select * from customers;

------------------------------------------
--- Select customers with an ID greater than 5 before deleting

select *
from Customers
where  customerId>5;


-- Delete all customers with an ID greater than 5

 Delete From Customers where  customerId>5;
-- Delete all data from the persons table

--Delete FROM persons;

-- Faster method to delete all rows, especially useful for large tables
truncate table Customers;
