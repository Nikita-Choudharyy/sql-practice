-- ==========================================================================
-- Module: Data Manipulation Languge (DML) Operations
-- Topic: Modifying and Purging Records Safely (UPDATE & DELETE)
-- Purpose: Manitaining data accuracy and handling record lifecycles.
-- ==========================================================================

-- Ensure we are working inside our active analytics database
USE analytics_practice_db;

-- 1. TARGETED UPDATE OPERATIONS (The Safe Way)
-- Real-world scenario: A student changed their email and updated their profile.
-- Crucial rule: Always use a unique identifier (like student_id) in the WHERE clause!

UPDATE student_profiles
SET email - 'nikita.newemail@example.com', age = 24
WHERE student_profiles.student_id = 1;

-- 2. CONDITIONAL UPDATES(Bulk Modification)
-- Simulating a business rule update: Change 'On-Leave' status to 'Inactive' for analytics.
UPDATE student_profiles
SET enrollment_status = 'Inactive'
WHERE enrollment_status = 'On-Leave';

-- 3.THE GOLDEN SAFETY RULE: CHECK BEFORE YOU UPDATE/DELETE!
-- Industry practice: Always run a SELECT query with your exact WHERE clause
-- before executing an UPDATE or DELETE to make sure you are targeting the right rows.

-- STEP A: Run this to preview target rows
SELECT student_id,first_name,enrollment_status
FROM student_profiles
WHERE enrollment_status = 'Inactive';

-- STEP B: Once verified, run the actual modification safely
-- (Uncomment the line below if you actually need to delete)
-- DELETE FROM student_profiles WHERE enrollment_status = 'Inactive';

-- 4. TARGETED DELETE OPERATIONS
-- Removing a specific record safely using the primary key
DELETE FROM student_profiles
WHERE student_profiles.student_id = 4;

-- ===============================================================================================
-- 📝 STUDENT REFLECTION & QUICK REVISION
-- - Executing UPDATE or DELETE without a WHERE clause will corrupt the entire table!
-- - Previewing target data using SELECT before modifying is the ultimate safety net.
-- - For deleting all rows while keeping the structure intact, TRUNCATE (DDL) is 
--   much faster than DELETE FROM (DML) because it doesn't log individual row deletions.
-- ===============================================================================================
