import test from "node:test";
import assert from "node:assert/strict";
import { pool } from "../db.js";
import * as students from "../controllers/students.controller.js";
import * as staff from "../controllers/staff.controller.js";
import * as classes from "../controllers/classes.controller.js";
import * as exams from "../controllers/exams.controller.js";
import * as studentSubjects from "../controllers/student_subjects.controller.js";
import * as staffSubjects from "../controllers/staff_subjects.controller.js";
import createSubjectSchema from "../dtos/createSubject.dto.js";
import createStaffSchema from "../dtos/createStaff.dto.js";
import createStudentSchema from "../dtos/createStudent.dto.js";
import createStaffSubjectSchema from "../dtos/createStaffSubject.dto.js";

test("all create and update handlers reject invalid bodies before database access", async (t) => {
  const query = t.mock.method(pool, "query", () => {
    throw new Error("Unexpected database query");
  });
  const handlers = [
    students.createStudent, students.updateStudent,
    staff.createStaff, staff.updateStaff,
    classes.createClass, classes.updateClass,
    exams.createExam, exams.updateExam,
    studentSubjects.createStudentSubject, staffSubjects.createStaffSubject,
  ];

  for (const handler of handlers) {
    await assert.rejects(handler({ body: {}, params: { id: "1" } }, {}), {
      statusCode: 400,
    });
  }
  assert.equal(query.mock.callCount(), 0);
});

test("class years and staff database fields are validated", () => {
  assert.equal(createSubjectSchema.safeParse({
    name: "Potions", start_year: 5, end_year: 4,
  }).success, false);
  assert.equal(createStaffSchema.safeParse({
    first_name: null, last_name: null, active_status: true, health_status: "Alive",
  }).success, false);
  assert.equal(createStaffSchema.safeParse({
    first_name: "Minerva", fk_house: 9, active_status: false,
    health_status: "Alive", final_day: null,
  }).success, true);
  assert.equal(createStaffSchema.safeParse({
    first_name: "Minerva", active_status: true, health_status: "Alive",
    role: "Teacher",
  }).success, false);
});

test("student fields match the database schema", () => {
  const result = createStudentSchema.safeParse({
    first_name: "Neville", last_name: "Longbottom", fk_house: 9,
    birthday: "1980-07-30",
  });
  assert.equal(result.success, true);
  assert.equal(result.data.birthday, "1980-07-30");
  assert.equal(createStudentSchema.safeParse({ house: 9 }).success, false);
});

test("staff-subject creation saves its role", async (t) => {
  const calls = [];
  t.mock.method(pool, "query", async (sql, values) => {
    calls.push({ sql, values });
    if (calls.length === 1) return { rows: [] };
    return { rows: [{ fk_staff_id: 5, fk_subject_id: 13, role: "Teacher" }] };
  });
  let response;
  const res = {
    status(code) { assert.equal(code, 201); return this; },
    json(value) { response = value; },
  };
  await staffSubjects.createStaffSubject({
    body: { fk_staff_id: 5, fk_subject_id: 13, role: "Teacher" },
  }, res);

  assert.deepEqual(calls[1].values, [5, 13, "Teacher"]);
  assert.match(calls[1].sql, /INSERT INTO staff_subjects/);
  assert.equal(response.role, "Teacher");
  assert.equal(createStaffSubjectSchema.safeParse({
    fk_staff_id: 5, fk_subject_id: 13, role: null,
  }).success, true);
  assert.equal(createStaffSubjectSchema.safeParse({
    teacher_id: 5, class_id: 13, role: "Teacher",
  }).success, false);
});

test("student-subject creation uses schema field names", async (t) => {
  const calls = [];
  t.mock.method(pool, "query", async (sql, values) => {
    calls.push({ sql, values });
    if (calls.length === 1) return { rows: [] };
    return { rows: [{ fk_student_id: 10, fk_subject_id: 11, year: 1 }] };
  });
  const res = { status() { return this; }, json() {} };
  await studentSubjects.createStudentSubject({
    body: { fk_student_id: 10, fk_subject_id: 11, year: 1 },
  }, res);
  assert.deepEqual(calls[1].values, [10, 11, 1]);
  assert.match(calls[1].sql, /INSERT INTO students_subjects/);
});

test("staff create passes all validated fields to the database", async (t) => {
  const calls = [];
  t.mock.method(pool, "query", async (sql, values) => {
    calls.push({ sql, values });
    if (calls.length === 1) return { rows: [] };
    if (calls.length === 2) return { rows: [{ id: 5 }] };
    return { rows: [{ id: 5 }] };
  });
  const body = {
    first_name: "Minerva", last_name: "McGonagall", fk_house: 9,
    active_status: false, health_status: "Alive", birthday: null,
    date_of_hiring: "1990-01-01", final_day: null,
  };
  let response;
  const res = {
    status(code) { assert.equal(code, 201); return this; },
    json(value) { response = value; },
  };

  await staff.createStaff({ body }, res);

  assert.deepEqual(calls[1].values, [
    "Minerva", "McGonagall", 9, false, "Alive", null, "1990-01-01", null,
  ]);
  assert.match(calls[1].sql, /fk_house/);
  assert.equal(response.id, 5);
});

test("staff update passes validated full replacement fields to the database", async (t) => {
  const calls = [];
  t.mock.method(pool, "query", async (sql, values) => {
    calls.push({ sql, values });
    if (calls.length === 1) return { rows: [{ id: 5 }] };
    return { rows: [{ id: 5, "first name": "Minerva" }] };
  });
  const body = {
    first_name: "Minerva", last_name: "McGonagall", fk_house: 9,
    active_status: false, health_status: "Alive", birthday: null,
    date_of_hiring: "1990-01-01", final_day: null,
  };
  let response;
  const res = {
    status(code) { assert.equal(code, 200); return this; },
    json(value) { response = value; },
  };

  await staff.updateStaff({ params: { id: "5" }, body }, res);

  assert.deepEqual(calls[0].values, [
    "Minerva", "McGonagall", 9, false, "Alive", null, "1990-01-01", null, "5",
  ]);
  assert.match(calls[0].sql, /fk_house = \$3/);
  assert.equal(response.id, 5);
});

test("staff update returns 404 when no row matches", async (t) => {
  t.mock.method(pool, "query", async () => ({ rows: [] }));
  await assert.rejects(staff.updateStaff({
    params: { id: "99" },
    body: { first_name: "Minerva", active_status: true, health_status: "Alive" },
  }, {}), { statusCode: 404 });
});
