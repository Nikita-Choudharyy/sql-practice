-- ===========================================================================
-- Module: Advanced SQL & Analytical Operations
-- Topic: Advanced Analytical Queries Using Window Functions
-- Purpose: Computing running aggregates and rankings across data partitions.
-- ===========================================================================

-- Switch to our active analytics database workspace
USE analytics_practice_db;

-- 1. RANKING FUNCTIONS (ROW_NUMBER, RANK, DENSE_RANK)
-- Scenario: Rank students inside EACH enrollment status group based on their age, 
-- from oldest to youngest. Notice how ties are handled differently by each function!
SELECT 
    student_id,
    first_name,
    enrollment_status,
    age,
    ROW_NUMBER() OVER (PARTITION BY enrollment_status ORDER BY age DESC) AS row_num,
    RANK()       OVER (PARTITION BY enrollment_status ORDER BY age DESC) AS standard_rank,
    DENSE_RANK() OVER (PARTITION BY enrollment_status ORDER BY age DESC) AS dense_rank
FROM student_profiles;


-- 2. RUNNING TOTALS & CUMULATIVE AGGREGATIONS
-- Scenario: Calculate a cumulative running total of course fees paid by students, 
-- ordered chronologically or by student ID, to track income cashflow generation.
SELECT 
    student_id,
    first_name,
    course_fee_paid,
    SUM(course_fee_paid) OVER (ORDER BY student_id ASC) AS cumulative_running_revenue
FROM student_profiles;


-- 3. PARTITIONED VALUE FETCHING (FIRST_VALUE & LAST_VALUE)
-- Scenario: For each enrollment status, find the name of the absolute youngest 
-- student without using subqueries or group by statements.
SELECT 
    student_id,
    first_name,
    enrollment_status,
    age,
    FIRST_VALUE(first_name) OVER (PARTITION BY enrollment_status ORDER BY age ASC) AS youngest_in_group
FROM student_profiles;


-- 4. LEAD & LAG OPERATIONS (Data Stream Analytics)
-- Scenario: Compare a student's course fee with the fee paid by the previous student 
-- in the record list to analyze variance or structural gaps.
SELECT 
    student_id,
    first_name,
    course_fee_paid,
    LAG(course_fee_paid, 1, 0) OVER (ORDER BY student_id ASC) AS previous_row_fee,
    (course_fee_paid - LAG(course_fee_paid, 1, 0) OVER (ORDER BY student_id ASC)) AS fee_variance
FROM student_profiles;


-- =====================================================================
-- 📝 STUDENT REFLECTION & QUICK REVISION
-- - Unlike GROUP BY, window functions do NOT collapse rows into a single output line.
-- - PARTITION BY splits the rows into logical segments before running calculations.
-- - ROW_NUMBER gives consecutive sequential numbers; RANK skips numbers on duplicate ties; 
--   DENSE_RANK maintains consecutive numbering even when ties occur.
-- - LEAD looks forward into subsequent rows, while LAG looks backward at preceding data.
-- =====================================================================
