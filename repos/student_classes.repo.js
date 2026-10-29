import { pool } from "../db.js";

//* Repository functions for handling Hogwarts student classes data

export async function getAllStudentClasses() {
  const result = await pool.query("SELECT * FROM student_classes");
  return result.rows;
}

export async function findStudentClassByIdsAndYear(student_id, class_id, year) {
  const result = await pool.query(
    "SELECT * FROM student_classes WHERE student_id = $1 AND class_id = $2 AND year = $3",
    [student_id, class_id, year],
  );
  return result.rows[0];
}

export async function createStudentClass(student_id, class_id, year) {
  const result = await pool.query(
    "INSERT INTO student_classes (student_id, class_id, year) VALUES ($1, $2, $3) RETURNING *",
    [student_id, class_id, year],
  );
  return result.rows[0];
}

export async function deleteStudentClass(student_id, class_id, year) {
  const result = await pool.query(
    "DELETE FROM student_classes WHERE student_id = $1 AND class_id = $2 AND year = $3 RETURNING *",
    [student_id, class_id, year],
  );
  return result.rows[0];
}
