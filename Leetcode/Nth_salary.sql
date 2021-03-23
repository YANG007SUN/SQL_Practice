-- Write a SQL query to get the nth highest salary from the Employee table.

-- +----+--------+
-- | Id | Salary |
-- +----+--------+
-- | 1  | 100    |
-- | 2  | 200    |
-- | 3  | 300    |
-- +----+--------+
-- For example, given the above Employee table, the nth highest salary where n = 2 is 200. If there is no nth highest salary, then the query should return null.

-- +------------------------+
-- | getNthHighestSalary(2) |
-- +------------------------+
-- | 200                    |
-- +------------------------+

-- OFFSET can only be used after ORDER BY
-- In Mysql server OFFSET 1 ROWS

CREATE FUNCTION getNthHighestSalary(N int) RETURN INT
BEGIN
    SET N = N-1
    RETURN (
        --SQL
        SELECT DISTINCT salary
        FROM Employee
        GROUP BY salary
        ORDER BY salary DESC LIMIT 1 OFFSET N

    )

