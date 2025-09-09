


/* =====================================================
   Author: SaraAhmed
   Database: SQL SERVER
   Sample DB: uber --> downloaded from Kaggle
   File: analyze_uber_bookings
   Description: 
   ===================================================== */

-- 1. Find the total number of bookings.



SELECT count(Booking_ID) as total_number_of_bookings
FROM Bookings;



-- 2. Find the number of 'Completed' bookings vs. 'Cancelled' bookings.




SELECT 
    Case
     WHEN Booking_Status = 'Completed' then 'Completed'
     WHEN Booking_Status IN('Cancelled by Customer', 'Cancelled by Driver') then 'Cancelled'
     END As Booking_Status_Group,
    
  FORMAT(COUNT(*), 'N0') as Total_bookings
FROM Bookings
WHERE  Booking_Status IN ('Completed', 'Cancelled by Customer', 'Cancelled by Driver')
GROUP BY 

     Case
     WHEN Booking_Status = 'Completed' then 'Completed'
     WHEN Booking_Status IN('Cancelled by Customer', 'Cancelled by Driver') then 'Cancelled'
     END;




-- 3. Calculate the percentage of 'Completed' bookings out of total bookings.


SELECT FORMAT(Count(Booking_Status), 'N0') AS COMPLETED
        FROM Bookings
        WHERE Booking_Status = 'Completed';  --91,517


SELECT FORMAT(COUNT(Booking_ID),'N0') --147,580
         FROM Bookings


SELECT FORMAT(
        (SELECT Count(Booking_Status)
        FROM Bookings
        WHERE Booking_Status = 'Completed') * 100.0
        / 
        (SELECT COUNT(Booking_ID)
         FROM Bookings
        ),'N2' )+ '%' as Percentage_Of_Completed_Bookings;




-- 4. Count how many bookings started from each Pickup Location.



SELECT Pickup_Location, count(*) as Total_Bookings
FROM Bookings
Group by Pickup_Location;




-- 5. Identify which Pickup Location has the highest cancellation rate.

SELECT TOP 1 Pickup_location,FORMAT(
SUM(CASE
    When  Booking_Status IN ('Cancelled by Customer','Cancelled by Driver') Then 1
    else 0
    END) *100 / COUNT(*), 'N0') + '%' AS Cancellation_Rate
FROM Bookings
group by Pickup_location
Order by Cancellation_Rate desc ;




-- 6. Calculate the average Ride Distance for completed rides.


 SELECT FORMAT(AVG(Ride_Distance), 'N2') as AVG_Distance_Completed_Rides
 FROM Bookings
 where Booking_Status = 'Completed'

-- 7. Find the distribution of bookings by hour of the day.
 select DATEPART(Hour , Time) as hourpart , count(Booking_ID) as Total_Bookings
 from Bookings 
 group by DATEPART(Hour , Time)
 Order By Total_Bookings Desc;


-- 9. Calculate the average Booking Value for completed rides.

SELECT Avg(Booking_Value)
FROM Bookings
WHERE Booking_Status = 'Completed';


-- 13. Calculate the percentage of rides cancelled by customers.

select 
Format(SUM(Case
    when Booking_Status = 'Cancelled by Customer' then 1
    else 0
END)*100 / COUNT(*), 'N0')+'%' AS Cancelled_Booking_Percentage
from Bookings;


-- 14. Calculate the percentage of rides cancelled by drivers.

select 
Format(SUM(Case
    when Booking_Status = 'Cancelled by Driver' then 1
    else 0
END)*100 / COUNT(*), 'N0')+'%' AS Cancelled_Booking_Percentage
from Bookings;


-- 15. Identify the most common reason for customer cancellations.
Select Top 1 Reason_for_cancelling_by_Customer, count(Reason_for_cancelling_by_Customer) as Count_of_Reasons
From Bookings
where Reason_for_cancelling_by_Customer Is not NULL 
AND Reason_for_cancelling_by_Customer not IN ('null')
Group by Reason_for_cancelling_by_Customer
Order by Count_of_Reasons Desc;

-- 16. Identify the most common reason for driver cancellations.
Select Top 1 Driver_Cancellation_Reason, count(Driver_Cancellation_Reason) as Count_of_Reasons
From Bookings
where Driver_Cancellation_Reason Is not NULL 
AND Driver_Cancellation_Reason not IN ('null')
Group by Driver_Cancellation_Reason
Order by Count_of_Reasons Desc;


-- 17. Find the average Driver Rating across all completed rides.
Select Format(Avg(Driver_Ratings), 'N0') AS AVG_Driver_Rating_Complete_Rides
From Bookings
where Booking_Status = 'Completed'

-- 18. Find the average Customer Rating across all completed rides.
Select Format(Avg(Customer_Rating), 'N0') AS AVG_Customer_Rating_Complete_Rides
From Bookings
where Booking_Status = 'Completed'

-- 19. Compare the usage of different Payment Methods.

