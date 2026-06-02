-- =====================================================================
-- Module: Data Query Language (DQL) Basics
-- Topic: Sorting Results and Restricting Output Rows (ORDER BY & LIMIT)
-- Purpose: Organizing analytics payloads and implementing query pagination.
-- =====================================================================

-- Switch to our active analytics database workspace
USE analytics_practice_db;

-- 1. BASIC DATA SORTING (Single Column Order)
-- Scenario: Sort all students based on their age in ascending order (Default)
SELECT student_id, first_name, age 
FROM student_profiles
ORDER BY age ASC;

-- Scenario: Sort students to find the oldest ones first (Descending Order)
SELECT student_id, first_name, age 
FROM student_profiles
ORDER BY age DESC;


-- 2. MULTI-COLUMN COMPLEX SORTING
-- Scenario: Order data by enrollment status alphabetically, and for students 
-- with the same status, sort them by age from youngest to oldest.
SELECT first_name, enrollment_status, age 
FROM student_profiles
ORDER BY enrollment_status ASC, age ASC;


-- 3. RESTRICTING OUTPUT ROWS (The LIMIT Clause)
-- Real-World Scenario: Find the "Top 3" youngest students active in the system.
-- Optimization Tip: Always use LIMIT with ORDER BY to get predictable, meaningful results!
SELECT first_name, age 
FROM student_profiles
WHERE enrollment_status = 'Active'
ORDER BY age ASC
LIMIT 3;


-- 4. DATA PAGINATION (Combining LIMIT and OFFSET)
-- Real-World Scenario: Implementing web-page pagination (e.g., View Page 2 of results).
-- OFFSET skips the specified number of rows before starting to return the data blocks.

-- Query: Skip the first 2 youngest students and return the next 2 rows
SELECT student_id, first_name, age 
FROM student_profiles
ORDER BY age ASC
LIMIT 2 OFFSET 2;


-- =====================================================================
-- 📝 STUDENT REFLECTION & QUICK REVISION
-- - ORDER BY defaults to ASC (Ascending) if you don't explicitly specify it.
-- - Chaining multiple columns in ORDER BY acts as a tie-breaker layer for data.
-- - LIMIT is an excellent performance saver when dealing with multi-million row tables.
-- - Formula for Web Pagination: LIMIT = rows_per_page, OFFSET = (page_number - 1) * rows_per_page.
-- =====================================================================
