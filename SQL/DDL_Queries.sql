

/* =====================================================
   Author: SaraAhmed
   Database: SQL SERVER
   Sample DB: infodb -- simple DB created by me
   File: DDL_Queries
   Description: This file contains SQL Data Definition Language (DDL) 
                statements such as CREATE, ALTER, and DROP to define 
                and manage the structure of the database objects.
   ===================================================== */

CREATE DATABASE infodb;


/* Create a new table called persons 
   with columns: id, person_name, birth_date, and phone */

Create table persons (

id int primary key,
person_name VarChar(50) not null,
birth_date date not null,
phone varchar(15) not null
);

INSERT INTO persons(id, person_name, birth_date, phone)
VALUES(1,'SARA AHMED', 30/01/2003, 01154688992 );

-- Add a new column called email to the persons table
-- Remove the column phone from the persons table

Alter table persons 
Add email varchar(30);

select *
from persons;

Alter table persons 
Drop column phone;



-- Delete the table persons from the database

Drop TABLE persons;

