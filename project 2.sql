

CREATE TABLE Students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    student_name VARCHAR(100),
    department VARCHAR(50)
);


CREATE TABLE Courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(100)
);


CREATE TABLE Attendance (
    attendance_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    course_id INT,
    attendance_date DATE,
    status VARCHAR(10),  -- 'Present' or 'Absent'
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
); 

insert into students(student_name,department) values
('arun kumar','computer science'),
('meena devi','computer science'),
('vijay raj','information technology'),
('priya sharma','information technology'),
('rahul das','electronics');

insert into courses(courses_name)values
('database system'),
('computer network'),
('data structure');

insert into attendance (student_id,courses_id,
attendance_date,status)values
(1,1,'2025-10-01','present'),
(1,1,'2025-10-02','absent'),
(1,2,'2025-10-01','present'),
(2,1,'2025-10-01','present'),
(2,1,'2025-10-02','present'),
(3,2,'2025-10-01','absent'),
(3,2,'2025-10-01','present'),
(4,3,'2025-10-01','present'),
(5,3,'2025-10-01','absent');

SELECT 
    s.student_name,
    SUM(CASE WHEN a.status = 'Present' THEN 1 ELSE 0 END) AS Total_Present,
    SUM(CASE WHEN a.status = 'Absent' THEN 1 ELSE 0 END) AS Total_Absent
FROM Students s
LEFT JOIN Attendance a ON s.student_id = a.student_id
GROUP BY s.student_name;
SELECT 
    s.student_name,
    ROUND(
        (SUM(CASE WHEN a.status='Present' THEN 1 ELSE 0 END) / COUNT(a.attendance_id)) * 100,
        2
    ) AS Attendance_Percentage
FROM Students s
JOIN Attendance a ON s.student_id = a.student_id
GROUP BY s.student_name
ORDER BY Attendance_Percentage DESC
LIMIT 3;
SELECT 
    c.course_name,
    ROUND(
        (SUM(CASE WHEN a.status='Present' THEN 1 ELSE 0 END) / COUNT(a.attendance_id)) * 100,
        2
    ) AS Course_Attendance_Percentage
FROM Courses c
JOIN Attendance a ON c.course_id = a.course_id
GROUP BY c.course_name;

