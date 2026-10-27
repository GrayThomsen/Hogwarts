import { pool } from "../db.js";

//* Repository functions for handling Hogwarts classes data

export async function getAllClasses() {
  const result = await pool.query("SELECT * FROM classes");
  return result.rows;
}

export async function getClassById(id) {
  const result = await pool.query("SELECT * FROM classes WHERE id = $1", [id]);
  return result.rows[0];
}

export async function getClassByName(name) {
  const result = await pool.query("SELECT * FROM classes WHERE name = $1", [
    name,
  ]);
  return result.rows[0];
}

export async function createClass(name) {
  const result = await pool.query(
    "INSERT INTO classes (name) VALUES ($1) RETURNING *",
    [name],
  );
  return result.rows[0];
}

export async function updateClass(id, name) {
  const result = await pool.query(
    "UPDATE classes SET name = $1 WHERE id = $2 RETURNING *",
    [name, id],
  );
  return result.rows[0];
}

export async function deleteClass(id) {
  const result = await pool.query(
    "DELETE FROM classes WHERE id = $1 RETURNING *",
    [id],
  );
  return result.rows[0];
}
