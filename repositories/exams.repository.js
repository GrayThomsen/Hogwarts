import { pool } from "../db.js";

export async function getAllExams() {
  const result = await pool.query(/*SQL*/ `SELECT 
    concat(student.first_name, ' ', student.last_name) AS "student name", 
    subjects.name as subject,
    exams.date,
    grades.name as grade,
    qualifications.name as qualification,
    regulators.name as regulator
    FROM exams
    JOIN students AS student ON exams.fk_student_id = student.id
    JOIN subjects ON exams.fk_subject_id = subjects.id
    JOIN grades ON exams.fk_grade_id = grades.id
    JOIN qualifications ON exams.fk_qualifications = qualifications.id
    JOIN regulators ON exams.fk_regulators = regulators.id`);
  return result.rows;
}

export async function getExamById(id) {
  const result = await pool.query(
    /*SQL*/ `SELECT 
    concat(student.first_name, ' ', student.last_name) AS "student name", 
    subjects.name as subject,
    exams.date,
    grades.name as grade,
    qualifications.name as qualification,
    regulators.name as regulator
    FROM exams
    JOIN students AS student ON exams.fk_student_id = student.id
    JOIN subjects ON exams.fk_subject_id = subjects.id
    JOIN grades ON exams.fk_grade_id = grades.id
    JOIN qualifications ON exams.fk_qualifications = qualifications.id
    JOIN regulators ON exams.fk_regulators = regulators.id
    WHERE exams.id = $1`,
    [id],
  );
  return result.rows[0];
}

export async function getExamsByStudentId(studentId) {
  const result = await pool.query(
    /*SQL*/ `SELECT 
    concat(student.first_name, ' ', student.last_name) AS "student name", 
    subjects.name as subject,
    exams.date,
    grades.name as grade,
    qualifications.name as qualification,
    regulators.name as regulator
    FROM exams
    JOIN students AS student ON exams.fk_student_id = student.id
    JOIN subjects ON exams.fk_subject_id = subjects.id
    JOIN grades ON exams.fk_grade_id = grades.id
    JOIN qualifications ON exams.fk_qualifications = qualifications.id
    JOIN regulators ON exams.fk_regulators = regulators.id
    WHERE student.id = $1`,
    [studentId],
  );
  return result.rows;
}

export async function deleteExam(id) {
  const result = await pool.query(
    /*SQL*/ `DELETE FROM exams WHERE id = $1 RETURNING *`,
    [id],
  );
  return result.rows[0];
}

export async function createExam(exam) {
  const result = await pool.query(
    /*SQL*/ `INSERT INTO exams (fk_student_id, fk_subject_id, date, fk_grade_id, fk_qualifications, fk_regulators) VALUES ($1, $2, $3, $4, $5, $6) RETURNING *`,
    [
      exam.fk_student_id,
      exam.fk_subject_id,
      exam.date,
      exam.fk_grade_id,
      exam.fk_qualifications,
      exam.fk_regulators,
    ],
  );
  return result.rows[0];
}

export async function updateExam(id, exam) {
  const result = await pool.query(
    /*SQL*/ `UPDATE exams SET fk_student_id = $1, fk_subject_id = $2, date = $3, fk_grade_id = $4, fk_qualifications = $5, fk_regulators = $6 WHERE id = $7 RETURNING *`,
    [
      exam.fk_student_id,
      exam.fk_subject_id,
      exam.date,
      exam.fk_grade_id,
      exam.fk_qualifications,
      exam.fk_regulators,
      id,
    ],
  );
  return result.rows[0];
}
