import { pool } from "../db.js";
//* Repository functions for handling Hogwarts students data

//? Specific variable for fetching student data along with their house information. Maybe Peter has a better way to do this?
const STUDENT_WITH_HOUSE = `
  SELECT
    students.id,
    students.first_name,
    students.last_name,
    houses.name AS house
  FROM students
  LEFT JOIN houses ON students.house = houses.id
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

export async function findStudent(first_name, last_name, house) {
  const result = await pool.query(
    "SELECT * FROM students WHERE first_name = $1 AND last_name = $2 AND house = $3",
    [first_name, last_name, house],
  );
  return result.rows[0];
}

export async function createStudent(first_name, last_name, house) {
  const result = await pool.query(
    "INSERT INTO students (first_name, last_name, house) VALUES ($1, $2, $3) RETURNING *",
    [first_name, last_name, house],
  );
  return result.rows[0];
}

export async function updateStudent(id, first_name, last_name, house) {
  const result = await pool.query(
    "UPDATE students SET first_name = $1, last_name = $2, house = $3 WHERE id = $4 RETURNING *",
    [first_name, last_name, house, id],
  );
  return result.rows[0];
}

export async function deleteStudent(id) {
  const result = await pool.query(
    "DELETE FROM students WHERE id = $1 RETURNING *",
    [id],
  );
  return result.rows[0];
}
