-- =====================================================================
-- Module: Data Definition Language (DDL) Basics
-- Topic: Creating Databases, Tables, and Structural Modifications
-- Purpose: Building a clean student enrollment schema for analytics practice.
-- =====================================================================

-- 1. DATABASE CREATION & INITIALIZATION
-- Creating a dedicated workspace database for our data science practice
CREATE DATABASE analytics_practice_db;
USE analytics_practice_db;


-- 2. TABLE CREATION WITH ROBUST CONSTRAINTS
-- Design rules implemented:
-- - student_id: System-generated unique identifier (Primary Key)
-- - email: Cannot be duplicate (Unique)
-- - age: Enforcing a business rule that students must be adults (Check Constraint)
-- - enrollment_status: Automatically sets to 'Active' if not specified (Default)

CREATE TABLE student_profiles (
    student_id INT AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    age INT,
    enrollment_status VARCHAR(20) DEFAULT 'Active',
    joined_date DATE DEFAULT (CURRENT_DATE),
    
    -- Defining constraints at the table level for clean structure
    PRIMARY KEY (student_id),
    UNIQUE (email),
    CONSTRAINT chk_minimum_age CHECK (age >= 18)
);


-- 3. ALTER OPERATIONS (Modifying Schema Structure on the fly)
-- Real-world scenario: Requirements change! Let's update our table structure safely.

-- Action A: Adding a new column for tracking academic performance
ALTER TABLE student_profiles 
ADD gpa DECIMAL(3, 2);

-- Action B: Modifying an existing column data type to allow longer text strings
ALTER TABLE student_profiles 
MODIFY COLUMN enrollment_status VARCHAR(50) DEFAULT 'Active';

-- Action C: Dropping a column that is no longer required for data tracking
-- Let's simulate adding and removing a temporary tracking column
ALTER TABLE student_profiles ADD temporary_notes VARCHAR(100);
ALTER TABLE student_profiles DROP COLUMN temporary_notes;


-- 4. CLEANUP OPERATIONS (Documented for structural knowledge)
-- TRUNCATE TABLE student_profiles; 
-- Deletes all structural rows/data inside the table but keeps the columns and schema intact.

-- DROP TABLE student_profiles;      
-- Completely destroys the table structure and its data from the database.
