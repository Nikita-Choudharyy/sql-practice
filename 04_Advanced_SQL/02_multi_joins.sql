-- =====================================================================
-- Module: Advanced SQL & Analytical Operations
-- Topic: Merging Datasets Using Multiple JOINS (INNER, LEFT, RIGHT, FULL)
-- Purpose: Stitching distributed relational tables to construct unified analytical views.
-- =====================================================================

-- Switch to our active analytics database workspace
USE analytics_practice_db;

-- 1. INNER JOIN (Intersection of Records)
-- Scenario: Fetch only those students who have an active course enrollment mapping.
-- If a student hasn't enrolled in a course, or a course has no students, they are skipped.
SELECT 
    s.student_id,
    s.first_name,
    s.email,
    e.course_name,
    e.enrollment_date
FROM student_profiles AS s
INNER JOIN course_enrollments AS e 
    ON s.student_id = e.student_id;


-- 2. LEFT OUTER JOIN (Preserving Master Row Context)
-- Scenario: Fetch ALL registered students, along with their course details if they have any.
-- Highly critical for identifying inactive or cold users who haven't taken action yet.
SELECT 
    s.student_id,
    s.first_name,
    e.course_name,
    IFNULL(e.course_status, 'Not Enrolled') AS current_status
FROM student_profiles AS s
LEFT JOIN course_enrollments AS e 
    ON s.student_id = e.student_id;


-- 3. RIGHT OUTER JOIN & FULL OUTER JOIN EMULATION
-- Scenario: Fetch all courses and match them to students. 
-- Note: MySQL does not support FULL OUTER JOIN natively, so we emulate it using UNION.
SELECT s.first_name, e.course_name
FROM student_profiles AS s
LEFT JOIN course_enrollments AS e ON s.student_id = e.student_id
UNION
SELECT s.first_name, e.course_name
FROM student_profiles AS s
RIGHT JOIN course_enrollments AS e ON s.student_id = e.student_id;


-- 4. MULTI-TABLE COMPLEX JOIN CHAINING (3+ Tables Integration)
-- Scenario: Connect student profiles to their course enrollments, AND then connect 
-- those enrollments to the global financial payments table to check status.
SELECT 
    s.student_id,
    s.first_name,
    c.course_name,
    p.amount_paid,
    p.payment_status
FROM student_profiles AS s
INNER JOIN course_enrollments AS c 
    ON s.student_id = c.student_id
LEFT JOIN payment_ledger AS p 
    ON c.enrollment_id = p.enrollment_id
WHERE s.enrollment_status = 'Active';


-- =====================================================================
-- 📝 STUDENT REFLECTION & QUICK REVISION
-- - INNER JOIN returns matching rows only; missing keys on either side are purged.
-- - LEFT JOIN keeps the entire left side safe, filling empty right slots with NULL.
-- - Always use explicit, short table aliases (s, c, p) to keep multi-joins readable.
-- - Chaining multiple joins follows a linear sequence; performance depends heavily 
--   on choosing indexed columns for the 'ON' matching clause.
-- =====================================================================
