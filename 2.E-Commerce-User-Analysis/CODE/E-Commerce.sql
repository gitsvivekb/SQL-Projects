-- Question 1
-- Create new schema as ecommerce

CREATE DATABASE ecommerce;
USE ecommerce;

/*
Import .csv file users_data into MySQL
student(right click on ecommerce schema -> Table Data import Wizard -> Give path of the file -> Next -> choose options : 
Create a new table , select delete if exist -> next -> next)
*/

-- Question 2
-- Imported the .csv file called users_data for table content in created schema named as ecommerce

SELECT 
	 * 
FROM 
	users_data;
    
-- Question 3
-- Run SQL command to see the structure of table

DESC 
   users_data;
   
-- Question 4
-- Run SQL command to select first 100 rows of the database

SELECT 
	 *
FROM 
    users_data 
LIMIT 100;
    
-- Question 5
-- How many distinct values exist in table for field country and language

SELECT 
	 COUNT(DISTINCT country) country,
	 COUNT(DISTINCT language) language 
FROM 
	 users_data;
	
-- Question 6
-- Check whether male users are having maximum followers or female users.

SELECT 
	   gender, 
	   SUM(socialNbFollowers) 
FROM 
       users_data 
GROUP BY 
	   gender;
       
-- Question 7
/* 
Calculate the total users those
a.Uses Profile Picture in their Profile
b.Uses Application for Ecommerce platform
c.Uses Android app
d.Uses ios app
*/

-- a. Uses Profile Picture in their Profile

SELECT
	COUNT(hasProfilePicture) Uses_Profile_Picture 
FROM 
    users_data 
WHERE 
	hasProfilePicture = 'True';

-- b. Uses Application for Ecommerce platform

SELECT * FROM users_data;
       
SELECT 
	COUNT(hasAnyApp) Application_for_Ecommerce_platform 
FROM 
    users_data 
WHERE 
	hasAnyApp = 'True';

-- c. Uses Android app

SELECT
	COUNT(hasAndroidApp) Android_Users
FROM 
    users_data 
WHERE 
	hasAndroidApp = 'True';

-- d. Uses ios app

SELECT 
	 COUNT(hasIosApp) IOS_Users
FROM 
     users_data 
WHERE 
	 hasIosApp = 'True';
    
-- Question 8
/*
Calculate the total number of buyers for each country and sort the result in descending order of total number of buyers.
 (Hint: consider only those users having at least 1 product bought.)
 */
 
 SELECT 
      country,
	  COUNT(productsBought)Buyers 
FROM 
	  users_data 
GROUP BY 
	  country 
ORDER BY 
	  Buyers DESC;
      
-- Question 9
/*
Calculate the total number of sellers for each country and sort the result in ascending order of total number of sellers. 
(Hint: consider only those users having at least 1 product sold.)
*/

SELECT 
	 country,
	 COUNT(productsSold)Seller
FROM 
	 users_data 
GROUP BY 
	 country 
ORDER BY 
	 Seller ASC;
     
-- Question 10
/*
Display name of top 10 countries having maximum products pass rate.
*/

SELECT
	 country,
	 MAX(productsPassRate)
FROM 
	 users_data 
GROUP BY 
	 country 
HAVING 
	 MAX(productsPassRate) 
LIMIT 10;

-- Question 11
/*
Calculate the number of users on an ecommerce platform for different language choices.
*/

SELECT 
	 language, 
	 COUNT(language) Users 
FROM 
	 users_data 
GROUP BY 
	 language;
     
-- Question 12
/*
Check the choice of female users about putting the product in a wishlist or to like socially on an ecommerce platform. 
(Hint: use UNION to answer this question.)
*/

SELECT 
	 COUNT(productsWished) Result 
FROM 
	 users_data 
WHERE 
	 gender = 'F' 
UNION 
SELECT 
	 COUNT(socialProductsLiked) 
FROM 
	users_data 
WHERE 
	gender = 'F';

-- Question 13
/*
Check the choice of male users about being seller or buyer. (Hint: use UNION to solve this question.)
*/

SELECT 
	 COUNT(productsSold) Result 
FROM 
	 users_data 
WHERE 
	 gender = 'M'
UNION
SELECT 
	 COUNT(ProductsBought) 
FROM 
	 users_data 
WHERE 
	 gender = 'M';
    
-- Question 14
/*
Which country is having maximum number of buyers?
*/

SELECT 
	 country,
	 MAX(productsBought) Max_Buyer 
FROM 
	 users_data 
GROUP BY 
	 country 
Having 
	 Max_Buyer 
LIMIT 1;


-- Question 15
/*
List the name of 10 countries having zero number of sellers.
*/

SELECT 
	 country,
	 productsSold 
FROM 
	 users_data  
WHERE 
	 productsSold = 0  
LIMIT 10;

-- Question 16
/*
Display record of top 110 users who have used ecommerce platform recently.
*/

SELECT 
	 *
FROM 
	 users_data 
ORDER BY 
	 daysSinceLastLogin ASC 
LIMIT 110;

-- Question 17
/*
Calculate the number of female users those who have not logged in since last 100 days.
*/

SELECT 
	  COUNT(gender) Female_Users 
FROM
	  users_data 
WHERE 
	  gender='F' 
ORDER BY 
	  daysSinceLastLogin >=100;

-- Question 18
/*
Display the number of female users of each country at ecommerce platform.
*/

SELECT 
	 country,
	 COUNT(gender) Female_Users 
from 
	 users_data 
WHERE 
	 gender = 'F' 
GROUP BY 
	 country;

-- Question 19
/*
Display the number of male users of each country at ecommerce platform.
*/

SELECT 
	  country,
	  COUNT(gender) Male_Users 
from 
	  users_data 
WHERE
	  gender = 'M'
GROUP BY 
      country;

-- Question20
/*
Calculate the average number of products sold and bought on ecommerce platform by male users for each country.
*/

SELECT 
	  country,
	  AVG(productsSold) Average_Sold , 
	  AVG(productsBought) Average_Bought 
FROM
      users_data 
WHERE 
	  gender = 'M' 
GROUP BY 
	  country;
