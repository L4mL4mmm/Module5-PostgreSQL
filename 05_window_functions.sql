SELECT 
    student_id,
    full_name,
    dept_id,
    gpa,
    DENSE_RANK() OVER (
        PARTITION BY dept_id 
        ORDER BY gpa DESC
    ) AS rank_in_dept
FROM students
ORDER BY dept_id ASC, rank_in_dept ASC;