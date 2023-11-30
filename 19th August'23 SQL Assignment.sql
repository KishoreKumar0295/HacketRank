CREATE DATABASE SQL_Hacker_Rank;
use SQL_Hacker_Rank;
CREATE TABLE CITY (
    ID INT PRIMARY KEY,
    NAME VARCHAR(255),
    COUNTRYCODE CHAR(3),
    DISTRICT VARCHAR(255),
    POPULATION INT
);
select * from CITY;

# Assignments 
/*
Q1. Query all columns for all American cities in the CITY table with populations larger than 100000.
The CountryCode for America is USA.
The CITY table is described as follows:*/
SELECT *
FROM CITY
WHERE COUNTRYCODE = 'USA' AND POPULATION > 100000;

/*
Q2. Query the NAME field for all American cities in the CITY table with populations larger than 120000.
The CountryCode for America is USA.
The CITY table is described as follows:
*/

SELECT NAME
FROM CITY
WHERE COUNTRYCODE = 'USA' AND POPULATION > 120000;

/*
Q3. Query all columns (attributes) for every row in the CITY table.
The CITY table is described as follows:
*/
SELECT * FROM CITY;

/*
Q4. Query all columns for a city in CITY with the ID 1661.
The CITY table is described as follows:
*/

SELECT * FROM CITY WHERE ID=1661;

/*Q5. Query all attributes of every Japanese city in the CITY table. The COUNTRYCODE for Japan is
JPN.*/
SELECT * FROM CITY WHERE COUNTRYCODE = 'JPN';

/*
Q6. Query the names of all the Japanese cities in the CITY table. The COUNTRYCODE for Japan is
JPN.
*/
SELECT NAME FROM CITY WHERE COUNTRYCODE = 'JPN';

/*=====================================================================================================*/
CREATE TABLE STATION(
    Id INT PRIMARY KEY,
    City VARCHAR(21),
    State VARCHAR(2),
    Lat_N INT,
    Long_W	INT
);

select * FROM STATION;

/*Q7. Query a list of CITY and STATE from the STATION table.
The STATION table is described as follows:*/

SELECT CITY,State from STATION;

/*Q8. Query a list of CITY names from STATION for cities that have an even ID number. Print the results
in any order, but exclude duplicates from the answer.*/

SELECT DISTINCT CITY FROM STATION WHERE ID % 2 = 0;

/*Q9. Find the difference between the total number of CITY entries in the table and the number of
distinct CITY entries in the table.*/

SELECT COUNT(CITY)-count(distinct CITY) FROM STATION;

/*Query the two cities in STATION with the shortest and longest CITY names, as well as their
respective lengths (i.e.: number of characters in the name). If there is more than one smallest or
largest city, choose the one that comes first when ordered alphabetically.*/

SELECT CITY, LENGTH(CITY) AS NameLength
FROM STATION
ORDER BY NameLength, CITY
LIMIT 1;

SELECT CITY, LENGTH(CITY) AS NameLength
FROM STATION
ORDER BY NameLength DESC, CITY
LIMIT 1;


/*
Q11. Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. Your result
cannot contain duplicates.
*/
SELECT DISTINCT CITY
FROM STATION
WHERE CITY REGEXP '^[aeiouAEIOU]';

/*
12 Query the list of CITY names ending with vowels (a, e, i, o, u) from STATION. Your result cannot
contain duplicates.*/
SELECT DISTINCT CITY
FROM STATION
WHERE CITY REGEXP '[aeiouAEIOU]$';

/*
Q13. Query the list of CITY names from STATION that do not start with vowels. Your result cannot
contain duplicates.
*/
SELECT DISTINCT CITY
FROM STATION
WHERE CITY NOT REGEXP '^[aeiouAEIOU]';
/*
Q14. Query the list of CITY names from STATION that do not end with vowels. Your result cannot
contain duplicates.
*/
SELECT DISTINCT CITY
FROM STATION
WHERE CITY NOT REGEXP '[aeiouAEIOU]$';

/*
Q15. Query the list of CITY names from STATION that either do not start with vowels or do not end
with vowels. Your result cannot contain duplicates.
*/

SELECT DISTINCT CITY
FROM STATION
WHERE CITY NOT REGEXP '^[aeiouAEIOU]' OR CITY NOT REGEXP '[aeiouAEIOU]$';

/*
Q16. Query the list of CITY names from STATION that do not start with vowels and do not end with
vowels. Your result cannot contain duplicates.
*/
SELECT DISTINCT CITY
FROM STATION
WHERE CITY NOT REGEXP '^[aeiouAEIOU]' AND CITY NOT REGEXP '[aeiouAEIOU]$';
------------------------------------------------------------------------------------------------------------------
/*
Q17

Table: Product
Column Name Type
product_id int
product_name varchar
unit_price int
product_id is the primary key of this table.
Each row of this table indicates the name and the price of each product.
Table: Sales
Column Name Type
seller_id int
product_id int
buyer_id int
sale_date date
quantity int
price int
This table has no primary key, it can have repeated rows.

product_id is a foreign key to the Product table.
Each row of this table contains some information about one sale.

Write an SQL query that reports the products that were only sold in the first quarter of 2019. That is,
between 2019-01-01 and 2019-03-31 inclusive.
Return the result table in any order.
The query result format is in the following example.
*/

