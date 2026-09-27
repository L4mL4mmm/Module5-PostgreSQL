BEGIN;

-- 1. Lưu lại điểm rollback gốc nếu cần hoàn tác hoàn toàn
SAVEPOINT initial_state;

-- 2. Xóa đăng ký khóa học "Lập trình Python" của sinh viên (ví dụ student_id = 1)
DELETE FROM enrollments
WHERE student_id = 1 
  AND course_id = (SELECT course_id FROM courses WHERE course_name = 'Lập trình Python');

-- 3. Tạo savepoint trước khi thực hiện hành động rủi ro
SAVEPOINT before_new_insert;

-- 4. Thử chèn bản ghi mới với giá trị cố tình vi phạm CHECK constraint (grade <= 10)
-- Nếu bảng chưa có constraint, lệnh này vẫn vi phạm nếu bạn có check constraint trên grade
INSERT INTO enrollments (student_id, course_id, grade)
VALUES (
    1, 
    (SELECT course_id FROM courses WHERE course_name = 'Cơ sở dữ liệu'), 
    12.0 -- Cố tình nhập sai điểm số (> 10)
);

-- Khi dòng trên báo lỗi:
-- Để sinh viên giữ nguyên khóa học cũ theo đúng yêu cầu đề bài, quay về initial_state:
ROLLBACK TO SAVEPOINT initial_state;

-- Chốt giao dịch an toàn (không bản ghi nào bị mất)
COMMIT;