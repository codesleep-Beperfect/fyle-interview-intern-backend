-- SQL query to find the count of grade 'A' assignments for the teacher who has graded the most assignments

WITH TeacherGradedAssignments AS (
    SELECT
        teacher_id,
        COUNT(*) AS graded_count
    FROM
        assignments
    WHERE
        state = 'GRADED'
    GROUP BY
        teacher_id
),
MaxGradedTeacher AS (
    SELECT
        teacher_id
    FROM
        TeacherGradedAssignments
    ORDER BY
        graded_count DESC
    LIMIT 1  -- In case of ties, this will select only one teacher
)
SELECT
    COUNT(*) AS grade_a_count
FROM
    assignments
WHERE
    teacher_id = (SELECT teacher_id FROM MaxGradedTeacher)
    AND grade = 'A';
    