CREATE TABLE Product (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(255),
    unit_price INT
);

INSERT INTO Product (product_id, product_name, unit_price)
VALUES
    (1, 'S8', 1000),
    (2, 'G4', 800),
    (3, 'iPhone', 1400);


CREATE TABLE Sales (
    seller_id INT,
    product_id INT,
    buyer_id INT,
    sale_date DATE,
    quantity INT,
    price INT
);

INSERT INTO Sales (seller_id, product_id, buyer_id, sale_date, quantity, price)
VALUES
    (1, 1, 1, '2019-01-21', 2, 2000),
    (1, 2, 2, '2019-02-17', 1, 800),
    (2, 2, 3, '2019-06-02', 1, 800),
    (3, 3, 4, '2019-05-13', 2, 2800);


SELECT DISTINCT p.product_id, p.product_name, p.unit_price
FROM Product p
JOIN Sales s ON p.product_id = s.product_id
WHERE s.sale_date BETWEEN '2019-01-01' AND '2019-03-31'
  AND s.product_id NOT IN (
    SELECT product_id
    FROM Sales
    WHERE sale_date NOT BETWEEN '2019-01-01' AND '2019-03-31'
  );

----------------------------------------------------------------------------------------------------------
# Q18
/*
Write an SQL query to find all the authors that viewed at least one of their own articles.
Return the result table sorted by id in ascending order.
The query result format is in the following example.
*/

CREATE TABLE Views (
    article_id INT,
    author_id INT,
    viewer_id INT,
    view_date DATE
);

INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (1, 3, 5, '2019-08-01'),
    (1, 3, 6, '2019-08-02'),
    (2, 7, 7, '2019-08-01'),
    (2, 7, 6, '2019-08-02'),
    (4, 7, 1, '2019-07-22'),
    (3, 4, 4, '2019-07-21'),
    (3, 4, 4, '2019-07-21');
select * from Views;


SELECT DISTINCT a.author_id
FROM Views v
JOIN Views a ON v.author_id = a.author_id AND v.article_id = a.article_id
WHERE v.viewer_id = a.author_id;
-----------------------------------------------------------------------------------------------------------------------------

#Q19

/*
If the customer's preferred delivery date is the same as the order date, then the order is called
immediately; otherwise, it is called scheduled.
Write an SQL query to find the percentage of immediate orders in the table, rounded to 2 decimal
places.
The query result format is in the following example.
*/

CREATE TABLE Delivery (
    delivery_id INT,
    customer_id INT,
    order_date DATE,
    delivery_date DATE
);

INSERT INTO Delivery (delivery_id, customer_id, order_date, delivery_date) VALUES
    (1, 1, '2019-08-01', '2019-08-02'),
    (2, 5, '2019-08-02', '2019-08-02'),
    (3, 1, '2019-08-11', '2019-08-11'),
    (4, 3, '2019-08-24', '2019-08-26'),
    (5, 4, '2019-08-21', '2019-08-22'),
    (6, 2, '2019-08-11', '2019-08-13');

