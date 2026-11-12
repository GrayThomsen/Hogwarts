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

export async function findStaff(teacher) {
  const result = await pool.query(
    "SELECT * FROM staff WHERE first_name = $1 AND last_name = $2 AND role = $3 AND house = $4",
    [teacher.first_name, teacher.last_name, teacher.role, teacher.house],
  );
  return result.rows[0];
}

export async function createStaff(teacher) {
  const result = await pool.query(
    "INSERT INTO staff (first_name, last_name, role, house) VALUES ($1, $2, $3, $4) RETURNING id",
    [teacher.first_name, teacher.last_name, teacher.role, teacher.house],
  );
  const newStaffId = result.rows[0].id;

console.log(teacher.house);

  return getStaffById(newStaffId);
}

export async function updateStaff(id, teacher) {
  const updates = [];
  const values = [];
  let paramCount = 1;

  if (teacher.first_name !== undefined) {
    updates.push(`first_name = $${paramCount}`);
    values.push(teacher.first_name);
    paramCount++;
  }
  if (teacher.last_name !== undefined) {
    updates.push(`last_name = $${paramCount}`);
    values.push(teacher.last_name);
    paramCount++;
  }
  if (teacher.role !== undefined) {
    updates.push(`role = $${paramCount}`);
    values.push(teacher.role);
    paramCount++;
  }
  if (teacher.house !== undefined) {
    updates.push(`house = $${paramCount}`);
    values.push(teacher.house);
    paramCount++;
  }

  if (updates.length === 0) {
    return getStaffById(id);
  }

  values.push(id);
  const query = `UPDATE staff SET ${updates.join(", ")} WHERE id = $${paramCount} RETURNING id`;
  const result = await pool.query(query, values);

  if (result.rows.length === 0) {
    return null;
  }

  return getStaffById(result.rows[0].id);
}

export async function deleteStaff(id) {
  const result = await pool.query(
    "DELETE FROM staff WHERE id = $1 RETURNING *",
    [id],
  );
  return result.rows[0];
}
