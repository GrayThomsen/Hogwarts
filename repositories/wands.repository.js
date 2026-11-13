import { pool } from "../db.js";
export async function getAllWands() {
  const result =
    await pool.query(/*SQL*/ `SELECT wands.*, concat(staff.first_name, ' ', staff.last_name) AS "staff name", concat(students.first_name, ' ', students.last_name) AS "student name" FROM wands
    LEFT JOIN staff ON wands.fk_staff_owner = staff.id
    LEFT JOIN students ON wands.fk_student_owner = students.id`);
  return result.rows;
}

export async function getWandById(id) {
  const result = await pool.query(
    /*SQL*/ `SELECT wands.*, concat(staff.first_name, ' ', staff.last_name) AS "staff name", concat(students.first_name, ' ', students.last_name) AS "student name" FROM wands
    LEFT JOIN staff ON wands.fk_staff_owner = staff.id
    LEFT JOIN students ON wands.fk_student_owner = students.id
    WHERE wands.id = $1`,
    [id],
  );
  return result.rows[0];
}
export async function getWandByStudentOwner(studentId) {
  const result = await pool.query(
    /*SQL*/ `SELECT wands.*, concat(staff.first_name, ' ', staff.last_name) AS "staff name", concat(students.first_name, ' ', students.last_name) AS "student name" FROM wands
    LEFT JOIN staff ON wands.fk_staff_owner = staff.id
    LEFT JOIN students ON wands.fk_student_owner = students.id
    WHERE students.id = $1`,
    [studentId],
  );
  return result.rows[0];
}
export async function getWandByStaffOwner(staffId) {
  const result = await pool.query(
    /*SQL*/ `SELECT wands.*, concat(staff.first_name, ' ', staff.last_name) AS "staff name", concat(students.first_name, ' ', students.last_name) AS "student name" FROM wands
    LEFT JOIN staff ON wands.fk_staff_owner = staff.id
    LEFT JOIN students ON wands.fk_student_owner = students.id
    WHERE wands.fk_staff_owner = $1`,
    [staffId],
  );
  return result.rows;
}

export async function createWand(wand) {
  const result = await pool.query(
    /*SQL*/ `INSERT INTO wands (fk_staff_owner, fk_student_owner, description) VALUES ($1, $2, $3) RETURNING *`,
    [wand.fk_staff_owner, wand.fk_student_owner, wand.description],
  );
  return result.rows[0];
}
