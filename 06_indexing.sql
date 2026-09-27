-- 1. Kiểm tra kế hoạch thực thi TRƯỚC KHI tạo Index
EXPLAIN ANALYZE 
SELECT * FROM students 
WHERE email = 'nguyenvana@sis.hust.edu.vn';
-- (Chụp ảnh kết quả: Quan sát dòng 'Seq Scan on students' và Execution Time)

-- 2. Tạo Unique Index
CREATE UNIQUE INDEX idx_students_email ON students(email);

-- 3. Kiểm tra kế hoạch thực thi SAU KHI tạo Index
EXPLAIN ANALYZE 
SELECT * FROM students 
WHERE email = 'nguyenvana@sis.hust.edu.vn';
-- (Chụp ảnh kết quả: Quan sát chuyển thành 'Index Scan using idx_students_email')