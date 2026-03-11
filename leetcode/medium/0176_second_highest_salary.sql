-- Problem: Second Highest Salary
-- Platform: LeetCode
-- Difficulty: Medium
-- Link: https://leetcode.com/problems/second-highest-salary/

-- Table: Employee
-- +-------------+------+
-- | Column Name | Type |
-- +-------------+------+
-- | id          | int  |
-- | salary      | int  |
-- +-------------+------+


-- Approach 1: Window Function (RANK)

WITH emp_rank AS (
    SELECT id, salary,
           RANK() OVER (ORDER BY salary DESC) AS salary_rank
    FROM Employee
)

SELECT DISTINCT salary AS SecondHighestSalary
FROM emp_rank
WHERE salary_rank = 2;


-- Approach 2: LIMIT + OFFSET

SELECT (
    SELECT DISTINCT salary
    FROM Employee
    ORDER BY salary DESC
    LIMIT 1 OFFSET 1
) AS SecondHighestSalary;


-- Approach 3: Using MAX with Subquery

SELECT MAX(salary) AS SecondHighestSalary
FROM Employee
WHERE salary < (
    SELECT MAX(salary)
    FROM Employee
);



-- Explanation

-- Approach 1:
-- Rank salaries using a window function and select the salary with rank = 2.

-- Approach 2:
-- Sort salaries in descending order and skip the first (highest) salary using OFFSET.
-- Writing the query without the outer SELECT may return an empty result
-- if the second highest salary does not exist.
-- 
-- LeetCode expects the result to return NULL instead of no rows.
-- Wrapping the query in a scalar subquery ensures one row is returned,
-- with NULL when the second highest salary is not present.

-- Approach 3:
-- Find the maximum salary that is less than the overall maximum salary.
-- This effectively gives the second highest salary.