select Payment_Method, COUNT(Payment_Method) as Total_Transactions
from Bookings
where Payment_Method NOT IN ('NULL', 'null') AND Payment_Method is not NULL 
Group by Payment_Method
Order by Total_Transactions DESC;

-- 20. Find the top 5 customers by total Booking Value.
SELECT TOP 5 Customer_ID, Booking_Value
FROM Bookings
Order by Booking_Value Desc;


-- 21. Find the total revenue generated from completed rides.
Select Format(SUM(Booking_Value), 'N0') AS Total_Revenue
From Bookings
Where Booking_Status = 'Completed';

-- 22. Calculate the average revenue per ride.

select AVG(Booking_Value) AS AVG_Revenue_Per_Ride
from Bookings
where Booking_Status = 'Completed';

-- 23. Identify the top 5 Pickup Locations by total revenue.

select TOP 5 Pickup_Location,FORMAT( sum(Booking_Value), 'N0') as Total_Revenue
from Bookings
where Booking_Status = 'Completed'
Group by Pickup_Location
Order by Total_Revenue DESC;

-- 24. Identify the top 5 Drop Locations by total revenue.

select TOP 5 Drop_Location,FORMAT( sum(Booking_Value), 'N0') as Total_Revenue
from Bookings
where Booking_Status = 'Completed'
Group by Drop_Location
Order by Total_Revenue DESC;

-- 25. Find the hour  with the highest average cancellation rate.

select TOP 1 DATEPART(HOUR, Time) AS hour_with_highest_cancellation_rate, 
SUM(CASE
    When Booking_Status IN( 'Cancelled by Customer','Cancelled by Driver') THEN 1
    ELSE 0
END)*100 / COUNT(*) as Avg_Cancellation_Rate
from Bookings
Group by DATEPART(HOUR, Time)
Order by Avg_Cancellation_Rate DESC;



-- 27. Find the vehicle type that generates the highest revenue.
SELECT TOP 1 Vehicle_Type, FORMAT(SUM(Booking_Value),'N0') AS Total_Revenue
FROM Bookings
Group by Vehicle_Type
Order by Total_Revenue DESC;

-- 28. Compare the average Booking Value between different Payment Methods.

SELECT Payment_Method, AVG(Booking_Value) as Avg_Revenue
FROM Bookings
WHERE Payment_Method NOT IN ( 'NULL','null') or Payment_Method != null AND Booking_Value != 0
GROUP BY Payment_Method
ORDER BY Avg_Revenue Desc;

-- 29. Identify the longest ride distance recorded.

SELECT TOP 1 
  Pickup_Location, 
  Drop_Location, 
  Booking_Value,
  Ride_Distance AS Longest_Ride_Distance
FROM 
  Bookings
ORDER BY 
  Ride_Distance DESC;

-- 30. Identify the shortest ride distance recorded.
SELECT TOP 1 
  Pickup_Location, 
  Drop_Location, 
  Booking_Value,
  Ride_Distance AS Longest_Ride_Distance
FROM 
  Bookings
ORDER BY 
  Ride_Distance ASC;

-- 31. Find the average ride distance by Vehicle Type.
SELECT
    Vehicle_Type,
    avg(Ride_Distance) as AVG_Ride_Distance
FROM 
    Bookings
GROUP BY 
    Vehicle_Type
ORDER BY avg(Ride_Distance);

-- 32. Find the percentage of incomplete rides out of total rides.
SELECT 
    Format(
    Sum(
        CASE 
            When Booking_Status = 'Incomplete' then 1
            else 0
    END)*100 / COUNT(*), 'N0') + '%' AS Incomplete_Rides_Percentage 
FROM 
    Bookings;


-- 33. Identify the most common reason for incomplete rides.
SELECT TOP 1
    Incomplete_Rides_Reason, COUNT(Incomplete_Rides_Reason) AS Repetition_Number
FROM Bookings
WHERE Incomplete_Rides_Reason != null or Incomplete_Rides_Reason not in ('NULL', 'null')
GROUP BY Incomplete_Rides_Reason
ORDER BY Repetition_Number Desc;

-- 34. Compare customer ratings vs. driver ratings for completed rides.

SELECT Format(Driver_Ratings, 'N1') AS DriverRating, Format(Customer_Rating, 'N1') as CustomerRating
FROM Bookings
Where Booking_Status = 'Completed'
;

-- 37. Compare average Booking Value between Completed vs. Incompleted rides.

SELECT Booking_Status ,round( AVG(Booking_Value), 2) as Avg_Booking_Value
FROM Bookings
Where Booking_Status = 'Completed' or Booking_Status= 'Incomplete'
Group by Booking_Status;



-- 40. Find the peak hours where 'No Cars Available' (if applicable) occurs most frequently.

SELECT  Driver_Cancellation_Reason, Count(DATEPART(Hour, Time))
FROM Bookings
GROUP BY Count(DATEPART(Hour, Time));