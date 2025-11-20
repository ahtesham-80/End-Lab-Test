/* ============================================
   ONLINE COURSE ENROLLMENT SYSTEM (MySQL)
   Full Schema + Sample Data + Queries
   ============================================ */


-- =========================
-- 1) CREATE TABLES
-- =========================


-- TABLE: Students
CREATE TABLE Students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(120) UNIQUE NOT NULL,
    registered_on DATETIME DEFAULT CURRENT_TIMESTAMP
);


-- TABLE: Courses
CREATE TABLE Courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(100) NOT NULL,
    instructor VARCHAR(100),
    duration_weeks INT
);


-- TABLE: Enrollments
CREATE TABLE Enrollments (
    enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    course_id INT,
    enrollment_date DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);



-- =========================
-- 2) INSERT SAMPLE DATA
-- =========================


-- Sample Students
INSERT INTO Students (full_name, email)
VALUES 
('Ahtesham', 'ahtesh@example.com'),
('Rahul Sharma', 'rahul@example.com'),
('Priya Reddy', 'priya@example.com');


-- Sample Courses
INSERT INTO Courses (course_name, instructor, duration_weeks)
VALUES
('Python Programming', 'Dr. Mehta', 6),
('Web Development', 'Ms. Ananya', 8),
('Data Science Basics', 'Prof. Ghosh', 10);



-- =========================
-- 3) OPERATIONS (QUERIES)
-- =========================


-- A) Enroll a student in a course
-- Example: Enroll student_id = 1 into course_id = 2
INSERT INTO Enrollments (student_id, course_id)
VALUES (1, 2);


-- Additional enrollments for testing
INSERT INTO Enrollments (student_id, course_id) VALUES (2, 1);
INSERT INTO Enrollments (student_id, course_id) VALUES (3, 1);
INSERT INTO Enrollments (student_id, course_id) VALUES (3, 3);



-- B) List all students enrolled in a specific course
-- Example: course_id = 1 (Python Programming)
SELECT 
    S.student_id,
    S.full_name,
    S.email,
    C.course_name
FROM Enrollments E
JOIN Students S ON E.student_id = S.student_id
JOIN Courses C ON E.course_id = C.course_id
WHERE E.course_id = 1;



-- C) Count total enrollments per course
SELECT 
    C.course_name,
    COUNT(E.student_id) AS total_enrollments
FROM Courses C
LEFT JOIN Enrollments E ON C.course_id = E.course_id
GROUP BY C.course_name
ORDER BY total_enrollments DESC;
