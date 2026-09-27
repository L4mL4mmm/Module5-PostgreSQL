SELECT 
    c.course_name,
    COUNT(e.student_id) AS total_enrolled_students,
    ROUND(AVG(e.grade)::numeric, 2) AS average_grade
FROM courses c
INNER JOIN enrollments e ON c.course_id = e.course_id
INNER JOIN students s ON e.student_id = s.student_id
GROUP BY c.course_id, c.course_name
ORDER BY average_grade DESC;