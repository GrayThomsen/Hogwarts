import { pool } from "../db.js";
//* Repository functions for handling Hogwarts students data

//? Specific variable for fetching student data along with their house information. Maybe Peter has a better way to do this?
const STUDENT_WITH_HOUSE = /*SQL*/ `
  SELECT
    students.id,
    students.first_name,
    students.last_name,
    houses.name AS house,
    students.birthday
  FROM students
  LEFT JOIN houses ON students.fk_house = houses.id
`;

export async function getAllStudents() {
  const result = await pool.query(`${STUDENT_WITH_HOUSE} ORDER BY students.id`);
  return result.rows;
}

export async function getStudentById(id) {
  const result = await pool.query(
    `${STUDENT_WITH_HOUSE} WHERE students.id = $1`,
    [id],
  );
  return result.rows[0];
}

export async function findStudent(student) {
  const result = await pool.query(
    /*SQL*/ `SELECT * FROM students WHERE first_name IS NOT DISTINCT FROM $1 AND last_name IS NOT DISTINCT FROM $2 AND fk_house IS NOT DISTINCT FROM $3`,
    [student.first_name, student.last_name, student.fk_house],
  );
  return result.rows[0];
}

export async function createStudent(student) {
  const result = await pool.query(
    /*SQL*/ `INSERT INTO students (first_name, last_name, fk_house, birthday) VALUES ($1, $2, $3, $4) RETURNING *`,
    [student.first_name, student.last_name, student.fk_house, student.birthday],
  );
  return result.rows[0];
}

export async function updateStudent(id, student) {
  const result = await pool.query(
    /*SQL*/ `UPDATE students SET first_name = $1, last_name = $2, fk_house = $3, birthday = $4 WHERE id = $5 RETURNING *`,
    [student.first_name, student.last_name, student.fk_house, student.birthday, id],
  );
  return result.rows[0];
}

export async function deleteStudent(id) {
  const result = await pool.query(
    /*SQL*/ `DELETE FROM students WHERE id = $1 RETURNING *`,
    [id],
  );
  return result.rows[0];
}