SELECT
    ROUND(SUM(CASE WHEN order_date = delivery_date THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS immediate_percentage
FROM
    Delivery;
------------------------------------------------------------------------------------------------------------------------

#Q20
/*
Write an SQL query to find the ctr of each Ad. Round ctr to two decimal points.
Return the result table ordered by ctr in descending order and by ad_id in ascending order in case of a
tie.
The query result format is in the following example.
*/

CREATE TABLE Ads (
    ad_id INT,
    user_id INT,
    action VARCHAR(50)
);

INSERT INTO Ads (ad_id, user_id, action) VALUES
    (1, 1, 'Clicked'),
    (2, 2, 'Clicked'),
    (3, 3, 'Viewed'),
    (5, 5, 'Ignored'),
    (1, 7, 'Ignored'),
    (2, 7, 'Viewed'),
    (3, 5, 'Clicked'),
    (1, 4, 'Viewed'),
    (2, 11, 'Viewed'),
    (1, 2, 'Clicked');

SELECT
    ad_id,
    ROUND(SUM(CASE WHEN action = 'Clicked' THEN 1 ELSE 0 END) / NULLIF(COUNT(CASE WHEN action IN ('Clicked', 'Viewed') THEN 1 ELSE NULL END), 0) * 100, 2) AS ctr
FROM
    Ads
GROUP BY
    ad_id
ORDER BY
    ctr DESC, ad_id;
------------------------------------------------------------------------------------------------------------------------------------

#Q21

/*
Write an SQL query to find the team size of each of the employees.
Return result table in any order.
The query result format is in the following example.
*/

CREATE TABLE Employee (
    employee_id INT,
    team_id INT
);

INSERT INTO Employee (employee_id, team_id) VALUES
    (1, 8),
    (2, 8),
    (3, 8),
    (4, 7),
    (5, 9),
    (6, 9);
SELECT
    employee_id,
    COUNT(team_id) AS team_size
FROM
    Employee
GROUP BY
    employee_id;
-----------------------------------------------------------------------------------------------
#Q22

/*
Write an SQL query to find the type of weather in each country for November 2019.
The type of weather is:
● Cold if the average weather_state is less than or equal 15,
● Hot if the average weather_state is greater than or equal to 25, and
● Warm otherwise.
Return result table in any order.
*/

CREATE TABLE Countries (
    country_id INT PRIMARY KEY,
    country_name VARCHAR(255)
);


INSERT INTO Countries (country_id, country_name) VALUES
    (2, 'USA'),
    (3, 'Australia'),
    (7, 'Peru'),
    (5, 'China'),
    (8, 'Morocco'),
    (9, 'Spain');


CREATE TABLE Weather (
    country_id INT,
    weather_state INT,
    day DATE
);

INSERT INTO Weather (country_id, weather_state, day) VALUES
    (2, 15, '2019-11-01'),
    (2, 12, '2019-10-28'),
    (2, 12, '2019-10-27'),
    (3, -2, '2019-11-10'),
    (3, 0, '2019-11-11'),
    (3, 3, '2019-11-12'),
    (5, 16, '2019-11-07'),
    (5, 18, '2019-11-09'),
    (5, 21, '2019-11-23'),
    (7, 25, '2019-11-28'),
    (7, 22, '2019-12-01'),
    (7, 20, '2019-12-02'),
    (8, 25, '2019-11-05'),
    (8, 27, '2019-11-15'),
    (8, 31, '2019-11-25'),
    (9, 7, '2019-10-23'),
    (9, 3, '2019-12-23');

SELECT
    w.country_id,
    CASE
        WHEN AVG(w.weather_state) <= 15 THEN 'Cold'
        WHEN AVG(w.weather_state) >= 25 THEN 'Hot'
        ELSE 'Warm'
    END AS weather_type
FROM
    Weather w
WHERE
    EXTRACT(YEAR_MONTH FROM w.day) = 201911
GROUP BY
    w.country_id;
----------------------------------------------------------------------------------------------------------------------------------
#Q23
/*
Write an SQL query to find the average selling price for each product. average_price should be
rounded to 2 decimal places.
Return the result table in any order.
*/


CREATE TABLE Prices (
    product_id INT,
    start_date DATE,
    end_date DATE,
    price INT
);


INSERT INTO Prices (product_id, start_date, end_date, price) VALUES
    (1, '2019-02-17', '2019-02-28', 5),
    (1, '2019-03-01', '2019-03-22', 20),
    (2, '2019-02-01', '2019-02-20', 15),
    (2, '2019-02-21', '2019-03-31', 30);

CREATE TABLE UnitsSold (
    product_id INT,
    purchase_date DATE,
    units INT
);


INSERT INTO UnitsSold (product_id, purchase_date, units) VALUES
    (1, '2019-02-25', 100),
    (1, '2019-03-01', 15),
    (2, '2019-02-10', 200),
    (2, '2019-03-22', 30);

SELECT
    us.product_id,
    ROUND(SUM(p.price * us.units) / SUM(us.units), 2) AS average_price
FROM
    UnitsSold us
JOIN
    Prices p ON us.product_id = p.product_id
           AND us.purchase_date BETWEEN p.start_date AND p.end_date
GROUP BY
    us.product_id;
;

-----------------------------------------------------------------------------------------------------------------------------------
/* Q24
Write an SQL query to report the first login date for each player.
Return the result table in any order.
*/

CREATE TABLE Activity (
    player_id INT,
    device_id INT,
    event_date DATE,
    games_played INT
);



INSERT INTO Activity (player_id, device_id, event_date, games_played) VALUES
    (1, 2, '2016-03-01', 5),
    (1, 2, '2016-05-02', 6),
    (2, 3, '2017-06-25', 1),
    (3, 1, '2016-03-02', 0),
    (3, 4, '2018-07-03', 5);

select player_id,min(event_date) as fisrt_login_date from Activity group by player_id;
---------------------------------------------------------------------------------------------------------
/*Q25
Write an SQL query to report the device that is first logged in for each player.
Return the result table in any order.
*/
select * from Activity;
SELECT player_id,MIN(device_id) AS first_logged_in_device FROM Activity GROUP BY player_id;

------------------------------------------------------------------------------------------------------------
/*Q26
Write an SQL query to get the names of products that have at least 100 units ordered in February 2020
and their amount.
*/

CREATE TABLE Products (
    product_id INT,
    product_name VARCHAR(100),
    product_category VARCHAR(100)
);


INSERT INTO Products (product_id, product_name, product_category) VALUES
    (1, 'Leetcode Solutions Book', 'Book'),
    (2, 'Jewels of Stringology Book', 'Book'),
    (3, 'HP Laptop', 'Laptop'),
    (4, 'Lenovo Laptop', 'Laptop'),
    (5, 'Leetcode Kit T-shirt', 'Clothing');


CREATE TABLE Orders (
    product_id INT,
    order_date DATE,
    unit INT
);


INSERT INTO Orders (product_id, order_date, unit) VALUES
    (1, '2020-02-05', 60),
    (1, '2020-02-10', 70),
    (2, '2020-01-18', 30),
    (2, '2020-02-11', 80),
    (3, '2020-02-17', 2),
    (3, '2020-02-24', 3),
    (4, '2020-03-01', 20),
    (4, '2020-03-04', 30),
    (4, '2020-03-04', 60),
    (5, '2020-02-25', 50),
    (5, '2020-02-27', 50),
    (5, '2020-03-01', 50);
/*Q26
Write an SQL query to get the names of products that have at least 100 units ordered in February 2020
and their amount.
*/

SELECT P.product_name, SUM(O.unit) AS total_units_ordered FROM Products P JOIN Orders O ON P.product_id = O.product_id 
WHERE MONTH(O.order_date) = 2 AND YEAR(O.order_date) = 2020
GROUP BY P.product_name
HAVING SUM(O.unit) >= 100;
-------------------------------------------------------------------------------------------------------------------------------
/*Q27
Write an SQL query to find the users who have valid emails.
A valid e-mail has a prefix name and a domain where:
● The prefix name is a string that may contain letters (upper or lower case), digits, underscore
'_', period '.', and/or dash '-'. The prefix name must start with a letter.
● The domain is '@leetcode.com'.*/


CREATE TABLE Users (
    user_id INT,
    name VARCHAR(50),
    mail VARCHAR(100)
);


INSERT INTO Users (user_id, name, mail) VALUES
    (1, 'Winston', 'winston@leetcode.com'),
    (2, 'Jonathan', 'jonathanisgreat'),
    (3, 'Annabelle', 'bella-@leetcode.com'),
    (4, 'Sally', 'sally.come@leetcode.com'),
    (5, 'Marwan', 'quarz#2020@leetcode.com'),
    (6, 'David', 'david69@gmail.com'),
    (7, 'Shapiro', '.shapo@leetcode.com');


SELECT user_id, name, mail FROM Users WHERE mail REGEXP '^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+\\.[A-Z|a-z]{2,4}$';
---------------------------------------------------------------------------------------------------------------------------------
/*Q28
Write an SQL query to report the customer_id and customer_name of customers who have spent at least $100 in each month of June and July 2020.
*/


CREATE TABLE Customers (
    customer_id INT,
    name VARCHAR(50),
    country VARCHAR(50)
);


INSERT INTO Customers (customer_id, name, country) VALUES
    (1, 'Winston', 'USA'),
    (2, 'Jonathan', 'Peru'),
    (3, 'Moustafa', 'Egypt');


CREATE TABLE Products1 (
    product_id INT,
    description VARCHAR(50),
    price DECIMAL(10, 2)
);


INSERT INTO Products1 (product_id, description, price) VALUES
    (10, 'LC Phone', 300),
    (20, 'LC T-Shirt', 10),
    (30, 'LC Book', 45),
    (40, 'LC Keychain', 2);
    
CREATE TABLE Orders1 (
    order_id INT,
    customer_id INT,
    product_id INT,
    order_date DATE,
    quantity INT
);


INSERT INTO Orders1 (order_id, customer_id, product_id, order_date, quantity) VALUES
    (1, 1, 10, '2020-06-10', 1),
    (2, 1, 20, '2020-07-01', 1),
    (3, 1, 30, '2020-07-08', 2),
    (4, 2, 10, '2020-06-15', 2),
    (5, 2, 40, '2020-07-01', 10),
    (6, 3, 20, '2020-06-24', 2),
    (7, 3, 30, '2020-06-25', 2),
    (9, 3, 30, '2020-05-08', 3);

SELECT
    C.customer_id,
    C.name
FROM
    Customers C
WHERE
    C.customer_id IN (
        SELECT
            O.customer_id
        FROM
            Orders O
        JOIN
            Product P ON O.product_id = P.product_id
        WHERE
            (MONTH(O.order_date) = 6 AND YEAR(O.order_date) = 2020)
            OR (MONTH(O.order_date) = 7 AND YEAR(O.order_date) = 2020)
        GROUP BY
            O.customer_id
        HAVING
            SUM(P.price * O.quantity) >= 100
    );

--------------------------------------------------------------------------------------------------------------------------
/*Q29
Write an SQL query to report the distinct titles of the kid-friendly movies streamed in June 2020.
Return the result table in any order.
*/


CREATE TABLE TVProgram (
    program_date DATE,
    content_id INT,
    channel VARCHAR(50)
);


INSERT INTO TVProgram (program_date, content_id, channel) VALUES
    ('2020-06-10 08:00', 1, 'LC-Channel'),
    ('2020-05-11 12:00', 2, 'LC-Channel'),
    ('2020-05-12 12:00', 3, 'LC-Channel'),
    ('2020-05-13 14:00', 4, 'Disney Ch'),
    ('2020-06-18 14:00', 4, 'Disney Ch'),
    ('2020-07-15 16:00', 5, 'Disney Ch');


CREATE TABLE Content (
    content_id INT,
    title VARCHAR(50),
    Kids_content VARCHAR(1),
    content_type VARCHAR(50)
);


INSERT INTO Content (content_id, title, Kids_content, content_type) VALUES
    (1, 'Leetcode Movie', 'N', 'Movies'),
    (2, 'Alg. for Kids', 'Y', 'Series'),
    (3, 'Database Sols', 'N', 'Series'),
    (4, 'Aladdin', 'Y', 'Movies'),
    (5, 'Cinderella', 'Y', 'Movies');

SELECT DISTINCT C.title
FROM TVProgram T
JOIN Content C ON T.content_id = C.content_id
WHERE MONTH(T.program_date) = 6
    AND YEAR(T.program_date) = 2020
    AND C.Kids_content = 'Y'
    AND C.content_type = 'Movies';
--------------------------------------------------
/*Q30 & Q31 are same
Write an SQL query to find the npv of each query of the Queries table.
*/

CREATE TABLE NPV (
    id INT,
    year INT,
    npv INT
);


INSERT INTO NPV (id, year, npv) VALUES
    (1, 2018, 100),
    (7, 2020, 30),
    (13, 2019, 40),
    (1, 2019, 113),
    (2, 2008, 121),
    (3, 2009, 12),
    (11, 2020, 99),
    (7, 2019, 0);

CREATE TABLE Queries (
    id INT,
    year INT
);


INSERT INTO Queries (id, year) VALUES
    (1, 2019),
    (2, 2008),
    (3, 2009),
    (7, 2018),
    (7, 2019),
    (7, 2020),
    (13, 2019);
    
SELECT Q.id, Q.year, COALESCE(SUM(N.npv), 0) AS npv
FROM Queries Q
LEFT JOIN NPV N ON Q.id = N.id AND Q.year = N.year
GROUP BY Q.id, Q.year;
----------------------------------------------------------------------------
/*Q32
Write an SQL query to show the unique ID of each user, If a user does not have a unique ID replace just
show null.
*/

CREATE TABLE Employees (
    id INT,
    name VARCHAR(50)
);


INSERT INTO Employees (id, name) VALUES
    (1, 'Alice'),
    (7, 'Bob'),
    (11, 'Meir'),
    (90, 'Winston'),
    (3, 'Jonathan');


CREATE TABLE EmployeeUNI (
    id INT,
    unique_id INT
);


INSERT INTO EmployeeUNI (id, unique_id) VALUES
    (3, 1),
    (11, 2),
    (90, 3);
SELECT E.id, E.name, EU.unique_id
FROM Employees E
LEFT JOIN EmployeeUNI EU ON E.id = EU.id;
-------------------------------------------------------------------------------------------------------
/*
Q33.
Write an SQL query to report the distance travelled by each user.
Return the result table ordered by travelled_distance in descending order, if two or more users
travelled the same distance, order them by their name in ascending order.
*/

CREATE TABLE Userss (
    id INT,
    name VARCHAR(50)
);


INSERT INTO Userss (id, name) VALUES
    (1, 'Alice'),
    (2, 'Bob'),
    (3, 'Alex'),
    (4, 'Donald'),
    (7, 'Lee'),
    (13, 'Jonathan'),
    (19, 'Elvis');

CREATE TABLE Rides (
    id INT,
    user_id INT,
    distance INT
);


INSERT INTO Rides (id, user_id, distance) VALUES
    (1, 1, 120),
    (2, 2, 317),
    (3, 3, 222),
    (4, 7, 100),
    (5, 13, 312),
    (6, 19, 50),
    (7, 7, 120),
    (8, 19, 400),
    (9, 7, 230);
SELECT
    u.id AS user_id,
    u.name,
    COALESCE(SUM(r.distance), 0) AS travelled_distance
FROM
    Userss u
LEFT JOIN
    Rides r ON u.id = r.user_id
GROUP BY
    u.id, u.name
ORDER BY
    travelled_distance DESC, u.name ASC;
--------------------------------------------------------------------------
/*
Write an SQL query to get the names of products that have at least 100 units ordered in February 2020
and their amount.
*/
/* Note:
Here i dont find the ordered table data so query not completed but given the code may be right or wrong i don't no
 */
CREATE TABLE Products2 (
    product_id INT,
    product_name VARCHAR(100),
    product_category VARCHAR(50)
);

INSERT INTO Products2 (product_id, product_name, product_category) VALUES
    (1, 'Leetcode Solutions Book', 'Books'),
    (2, 'Jewels of Stringology Book', 'Books'),
    (3, 'HP Laptop', 'Electronics'),
    (4, 'Lenovo Laptop', 'Electronics'),
    (5, 'Leetcode Kit T-shirt', 'Clothing');
/*SELECT
    P.product_name,
    SUM(O.quantity) AS total_units,
    SUM(O.quantity * P.price) AS total_amount
FROM
    Products2 P
JOIN
    orders1 O ON P.product_id = O.product_id
WHERE
    MONTH(O.order_date) = 2 AND YEAR(O.order_date) = 2020
GROUP BY
    P.product_name
HAVING
    SUM(O.quantity) >= 100;
*/
----------------------------------------------------------------------------------------------
/*
Q35.
Write an SQL query to:
● Find the name of the user who has rated the greatest number of movies. In case of a tie,
return the lexicographically smaller user name.
● Find the movie name with the highest average rating in February 2020. In case of a tie, return
the lexicographically smaller movie name.
*/


CREATE TABLE Movies (
    movie_id INT,
    title VARCHAR(50)
);

INSERT INTO Movies (movie_id, title) VALUES
    (1, 'Avengers'),
    (2, 'Frozen 2'),
    (3, 'Joker');

CREATE TABLE Users1 (
    user_id INT,
    name VARCHAR(50)
);


INSERT INTO Users1 (user_id, name) VALUES
    (1, 'Daniel'),
    (2, 'Monica'),
    (3, 'Maria'),
    (4, 'James');


CREATE TABLE MovieRating (
    movie_id INT,
    user_id INT,
    rating INT,
    created_at DATE
);


INSERT INTO MovieRating (movie_id, user_id, rating, created_at) VALUES
    (1, 1, 3, '2020-01-12'),
    (1, 2, 4, '2020-02-11'),
    (1, 3, 2, '2020-02-12'),
    (1, 4, 1, '2020-01-01'),
    (2, 1, 5, '2020-02-17'),
    (2, 2, 2, '2020-02-01'),
    (2, 3, 2, '2020-03-01'),
    (3, 1, 3, '2020-02-22'),
    (3, 2, 4, '2020-02-25');

SELECT movie_title
FROM (
    SELECT m.title AS movie_title, AVG(mr.rating) AS avg_rating
    FROM Movies m
    JOIN MovieRating mr ON m.movie_id = mr.movie_id
    WHERE MONTH(mr.created_at) = 2 AND YEAR(mr.created_at) = 2020
    GROUP BY m.movie_id, m.title
    ORDER BY avg_rating DESC, movie_title
    LIMIT 1
) AS movie_with_highest_avg_rating;
------------------------------------------------------------------------------------
/*
Q36
Write an SQL query to report the distance travelled by each user.
Return the result table ordered by travelled_distance in descending order, if two or more users
travelled the same distance, order them by their name in ascending order.
*/

CREATE TABLE Users2 (
    id INT PRIMARY KEY,
    name VARCHAR(50)
);


INSERT INTO Users2 (id, name) VALUES
(1, 'Alice'),
(2, 'Bob'),
(3, 'Alex'),
(4, 'Donald'),
(7, 'Lee'),
(13, 'Jonathan'),
(19, 'Elvis');


CREATE TABLE Rides2 (
    id INT PRIMARY KEY,
    user_id INT,
    distance INT
    );


INSERT INTO Rides2 (id, user_id, distance) VALUES
(1, 1, 120),
(2, 2, 317),
(3, 3, 222),
(4, 7, 100),
(5, 13, 312),
(6, 19, 50),
(7, 7, 120),
(8, 19, 400),
(9, 7, 230);

SELECT
    U.name AS user_name,
    COALESCE(SUM(R.distance), 0) AS travelled_distance
FROM
    Users2 U
LEFT JOIN
    Rides2 R ON U.id = R.user_id
GROUP BY
    U.id, user_name
ORDER BY
    travelled_distance DESC, user_name;
------------------------------------------------------------------------------------------------
/*
Q37
Write an SQL query to show the unique ID of each user, If a user does not have a unique ID replace just
show null.
*/

CREATE TABLE Employees (
    id INT PRIMARY KEY,
    name VARCHAR(50)
);


INSERT INTO Employees (id, name) VALUES
(1, 'Alice'),
(7, 'Bob'),
(11, 'Meir'),
(90, 'Winston'),
(3, 'Jonathan');


CREATE TABLE EmployeeUNI2 (
    id INT PRIMARY KEY,
    unique_id INT
);


INSERT INTO EmployeeUNI2 (id, unique_id) VALUES
(3, 1),
(11, 2),
(90, 3);

SELECT
    E.id,
    E.name,
    EU.unique_id
FROM
    Employees E
LEFT JOIN
    EmployeeUNI2 EU ON E.id = EU.id;
-------------------------------------------------------------------------------------------------------------
/*Q38
Write an SQL query to find the id and the name of all students who are enrolled in departments that no
longer exist.
*/

CREATE TABLE Departments (
    id INT PRIMARY KEY,
    name VARCHAR(255)
);


INSERT INTO Departments (id, name) VALUES
(1, 'Electrical Engineering'),
(7, 'Computer Engineering'),
(13, 'Business Administration');


CREATE TABLE Students (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    department_id INT
    );


INSERT INTO Students (id, name, department_id) VALUES
(23, 'Alice', 1),
(1, 'Bob', 7),
(5, 'Jennifer', 13),
(2, 'John', 14), 
(4, 'Jasmine', 77), 
(3, 'Steve', 74), 
(6, 'Luis', 1),
(8, 'Jonathan', 7),
(7, 'Daiana', 33),
(11, 'Madelynn', 1);

SELECT s.id, s.name
FROM Students s
LEFT JOIN Departments d ON s.department_id = d.id
WHERE d.id IS NULL;
-----------------------------------------------------------------------------------------------
/*Q39
Write an SQL query to report the number of calls and the total call duration between each pair of
distinct persons (person1, person2) where person1 < person2.
*/

CREATE TABLE Calls (
    from_id INT,
    to_id INT,
    duration INT
);


INSERT INTO Calls (from_id, to_id, duration) VALUES
(1, 2, 59),
(2, 1, 11),
(1, 3, 20),
(3, 4, 100),
(3, 4, 200),
(3, 4, 200),
(4, 3, 499);

SELECT
    A.from_id AS person1,
    A.to_id AS person2,
    COUNT(*) AS call_count,
    SUM(A.duration) AS total_duration
FROM
    Calls A
WHERE
    A.from_id < A.to_id
GROUP BY
    person1,
    person2;
-----------------------------------------------------------------------------------
/*Q40
Write an SQL query to find the average selling price for each product. average_price should be
rounded to 2 decimal places.
*/

CREATE TABLE Prices1 (
    product_id INT,
    start_date DATE,
    end_date DATE,
    price INT,
    PRIMARY KEY (product_id, start_date)
);

INSERT INTO Prices (product_id, start_date, end_date, price) VALUES
(1, '2019-02-17', '2019-02-28', 5),
(1, '2019-03-01', '2019-03-22', 20),
(2, '2019-02-01', '2019-02-20', 15),
(2, '2019-02-21', '2019-03-31', 30);


CREATE TABLE UnitsSold (
    product_id INT,
    purchase_date DATE,
    units INT
);

INSERT INTO UnitsSold (product_id, purchase_date, units) VALUES
(1, '2019-02-25', 100),
(1, '2019-03-01', 15),
(2, '2019-02-10', 200),
(2, '2019-03-22', 30);

SELECT
    us.product_id,
    ROUND(SUM(p.price * us.units) / SUM(us.units), 2) AS average_price
FROM
    UnitsSold us
JOIN
    Prices p ON us.product_id = p.product_id
WHERE
    us.purchase_date BETWEEN p.start_date AND p.end_date
GROUP BY
    us.product_id;
--------------------------------------------------------------------------------------------------------
/*Q41
Write an SQL query to report the number of cubic feet of volume the inventory occupies in each
warehouse.
*/

CREATE TABLE Warehouse1 (
    name VARCHAR(50),
    product_id INT,
    units INT,
    PRIMARY KEY (name, product_id)
    );

CREATE TABLE Products1 (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    Width INT,
    Length INT,
    Height INT
);

INSERT INTO Warehouse1 (name, product_id, units) VALUES
('LCHouse1', 1, 1),
('LCHouse1', 2, 10),
('LCHouse1', 3, 5),
('LCHouse2', 1, 2),
('LCHouse2', 2, 2),
('LCHouse3', 4, 1);


INSERT INTO Products1 (product_id, product_name, Width, Length, Height) VALUES
(1, 'LC-TV', 5, 50, 40),
(2, 'LC-KeyChain', 5, 5, 5),
(3, 'LC-Phone', 2, 10, 10),
(4, 'LC-T-Shirt', 4, 10, 20);
SELECT
    w.name AS warehouse_name,
    SUM(p.Width * p.Length * p.Height * w.units) AS total_volume
FROM
    Warehouse1 w
JOIN
    Products1 p ON w.product_id = p.product_id
GROUP BY
    w.name;
---------------------------------------------------------------------------------------------------------------------
/*Q42
Write an SQL query to report the difference between the number of apples and oranges sold each day.
Return the result table ordered by sale_date.
*/

CREATE TABLE Sales1 (
    sale_date DATE,
    fruit VARCHAR(50),
    sold_num INT
);


INSERT INTO Sales1 (sale_date, fruit, sold_num) VALUES
('2020-05-01', 'apples', 10),
('2020-05-01', 'oranges', 8),
('2020-05-02', 'apples', 15),
('2020-05-02', 'oranges', 15),
('2020-05-03', 'apples', 20),
('2020-05-03', 'oranges', 0),
('2020-05-04', 'apples', 15);

SELECT sale_date, 
       SUM(CASE WHEN fruit = 'apples' THEN sold_num ELSE 0 END) -
       SUM(CASE WHEN fruit = 'oranges' THEN sold_num ELSE 0 END) AS diff
FROM Sales1
GROUP BY sale_date
ORDER BY sale_date;
---------------------------------------------------------------------------------------------
/*Q43
Write an SQL query to report the fraction of players that logged in again on the day after the day they
first logged in, rounded to 2 decimal places. In other words, you need to count the number of players
that logged in for at least two consecutive days starting from their first login date, then divide that
number by the total number of players.
*/

CREATE TABLE Activity1 (
    player_id INT,
    device_id INT,
    event_date DATE,
    games_played INT
);


INSERT INTO Activity1 (player_id, device_id, event_date, games_played) VALUES
(1, 2, '2016-03-01', 5),
(1, 2, '2016-03-02', 6),
(2, 3, '2017-06-25', 1),
(3, 1, '2016-03-02', 0),
(3, 4, '2018-07-03', 5);

WITH PlayerFirstLogin AS (
    SELECT
        player_id,
        MIN(event_date) AS first_login_date
    FROM
        Activity
    GROUP BY
        player_id
)

SELECT
    ROUND(
        SUM(CASE WHEN DATEDIFF(a.event_date, pfl.first_login_date) = 1 THEN 1 ELSE 0 END) / COUNT(DISTINCT a.player_id) * 100,
        2
    ) AS fraction_of_players
FROM
    Activity a
JOIN
    PlayerFirstLogin pfl ON a.player_id = pfl.player_id;
---------------------------------------------------------------------------------------------------------------------------------------
/*Q44
Write an SQL query to report the managers with at least five direct reports.
*/

CREATE TABLE Employee1 (
    id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    department VARCHAR(255) NOT NULL,
    managerId INT
    );


INSERT INTO Employee1 (id, name, department, managerId) VALUES
(101, 'John', 'A', NULL),
(102, 'Dan', 'A', 101),
(103, 'James', 'A', 101),
(104, 'Amy', 'A', 101),
(105, 'Anne', 'A', 101),
(106, 'Ron', 'B', 101);

SELECT managerId, COUNT(*) as reportCount
FROM Employee1
WHERE managerId IS NOT NULL
GROUP BY managerId
HAVING COUNT(*) >= 5;
-----------------------------------------------------------------------------------------------------------------------------
/*Q45
Write an SQL query to report the respective department name and number of students majoring in
each department for all departments in the Department table (even ones with no current students).
Return the result table ordered by student_number in descending order. In case of a tie, order them by
dept_name alphabetically.
*/

CREATE TABLE Department (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);


INSERT INTO Department (dept_id, dept_name) VALUES
(1, 'Engineering'),
(2, 'Science'),
(3, 'Law');


CREATE TABLE Student (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50),
    gender CHAR(1),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
);


INSERT INTO Student (student_id, student_name, gender, dept_id) VALUES
(1, 'Jack', 'M', 1),
(2, 'Jane', 'F', 1),
(3, 'Mark', 'M', 2);

SELECT
    d.dept_name,
    COUNT(s.student_id) AS student_number
FROM
    Department d
LEFT JOIN
    Student s ON d.dept_id = s.dept_id
GROUP BY
    d.dept_id, d.dept_name
ORDER BY
    student_number DESC, d.dept_name;
---------------------------------------------------------------------------------
/*Q46
Write an SQL query to report the customer ids from the Customer table that bought all the products in
the Product table.
*/

CREATE TABLE Customer2 (
    customer_id INT,
    product_key INT
);


INSERT INTO Customer2 (customer_id, product_key) VALUES
(1, 5),
(2, 6),
(3, 5),
(3, 6),
(1, 6);

CREATE TABLE Product2 (
    product_key INT
);

INSERT INTO Product2 (product_key) VALUES
(5),
(6);

SELECT DISTINCT c.customer_id
FROM Customer2 c
WHERE NOT EXISTS (
    SELECT p.product_key
    FROM Product2 p
    WHERE p.product_key NOT IN (
        SELECT pc.product_key
        FROM Customer2 pc
        WHERE pc.customer_id = c.customer_id
    )
);
-----------------------------------------------------------------------------
/*Q47
Write an SQL query that reports the most experienced employees in each project. In case of a tie,
report all employees with the maximum number of experience years.
*/

CREATE TABLE Employee2 (
    employee_id INT PRIMARY KEY,
    name VARCHAR(50),
    experience_years INT
);


INSERT INTO Employee2 (employee_id, name, experience_years) VALUES
(1, 'Khaled', 3),
(2, 'Ali', 2),
(3, 'John', 3),
(4, 'Doe', 2);


CREATE TABLE Project (
    project_id INT,
    employee_id INT
    );


INSERT INTO Project (project_id, employee_id) VALUES
(1, 1),
(1, 2),
(1, 3),
(2, 1),
(2, 4);

WITH RankedEmployees AS (
    SELECT
        P.project_id,
        E.employee_id,
        E.name,
        E.experience_years,
        RANK() OVER (PARTITION BY P.project_id ORDER BY E.experience_years DESC) AS experience_rank
    FROM
        Project P
    JOIN
        Employee2 E ON P.employee_id = E.employee_id
)

SELECT
    project_id,
    employee_id,
    name,
    experience_years
FROM
    RankedEmployees
WHERE
    experience_rank = 1;

-----------------------------------------------------------------------------
/*Q48
Write an SQL query that reports the books that have sold less than 10 copies in the last year,
excluding books that have been available for less than one month from today. Assume today is
2019-06-23.*/

-- not have this orders table detailes
-----------------------------------------------------------------------------
/*Q49
Write a SQL query to find the highest grade with its corresponding course for each student. In case of
a tie, you should find the course with the smallest course_id.
*/

CREATE TABLE Students1 (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50),
    gender CHAR(1),
    dept_id INT
);


