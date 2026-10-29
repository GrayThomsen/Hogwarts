import { pool } from "../db.js";

export async function getAllTeacherClasses() {
  const result = await pool.query("SELECT * FROM teacher_classes join classes on teacher_classes.class_id = classes.id join staff on teacher_classes.teacher_id = staff.id");
  return result.rows;
}

export async function createTeacherClass(teacher_id, class_id) {
  const result = await pool.query(
    "INSERT INTO teacher_classes (teacher_id, class_id) VALUES ($1, $2) RETURNING *",
    [teacher_id, class_id],
  );
  return result.rows[0];
}

export async function deleteTeacherClass(teacher_id, class_id) {
  const result = await pool.query(
    "DELETE FROM teacher_classes WHERE teacher_id = $1 AND class_id = $2 RETURNING *",
    [teacher_id, class_id],
  );
  return result.rows[0];
}
