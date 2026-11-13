import { pool } from "../db.js";

//* Repository functions for handling Hogwarts classes data

export async function getAllClasses() {
  const result = await pool.query(/* SQL */ `SELECT subjects.name as "class",
  subjects.name as "class",
  subjects.start_year as "beginning year",
  subjects.end_year as "finishing year",
  subject_type.name as "subject type",
  grades.name as "required grade",   
  staff.first_name as "First name",
  staff.last_name as "Last name",
  junction.role as "Role"
FROM subjects
LEFT JOIN grades ON subjects.fk_required_grade = grades.id
LEFT JOIN subject_type ON subjects.fk_type = subject_type.id
LEFT JOIN staff_subjects junction ON subjects.id = junction.fk_subject_id
LEFT JOIN staff ON junction.fk_staff_id = staff.id`);
  return result.rows;
}

export async function getClassById(id) {
  const result = await pool.query(
    /*SQL*/ ` SELECT
  subjects.name as "class",
  subjects.start_year as "beginning year",
  subjects.end_year as "finishing year",
  subject_type.name as "subject type",
  grades.name as "required grade",   
  staff.first_name as "First name",
  staff.last_name as "Last name",
  junction.role as "Role"
FROM subjects
/** A perfect example of why directions on joins can be important, without it, the query wouldn't find subject without teachers, as it is inherintly an INNER join. */
LEFT JOIN staff_subjects junction ON subjects.id = junction.fk_subject_id
LEFT JOIN staff ON junction.fk_staff_id = staff.id
LEFT JOIN grades ON subjects.fk_required_grade = grades.id
LEFT JOIN subject_type ON subjects.fk_type = subject_type.id

WHERE subjects.id = $1`,
    [id],
  );
  return result.rows[0];
}

export async function getClassByName(name) {
  const result = await pool.query(
    /*SQL*/ `SELECT subjects.name as "class",
  subjects.start_year as "beginning year",
  subjects.end_year as "finishing year",
  subject_type.name as "subject type",
  grades.name as "required grade",   
  staff.first_name as "First name",
  staff.last_name as "Last name",
  junction.role as "Role"
FROM subjects
/** A perfect example of why directions on joins can be important, without it, the query wouldn't find subject without teachers, as it is inherintly an INNER join. */
LEFT JOIN staff_subjects junction ON subjects.id = junction.fk_subject_id
LEFT JOIN staff ON junction.fk_staff_id = staff.id
LEFT JOIN grades ON subjects.fk_required_grade = grades.id
LEFT JOIN subject_type ON subjects.fk_type = subject_type.id
WHERE subjects.name = $1`,
    [name],
  );
  return result.rows[0];
}

export async function createClass(classData) {
  const result = await pool.query(
    /*SQL*/ `INSERT INTO subjects (name, start_year, end_year, fk_type, fk_required_grade) VALUES ($1, $2, $3, $4, $5) RETURNING *`,
    [
      //* Only one deconstruction in the whole flow, and it is here... and technically in the SQL above, as it is needed.
      classData.name,
      classData.start_year,
      classData.end_year,
      classData.fk_type,
      classData.fk_required_grade,
    ],
  );
  return result.rows[0];
}

export async function updateClass(id, classData) {
  const result = await pool.query(
    /*SQL*/ `UPDATE subjects SET name = $2, start_year = $3, end_year = $4, fk_type = $5, fk_required_grade = $6 WHERE id = $1 RETURNING *`,
    [
      id,
      classData.name,
      classData.start_year,
      classData.end_year,
      classData.fk_type,
      classData.fk_required_grade,
    ],
  );
  return result.rows[0];
}

export async function deleteClass(id) {
  const result = await pool.query(
    /*SQL*/ `DELETE FROM subjects WHERE id = $1 RETURNING *`,
    [id],
  );
  return result.rows[0];
}
