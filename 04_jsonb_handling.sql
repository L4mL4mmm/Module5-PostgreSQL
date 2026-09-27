-- 1. Thêm cột extra_info
ALTER TABLE students 
ADD COLUMN IF NOT EXISTS extra_info JSONB;

-- 2. Cập nhật dữ liệu JSON cho 2 sinh viên
UPDATE students
SET extra_info = '{"skills": ["Giao tiếp", "Làm việc nhóm"], "toeic": 750}'::jsonb
WHERE student_id = 1;

UPDATE students
SET extra_info = '{"skills": ["Thuyết trình", "Tiếng Anh"], "toeic": 650}'::jsonb
WHERE student_id = 2;

-- 3. Truy vấn sinh viên có điểm TOEIC >= 700
-- Toán tử ->> trích xuất giá trị dưới dạng text, ép kiểu sang int để so sánh
SELECT 
    student_id,
    full_name,
    extra_info->>'toeic' AS toeic_score,
    extra_info->'skills' AS skills
FROM students
WHERE (extra_info->>'toeic')::int >= 700;