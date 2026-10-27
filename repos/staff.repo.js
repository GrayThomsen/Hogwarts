import { pool } from "../db.js";

//* Repository functions for handling Hogwarts staff data

export async function getAllStaff() {
  const result = await pool.query("SELECT * FROM staff");
  return result.rows;
}

export async function getStaffById(id) {
  const result = await pool.query("SELECT * FROM staff WHERE id = $1", [id]);
  return result.rows[0];
}

export async function findStaff(first_name, last_name, role) {
  const result = await pool.query(
    "SELECT * FROM staff WHERE first_name = $1 AND last_name = $2 AND role = $3",
    [first_name, last_name, role],
  );
  return result.rows[0];
}

export async function createStaff(first_name, last_name, role) {
  const result = await pool.query(
    "INSERT INTO staff (first_name, last_name, role) VALUES ($1, $2, $3) RETURNING *",
    [first_name, last_name, role],
  );
  return result.rows[0];
}

export async function updateStaff(id, first_name, last_name, role) {
  const result = await pool.query(
    "UPDATE staff SET first_name = $1, last_name = $2, role = $3 WHERE id = $4 RETURNING *",
    [first_name, last_name, role, id],
  );
  return result.rows[0];
}

export async function deleteStaff(id) {
  const result = await pool.query(
    "DELETE FROM staff WHERE id = $1 RETURNING *",
    [id],
  );
  return result.rows[0];
}
