--show all my data

SELECT*
FROM scooter
--------------------------------------------------------------------
--Extract the most common month
SELECT MONTH(Start_Time) AS month, COUNT(*) AS occurrences
FROM scooter
GROUP BY MONTH(Start_Time)
ORDER BY occurrences DESC
---------------------------------------------------------------------
--Extract most common day
SELECT DAY(Start_Time) AS day, COUNT(*) AS occurrences
FROM scooter
GROUP BY DAY(Start_Time)
ORDER BY occurrences DESC
----------------------------------------------------------------------

--Extract most common hour

SELECT DATEPART(HOUR,Start_Time ) AS hour, COUNT(*) AS occurrences
FROM scooter
GROUP BY DATEPART(HOUR, Start_Time)
ORDER BY occurrences DESC;
-------------------------------------------------------------
--most common start station
SELECT Start_Station, COUNT(*) AS occurrences
FROM scooter
GROUP BY Start_Station
ORDER BY occurrences DESC;
---------------------------------------------------------------
--most common end station

SELECT End_Station, COUNT(*) AS occurrences
FROM scooter
GROUP BY End_Station
ORDER BY occurrences DESC;
----------------------------------------------------------------

-- 1 first  we creat a new coulmn 
-- 2 second we put the values
ALTER TABLE scooter ADD trip VARCHAR(255);

UPDATE scooter
SET trip = Start_Station + '-' + End_Station;
select trip from scooter
--the most common trip

SELECT trip, COUNT(*) AS occurrences
FROM scooter
GROUP BY trip
ORDER BY occurrences DESC;

-----------------------------------------------------------------
--total travel  time in hours
SELECT SUM(Trip_Duration)/3600 AS total_travel_time
FROM scooter;
-----------------------------------------------------------------
--average travel time in min
SELECT AVG(Trip_Duration)/60 AS average_travel_time_min
FROM scooter;
------------------------------------------------------------------
--count of all user ,and  each user type

SELECT COUNT(*) AS users_count
FROM scooter

--subscriber_count

SELECT COUNT(*) AS subscriber_count
FROM scooter
WHERE User_Type = 'Subscriber';

--Customer_count

SELECT COUNT(*) AS Customer_count
FROM scooter
WHERE User_Type = 'Customer';
---------------------------------------------------------------------
-- count of each gender

--male_count only in chicago

SELECT COUNT(*) AS male_count
FROM scooter
WHERE Gender = 'male'and [state]='Chicago';

--female_count only in washington

SELECT COUNT(*) AS female_count
FROM scooter
WHERE Gender = 'female' and [state]='washington' ;
-------------------------------------------------------------------
--the most earlist year  only in newyork

SELECT min(birth_year) AS most_recent_year
FROM scooter
WHERE state = 'newyork';

-------------------------------------------------------------------
--the most recent year  only in newyork

SELECT MAX(birth_year) AS most_recent_year
FROM scooter
WHERE state = 'newyork';
------------------------------------------------------------------------
--the most common year  only in newyork
--and do not show the null values in the birth_year
SELECT Birth_Year, COUNT(*) AS occurrences
FROM scooter
WHERE [state] = 'newyork' AND Birth_Year IS NOT NULL
GROUP BY Birth_Year
ORDER BY occurrences DESC;
