-- =====================================================================
-- Module: Data Manipulation Language (DML) Operations
-- Topic: Populating Relational Tables Safely & Bulk Processing
-- Purpose: Feeding clean records into our schema for upstream analytics.
-- =====================================================================

-- Switch to our active analytics sandbox workspace
USE analytics_practice_db;

-- 1. STANDARD SINGLE-ROW INSERT (Best Practice Approach)
-- Explicitly stating column names prevents code failures if table schema changes later.
INSERT INTO student_profiles (first_name, last_name, email, age, enrollment_status)
VALUES ('Nikita', 'Sharma', 'nikita.sharma@example.com', 23, 'Active');


-- 2. BULK DATA INSERTION (Optimized for performance)
-- Inserting multiple customer/student profiles inside a single batch execution block.
INSERT INTO student_profiles (first_name, last_name, email, age, enrollment_status)
VALUES 
('Aarav', 'Mehta', 'aarav.mehta@example.com', 21, 'Active'),
('Ananya', 'Sen', 'ananya.sen@example.com', 26, 'On-Leave'),
('Kabir', 'Singh', 'kabir.singh@example.com', 19, 'Active'),
('Riya', 'Verma', 'riya.verma@example.com', 24, 'Active');


-- 3. HANDLING DEFAULT AND NULL STRUCTURAL FIELDS
-- Leaving out 'enrollment_status' and 'joined_date' to let SQL automatically trigger 
-- our predefined default constraint values ('Active' and CURRENT_DATE).
INSERT INTO student_profiles (first_name, last_name, email, age)
VALUES ('Rahul', 'Das', 'rahul.das@example.com', 22);


-- 4. VERIFYING THE POPULATED DATA
-- Fetching the inserted rows to inspect structural accuracy
SELECT * FROM student_profiles;


-- =====================================================================
-- 📝 STUDENT REFLECTION & QUICK REVISION
-- - Stating column names explicitly protects production data pipelines from breaking.
-- - Bulk inserts are exponentially faster than running separate single-row INSERT statements.
-- - Omitting values with DEFAULT constraints forces SQL to fill them intelligently.
-- =====================================================================
