# Hogwarts API

This document describes the API routes currently implemented in `server.js`.
The server listens on port `3000` and accepts JSON request bodies.

## Houses

- `GET /houses` - Return all houses (`200`). If there are no houses, return
  `404` with `{"error":"Houses not found"}`.
- `GET /houses/:id` - Return the house with that ID (`200`). If it does not
  exist, return `404` with `{"error":"House not found"}`.

## Students

- `GET /students` - Return all students, including the house name (`200`). If
  there are no students, return `404` with `{"error":"No students found"}`.
- `GET /students/:id` - Return the student with that ID, including the house
  name (`200`). If the student does not exist, return `404` with
  `{"error":"Student not found"}`.
- `POST /students` - Create a student using `first_name`, `last_name`, and
  `house`. A student with the same first name, last name, and house is rejected
  with `400` and `{"error":"Student already exists"}`. Otherwise return the
  created database record with `201`.
- `PUT /students/:id` - Replace the student's `first_name`, `last_name`, and
  `house`. Return the updated record with `200`, or `404` with
  `{"error":"Student not found"}` if the ID does not exist.
- `DELETE /students/:id` - Delete and return the student record with `200`, or
  return `404` with `{"error":"Student not found"}` if the ID does not exist.

## Staff

- `GET /staff` - Return all staff members (`200`). If there are none, return
  `404` with `{"error":"Staff not found"}`.
- `GET /staff/:id` - Return the staff member with that ID (`200`). If the
  member does not exist, return `404` with
  `{"error":"Staff member not found"}`.
- `POST /staff` - Create a staff member using `first_name`, `last_name`, and
  `role`. A matching first name, last name, and role is rejected with `400` and
  `{"error":"Staff member already exists"}`. Otherwise return the created
  record with `201`.
- `PUT /staff/:id` - Replace the staff member's `first_name`, `last_name`, and
  `role`. Return the updated record with `200`, or `404` with
  `{"error":"Staff member not found"}` if the ID does not exist.
- `DELETE /staff/:id` - Delete and return the staff record with `200`, or
  return `404` with `{"error":"Staff member not found"}` if the ID does not
  exist.

## Classes

- `GET /classes` - Return all classes (`200`). If there are none, return `404`
  with `{"error":"No classes found"}`.
- `GET /classes/:id` - Return the class with that ID (`200`). If it does not
  exist, return `404` with `{"error":"Class not found"}`.
- `POST /classes` - Create a class using `name`. A class with the same name is
  rejected with `409` and
  `{"error":"Class with the same name already exists"}`. Otherwise return the
  created record with `201`.
- `PUT /classes/:id` - Update the class's `name`. Return the updated record
  with `200`, or `404` with `{"error":"Class not found"}` if the ID does not
  exist.
- `DELETE /classes/:id` - Delete and return the class record with `200`, or
  return `404` with `{"error":"Class not found"}` if the ID does not exist.

## Student-class assignments

- `GET /student_classes` - Return all student-class assignments (`200`). If
  there are none, return `404` with `{"error":"Student not found"}`.
- `POST /student_classes` - Create an assignment using `student_id`, `class_id`,
  and `year`. If that combination already exists, return `409` with
  `{"error":"Student-class combination already exists"}`. Otherwise return the
  created record with `201`.
- `DELETE /student_classes/:student_id/:class_id/:year` - Delete and return the
  matching assignment with `200`, or return `404` with
  `{"error":"Student-class assignment not found"}` if it does not exist.

## Teacher-class assignments

- `GET /teacher_classes` - Return all teacher-class assignments (`200`). If
  there are none, return `404` with
  `{"error":"No teacher-class assignments found"}`.
- `POST /teacher_classes` - Create an assignment using `teacher_id` and `class_id`. If that combination already exists, return `409` with
  `{"error":"Teacher-class combination already exists"}`. Otherwise return the
  created record with `201`.
- `DELETE /teacher_classes/:teacher_id/:class_id` - Delete and return the
  matching assignment with `200`, or return `404` with
  `{"error":"Teacher-class assignment not found"}` if it does not exist.
- `POST /teacher_classes` - Create an assignment using `teacher_id`, `class_id`,
  and `year`. If that combination already exists, return `409` with
  `{"error":"Teacher-class combination already exists"}`. Otherwise return the
  created record with `201`.
- `DELETE /teacher_classes/:teacher_id/:class_id/:year` - Delete and return the
  matching assignment with `200`, or return `404` with
  `{"error":"Teacher-class assignment not found"}` if it does not exist.

## Errors

Routes return `500` with `{"error":"Database error"}` when a database operation
fails. The error is also logged by the server.
