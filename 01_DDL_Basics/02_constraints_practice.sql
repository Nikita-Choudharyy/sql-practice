-- =====================================================================
-- Module: Data Definition Language (DDL) Basics
-- Topic: Advanced Relational Constraints & Foreign Key Relationships
-- Purpose: Building a multi-table interconnected schema for analytics.
-- =====================================================================

-- Ensure we are working inside our active analytics database
USE analytics_practice_db;

-- 1. CREATING A PARENT TABLE (Reference Source)
-- This table stores course details. Each course has a unique course_id.
CREATE TABLE training_courses (
    course_id INT AUTO_INCREMENT,
    course_name VARCHAR(100) NOT NULL,
    department VARCHAR(50) NOT NULL,
    price DECIMAL(8, 2) NOT NULL,
    
    PRIMARY KEY (course_id),
    CONSTRAINT chk_course_price CHECK (price >= 0.00)
);


-- 2. CREATING A CHILD TABLE WITH FOREIGN KEY CONSTRAINTS
-- Real-World Scenario: A student can enroll in multiple courses. 
-- We map relationships using foreign keys to maintain Referential Integrity.

CREATE TABLE course_enrollments (
    enrollment_id INT AUTO_INCREMENT,
    student_id INT NOT NULL,  -- References student_profiles(student_id) from script 01
    course_id INT NOT NULL,   -- References training_courses(course_id)
    enrollment_type VARCHAR(30) DEFAULT 'Full-Time',
    payment_status VARCHAR(20) NOT NULL,
    
    PRIMARY KEY (enrollment_id),
    
    -- Enforcing unique combo to prevent a student from enrolling in the same course twice
    CONSTRAINT uq_student_course UNIQUE (student_id, course_id),
    
    -- Enforcing conditional checks for standard categorical text values
    CONSTRAINT chk_payment_values CHECK (payment_status IN ('Paid', 'Pending', 'Refunded')),
    
    -- Setting up the Foreign Key link to training_courses table
    -- ON DELETE CASCADE ensures if a course is deleted, its enrollment logs are also cleaned automatically
    CONSTRAINT fk_enrolled_course 
        FOREIGN KEY (course_id) REFERENCES training_courses(course_id)
        ON DELETE CASCADE
);


-- 3. SCHEMA INTEGRITY DEMONSTRATION (Adding Constraints to existing tables)
-- What if we forgot to add a foreign key to student_profiles during initial setup?
-- We can alter the table structure retroactively:

-- Adding a constraint safely on the fly:
-- ALTER TABLE course_enrollments 
-- ADD CONSTRAINT fk_enrolled_student 
-- FOREIGN KEY (student_id) REFERENCES student_profiles(student_id);


-- =====================================================================
-- 📝 STUDENT REFLECTION & QUICK REVISION
-- - UNIQUE(col1, col2) creates a composite key preventing duplicate entries across pairs.
-- - CHECK (column IN (...)) works exactly like a validation filter for data inputs.
-- - ON DELETE CASCADE prevents 'Orphaned Rows' by keeping child tables completely sync-deleted.
-- =====================================================================
