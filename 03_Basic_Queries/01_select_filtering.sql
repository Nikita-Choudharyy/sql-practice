-- =====================================================================
-- Module: Data Query Language (DQL) Basics
-- Topic: Data Extraction, Deduplication, and Logical Filtering
-- Purpose: Querying data with precision using operational predicates.
-- =====================================================================

-- Switch to our active analytics workspace
USE analytics_practice_db;

-- 1. BASE RETRIEVAL & COLUMN SELECTION
-- Fetching all columns (Avoid in massive production environments for performance optimization)
SELECT * FROM student_profiles;

-- Selective Column Extraction (Best Practice: Reduces memory overhead)
SELECT first_name, email, enrollment_status 
FROM student_profiles;


-- 2. DEDUPLICATION (Finding Unique Attribute Values)
-- Finding all unique status types active inside our database
SELECT DISTINCT enrollment_status 
FROM student_profiles;


-- 3. LOGICAL AND CONDITIONAL FILTERING (WHERE Clause)
-- Scenario A: Fetching mature students who are currently active
SELECT first_name, last_name, age 
FROM student_profiles
WHERE age >= 22 AND enrollment_status = 'Active';

-- Scenario B: Continuous Range Filtering (BETWEEN)
-- Fetching student details whose ages fall between 20 and 25 (inclusive)
SELECT first_name, age 
FROM student_profiles
WHERE age BETWEEN 20 AND 25;

-- Scenario C: Discrete Set Filtering (IN Predicate)
-- Extracting records matching specific categorical groups cleanly without multiple OR clauses
SELECT first_name, enrollment_status 
FROM student_profiles
WHERE enrollment_status IN ('Active', 'On-Leave');


-- 4. TEXT PATTERN MATCHING (Wildcard Queries using LIKE)
-- Scenario A: Finding emails that belong to standard example domains
-- '%' represents zero, one, or multiple dynamic characters
SELECT first_name, email 
FROM student_profiles
WHERE email LIKE '%@example.com';

-- Scenario B: Locating profiles where the first name starts exactly with 'A'
SELECT first_name 
FROM student_profiles
WHERE first_name LIKE 'A%';


-- =====================================================================
-- 📝 STUDENT REFLECTION & QUICK REVISION
-- - Specifying exact columns instead of '*' saves cloud server data transfer costs.
-- - BETWEEN is inclusive of both boundary values specified in the query range.
-- - IN is a cleaner, highly optimized alternative to writing endless chained 'OR' logic.
-- - LIKE using '%' is great for textual pattern hunting but can slow down huge tables.
-- =====================================================================
