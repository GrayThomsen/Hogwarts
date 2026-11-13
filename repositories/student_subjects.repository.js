import { pool } from "../db.js";

export async function getAllStudentSubjects() {
  const result = await pool.query(/*SQL*/ `SELECT * FROM students_subjects`);
  return result.rows;
}

export async function createStudentSubject(assignment) {
  const result = await pool.query(
    /*SQL*/ `INSERT INTO students_subjects (fk_student_id, fk_subject_id, year) VALUES ($1, $2, $3) RETURNING *`,
    [assignment.fk_student_id, assignment.fk_subject_id, assignment.year],
  );
  return result.rows[0];
}

export async function deleteStudentSubject(assignment) {
  const result = await pool.query(
    /*SQL*/ `DELETE FROM students_subjects WHERE fk_student_id = $1 AND fk_subject_id = $2 AND year = $3 RETURNING *`,
    [assignment.fk_student_id, assignment.fk_subject_id, assignment.year],
  );
  return result.rows[0];
}
