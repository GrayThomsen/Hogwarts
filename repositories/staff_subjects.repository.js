import { pool } from "../db.js";

export async function getAllStaffSubjects() {
  const result = await pool.query(/*SQL*/ `SELECT * FROM staff_subjects`);
  return result.rows;
}

export async function findStaffSubject(data) {
  const result = await pool.query(
    /*SQL*/ `SELECT * FROM staff_subjects WHERE fk_staff_id = $1 AND fk_subject_id = $2`,
    [data.fk_staff_id, data.fk_subject_id],
  );
  return result.rows[0];
}

export async function createStaffSubject(data) {
  const result = await pool.query(
    /*SQL*/ `INSERT INTO staff_subjects (fk_staff_id, fk_subject_id, role) VALUES ($1, $2, $3) RETURNING *`,
    [data.fk_staff_id, data.fk_subject_id, data.role],
  );
  return result.rows[0];
}

export async function deleteStaffSubject(data) {
  const result = await pool.query(
    /*SQL*/ `DELETE FROM staff_subjects WHERE fk_staff_id = $1 AND fk_subject_id = $2 RETURNING *`,
    [data.fk_staff_id, data.fk_subject_id],
  );
  return result.rows[0];
}
