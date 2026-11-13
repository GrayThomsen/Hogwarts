import { pool } from "../db.js";

//* Repository functions for handling Hogwarts staff data

export async function getAllStaff() {
  const result =
    await pool.query(/* SQL*/ ` select staff.id, staff.first_name as "first name", staff.last_name as "last name", houses.name as house, active_status as "active status", health_status as "health status", birthday, date_of_hiring as "date of hire", final_day as "final day"
from staff
full join houses on staff.fk_house = houses.id;`);
  return result.rows;
}

export async function getStaffById(id) {
  const result = await pool.query(
    /* SQL*/ ` select staff.id, staff.first_name as "first name", staff.last_name as "last name", houses.name as house, active_status as "active status", health_status as "health status", birthday, date_of_hiring as "date of hire", final_day as "final day"
from staff full join houses
on staff.fk_house = houses.id
where staff.id = $1`,
    [id],
  );
  return result.rows[0];
}

export async function findStaff(staff) {
  const result = await pool.query(
    /*SQL*/ `SELECT * FROM staff WHERE first_name IS NOT DISTINCT FROM $1 AND last_name IS NOT DISTINCT FROM $2 AND fk_house IS NOT DISTINCT FROM $3 AND active_status = $4 AND health_status = $5 AND birthday IS NOT DISTINCT FROM $6 AND date_of_hiring IS NOT DISTINCT FROM $7 AND final_day IS NOT DISTINCT FROM $8`,
    [
      staff.first_name,
      staff.last_name,
      staff.fk_house,
      staff.active_status,
      staff.health_status,
      staff.birthday,
      staff.date_of_hiring,
      staff.final_day,
    ],
  );
  return result.rows[0];
}

export async function createStaff(staff) {
  const result = await pool.query(
    /*SQL*/ `INSERT INTO staff (first_name, last_name, fk_house, active_status, health_status, birthday, date_of_hiring, final_day) VALUES ($1, $2, $3, $4, $5, $6, $7, $8) RETURNING id`,
    [
      staff.first_name,
      staff.last_name,
      staff.fk_house,
      staff.active_status,
      staff.health_status,
      staff.birthday,
      staff.date_of_hiring,
      staff.final_day,
    ],
  );
  const newStaffId = result.rows[0].id;

  return getStaffById(newStaffId);
}

export async function updateStaff(id, staff) {
  const result = await pool.query(
    /*SQL*/ `UPDATE staff SET first_name = $1, last_name = $2, fk_house = $3, active_status = $4, health_status = $5, birthday = $6, date_of_hiring = $7, final_day = $8 WHERE id = $9 RETURNING id`,
    [
      staff.first_name,
      staff.last_name,
      staff.fk_house,
      staff.active_status,
      staff.health_status,
      staff.birthday,
      staff.date_of_hiring,
      staff.final_day,
      id,
    ],
  );

  if (result.rows.length === 0) {
    return null;
  }
  return getStaffById(result.rows[0].id);
}

export async function deleteStaff(id) {
  const result = await pool.query(
    /*SQL*/ `DELETE FROM staff WHERE id = $1 RETURNING *`,
    [id],
  );
  return result.rows[0];
}
