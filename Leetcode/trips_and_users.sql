
-- Table: Trips

-- +-------------+----------+
-- | Column Name | Type     |
-- +-------------+----------+
-- | Id          | int      |
-- | Client_Id   | int      |
-- | Driver_Id   | int      |
-- | City_Id     | int      |
-- | Status      | enum     |
-- | Request_at  | date     |     
-- +-------------+----------+
-- Id is the primary key for this table.
-- The table holds all taxi trips. Each trip has a unique Id, while Client_Id and Driver_Id are foreign keys to the Users_Id at the Users table.
-- Status is an ENUM type of (‘completed’, ‘cancelled_by_driver’, ‘cancelled_by_client’).
 

-- Table: Users

-- +-------------+----------+
-- | Column Name | Type     |
-- +-------------+----------+
-- | Users_Id    | int      |
-- | Banned      | enum     |
-- | Role        | enum     |
-- +-------------+----------+
-- Users_Id is the primary key for this table.
-- The table holds all users. Each user has a unique Users_Id, and Role is an ENUM type of (‘client’, ‘driver’, ‘partner’).
-- Status is an ENUM type of (‘Yes’, ‘No’).
 

-- Write a SQL query to find the cancellation rate of requests with unbanned users (both client and driver must not be banned) each day between "2013-10-01" and "2013-10-03".

-- The cancellation rate is computed by dividing the number of canceled (by client or driver) requests with unbanned users by the total number of requests with unbanned users on that day.

-- Return the result table in any order. Round Cancellation Rate to two decimal points.

-- The query result format is in the following example:

 

-- Trips table:
-- +----+-----------+-----------+---------+---------------------+------------+
-- | Id | Client_Id | Driver_Id | City_Id | Status              | Request_at |
-- +----+-----------+-----------+---------+---------------------+------------+
-- | 1  | 1         | 10        | 1       | completed           | 2013-10-01 |
-- | 2  | 2         | 11        | 1       | cancelled_by_driver | 2013-10-01 |
-- | 3  | 3         | 12        | 6       | completed           | 2013-10-01 |
-- | 4  | 4         | 13        | 6       | cancelled_by_client | 2013-10-01 |
-- | 5  | 1         | 10        | 1       | completed           | 2013-10-02 |
-- | 6  | 2         | 11        | 6       | completed           | 2013-10-02 |
-- | 7  | 3         | 12        | 6       | completed           | 2013-10-02 |
-- | 8  | 2         | 12        | 12      | completed           | 2013-10-03 |
-- | 9  | 3         | 10        | 12      | completed           | 2013-10-03 |
-- | 10 | 4         | 13        | 12      | cancelled_by_driver | 2013-10-03 |
-- +----+-----------+-----------+---------+---------------------+------------+

-- Users table:
-- +----------+--------+--------+
-- | Users_Id | Banned | Role   |
-- +----------+--------+--------+
-- | 1        | No     | client |
-- | 2        | Yes    | client |
-- | 3        | No     | client |
-- | 4        | No     | client |
-- | 10       | No     | driver |
-- | 11       | No     | driver |
-- | 12       | No     | driver |
-- | 13       | No     | driver |
-- +----------+--------+--------+

-- Result table:
-- +------------+-------------------+
-- | Day        | Cancellation Rate |
-- +------------+-------------------+
-- | 2013-10-01 | 0.33              |
-- | 2013-10-02 | 0.00              |
-- | 2013-10-03 | 0.50              |
-- +------------+-------------------+

-- On 2013-10-01:
--   - There were 4 requests in total, 2 of which were canceled.
--   - However, the request with Id=2 was made by a banned client (User_Id=2), so it is ignored in the calculation.
--   - Hence there are 3 unbanned requests in total, 1 of which was canceled.
--   - The Cancellation Rate is (1 / 3) = 0.33
-- On 2013-10-02:
--   - There were 3 requests in total, 0 of which were canceled.
--   - The request with Id=6 was made by a banned client, so it is ignored.
--   - Hence there are 2 unbanned requests in total, 0 of which were canceled.
--   - The Cancellation Rate is (0 / 2) = 0.00
-- On 2013-10-03:
--   - There were 3 requests in total, 1 of which was canceled.
--   - The request with Id=8 was made by a banned client, so it is ignored.
--   - Hence there are 2 unbanned request in total, 1 of which were canceled.
--   - The Cancellation Rate is (1 / 2) = 0.50

-- # Write your MySQL query statement below


WITH unbaned AS(  
    SELECT *
    FROM users AS u
    WHERE banned ='No'),
    
    trips_filter AS (
    SELECT *
    FROM trips
    WHERE request_at >='2013-10-01' AND
          request_at <='2013-10-03'
    ),
    
    master_table AS (
    SELECT t.request_at AS d, t.status AS s, 
           COUNT(*) AS c,
           SUM(COUNT(*)) OVER(PARTITION BY t.request_at) AS t
    FROM unbaned AS u
    INNER JOIN trips_filter AS t
    ON t.client_id = u.users_id
    GROUP BY d, s),
    
    temp AS (
    SELECT d, c 
    FROM master_table 
    WHERE s <>'completed')
    
SELECT mt.d AS Day, ROUND(COALESCE(temp.c,0)/mt.t,2) AS 'Cancellation Rate'
FROM master_table AS mt
LEFT JOIN temp
ON temp.d = mt.d
GROUP BY mt.d