INSERT INTO Students1 (student_id, student_name, gender, dept_id) VALUES
(1, 'Jack', 'M', 1),
(2, 'Jane', 'F', 1),
(3, 'Mark', 'M', 2);


CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(50)
);


INSERT INTO Courses (course_id, course_name) VALUES
(1, 'Course1'),
(2, 'Course2'),
(3, 'Course3');


CREATE TABLE Enrollments (
    student_id INT,
    course_id INT,
    grade INT,
    PRIMARY KEY (student_id, course_id)
);


INSERT INTO Enrollments (student_id, course_id, grade) VALUES
(2, 2, 95),
(2, 3, 95),
(1, 1, 90),
(1, 2, 99),
(3, 1, 80),
(3, 2, 75),
(3, 3, 82);

WITH RankedGrades AS (
    SELECT
        student_id,
        course_id,
        grade,
        ROW_NUMBER() OVER (PARTITION BY student_id ORDER BY grade DESC, course_id ASC) AS grade_rank
    FROM
        Enrollments
)

SELECT
    student_id,
    course_id,
    grade
FROM
    RankedGrades
WHERE
    grade_rank = 1;

-----------------------------------------------------------------------------
/*Q50
Write an SQL query to find the winner in each group.
*/

CREATE TABLE Players (
    player_id INT PRIMARY KEY,
    group_id INT
);


INSERT INTO Players (player_id, group_id) VALUES
(15, 1),
(25, 1),
(30, 1),
(45, 1),
(10, 2),
(35, 2),
(50, 2),
(20, 3),
(40, 3);


CREATE TABLE Matches (
    match_id INT PRIMARY KEY,
    first_player INT,
    second_player INT,
    first_score INT,
    second_score INT
);


INSERT INTO Matches (match_id, first_player, second_player, first_score, second_score) VALUES
(1, 15, 45, 3, 0),
(2, 30, 25, 1, 2),
(3, 30, 15, 2, 0),
(4, 40, 20, 5, 2),
(5, 35, 50, 1, 1);

-- not able to do this
-----------------------------------------------------------------------------
