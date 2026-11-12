import { pool } from "../db.js";

//* Repository functions for handling Hogwarts staff data

export async function getAllStaff() {
  const result =
    await pool.query(/* SQL*/ ` select staff.id, staff.first_name, staff.last_name, houses.name as house
from staff
         full join houses
                   on staff.house = houses.id;`);
  return result.rows;
}

export async function getStaffById(id) {
  const result = await pool.query(
    /* SQL*/ ` select staff.id, staff.first_name as "first name", staff.last_name as "last name", houses.name as house
from staff
         full join houses
                   on staff.house = houses.id
where staff.id = $1`,
    [id],
  );
  return result.rows[0];
}

export async function findStaff(first_name, last_name, role, house) {
  const result = await pool.query(
    "SELECT * FROM staff WHERE first_name = $1 AND last_name = $2 AND role = $3 AND house = $4",
    [first_name, last_name, role, house],
  );
  return result.rows[0];
}

export async function createStaff(first_name, last_name, role, house) {
  const result = await pool.query(
    "INSERT INTO staff (first_name, last_name, role, house) VALUES ($1, $2, $3, $4) RETURNING *",
    [first_name, last_name, role, house],
  );
  return result.rows[0];
}

export async function updateStaff(id, first_name, last_name, role, house) {
  const result = await pool.query(
    "UPDATE staff SET first_name = $1, last_name = $2, role = $3, house = $4 WHERE id = $5 RETURNING *",
    [first_name, last_name, role, house, id],
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
