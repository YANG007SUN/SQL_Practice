-- Table: Logs

-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | id          | int     |
-- | num         | varchar |
-- +-------------+---------+
-- id is the primary key for this table.
 

-- Write an SQL query to find all numbers that appear at least three times consecutively.

-- Return the result table in any order.

-- The query result format is in the following example:

 

-- Logs table:
-- +----+-----+
-- | Id | Num |
-- +----+-----+
-- | 1  | 1   |
-- | 2  | 1   |
-- | 3  | 1   |
-- | 4  | 2   |
-- | 5  | 1   |
-- | 6  | 2   |
-- | 7  | 2   |
-- +----+-----+

-- Result table:
-- +-----------------+
-- | ConsecutiveNums |
-- +-----------------+
-- | 1               |
-- +-----------------+
-- 1 is the only number that appears consecutively for at least three times.

SELECT DISTINCT t.ConsecutiveNums
FROM (SELECT num AS ConsecutiveNums, 
             (ROW_NUMBER() OVER (ORDER BY id) - 
              ROW_NUMBER() OVER (PARTITION BY num ORDER BY id))  AS grp
      FROM logs) AS t
GROUP BY t.grp, t.ConsecutiveNums
HAVING COUNT(*)>=3
