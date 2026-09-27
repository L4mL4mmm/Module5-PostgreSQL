WITH school_average AS (
    SELECT AVG(gpa) AS avg_gpa
    FROM students
)
SELECT 
    s.student_id,
    s.full_name,
    s.gpa
FROM students s, school_average sa
WHERE s.gpa > sa.avg_gpa
ORDER BY s.gpa DESC;