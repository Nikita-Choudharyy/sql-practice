-- =====================================================================
-- Module: Advanced SQL & Analytical Operations
-- Topic: Grouping Data and Filtering Aggregates (GROUP BY & HAVING)
-- Purpose: Segmenting metrics across categories and filtering aggregated outputs.
-- =====================================================================

-- Switch to our active analytics database workspace
USE analytics_practice_db;

-- 1. STANDARD GROUP BY (Categorical Metric Segmentation)
-- Scenario: Find the total number of students and their average age inside 
-- EACH specific enrollment status group.
SELECT 
    enrollment_status,
    COUNT(*) AS total_students_per_group,
    AVG(age) AS average_age_per_group
FROM student_profiles
GROUP BY enrollment_status;


-- 2. MULTI-COLUMN COMPLEX GROUPING
-- Scenario: If we track 'gender' or 'course_id', we can segment by multiple attributes.
-- Grouping data by both 'enrollment_status' AND 'age' to find distinct bucket counts.
SELECT 
    enrollment_status,
    age,
    COUNT(*) AS absolute_headcount
FROM student_profiles
GROUP BY enrollment_status, age
ORDER BY enrollment_status ASC, age DESC;


-- 3. FILTERING AGGREGATES USING HAVING (The Interview Favorite)
-- Core Rule: WHERE filters individual raw rows BEFORE aggregation happens.
-- HAVING filters the summary groups AFTER aggregation has been executed.

-- Scenario: Find only those enrollment status groups that have MORE than 2 students.
SELECT 
    enrollment_status,
    COUNT(*) AS structural_group_count
FROM student_profiles
GROUP BY enrollment_status
HAVING COUNT(*) > 2;


-- 4. COMBINING WHERE, GROUP BY, HAVING, AND ORDER BY (The Full Lifecycle)
-- Scenario: Find the average fee paid per status group, considering only students 
-- older than 20, and only show groups where the average fee paid is above $5000.
SELECT 
    enrollment_status,
    AVG(course_fee_paid) AS average_segmented_fee
FROM student_profiles
WHERE age > 20                                 -- Step 1: Filter raw individual rows
GROUP BY enrollment_status                     -- Step 2: Group the remaining rows
HAVING AVG(course_fee_paid) > 5000.00         -- Step 3: Filter the calculated groups
ORDER BY average_segmented_fee DESC;          -- Step 4: Sort the final visual output


-- =====================================================================
-- 📝 STUDENT REFLECTION & QUICK REVISION
-- - You cannot use an aggregate function (like SUM or COUNT) inside a WHERE clause.
-- - HAVING is explicitly dedicated to evaluating aggregate conditions.
-- - Order of Execution: FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY.
-- =====================================================================
