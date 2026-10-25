# This is a document, containing an overview of the Hogwarts API endpoints.
**Written by @GrayThomsen**.

Also known as "Suppekode" by the great Peter Lind, this doc will provide an explanation of which API calls are available and what they do, in plain English.

## Overview

### Houses

The following endpoints are available for managing Hogwarts houses:

- `GET /houses` - Retrieve a list of all houses.
  Explaination for order in the server.js:

1. We first check if there exists anything in a table called "houses" in our database. if not houses are found, give `404` status code indicating "not found" and an error message.
2. If it exists, return the list of houses with a `200` status code indicating "OK".
3. If there is a database error while trying to retrieve the houses, return a `500` status code indicating "Internal Server Error" along with an error message.

- `GET /houses/:id` - Retrieve details of a specific house by its ID.

1. We first check if a house with the specified ID exists in the "houses" table of our database. if not found, give `404` status code indicating "not found" and an error message.
2. If it exists, return the house details with a `200` status code indicating "OK".
3. If there is a database error while trying to retrieve the house, return a `500` status code indicating "Internal Server Error" along with an error message.

### Staff

- `GET /staff` - Retrieve a list of all staff members.
  Explaination for order in the server.js:

1. We first check if there exists anything in a table called "staff" in our database. if not staff members are found, give `404` status code indicating "not found" and an error message.
2. If it exists, return the list of staff members with a `200` status code indicating "OK".
3. If there is a database error while trying to retrieve the staff members, return a `500` status code indicating "Internal Server Error" along with an error message.

- `GET /staff/:id` - Retrieve details of a specific staff member by their ID.
  Explaination for order in the server.js:

1. We first check if a staff member with the specified ID exists in the "staff" table of our database. if not found, give `404` status code indicating "not found" and an error message.
2. If it exists, return the staff member details with a `200` status code indicating "OK".
3. If there is a database error while trying to retrieve the staff member, return a `500` status code indicating "Internal Server Error" along with an error message.

- `POST /staff` - Create a new staff member.
  Explaination for order in the server.js:

1. We first check if a staff member with the same first name, last name, and role already exists in the "staff" table of our database. if found, give `400` status code indicating "Bad Request" and an error message.
2. If it does not exist, insert the new staff member into the database and return the newly created staff member with a `200` status code indicating "OK".
3. If there is a database error while trying to create the staff member, return a `500` status code indicating "Internal Server Error" along with an error message.

- `PUT /staff/:id` - Update an existing staff member by their ID.
  Explaination for order in the server.js:

1. We first check if a staff member with the specified ID exists in the "staff" table of our database. if not found, give `404` status code indicating "not found" and an error message.
2. If it exists, update the staff member details in the database and return the updated staff member with a `200` status code indicating "OK".
3. If there is a database error while trying to update the staff member, return a `500` status code indicating "Internal Server Error" along with an error message.

- `DELETE /staff/:id` - Delete a staff member by their ID.
  Explaination for order in the server.js:

1. We first check if a staff member with the specified ID exists in the "staff" table of our database. if not found, give `404` status code indicating "not found" and an error message.
2. If it exists, delete the staff member from the database and return the deleted staff member with a `200` status code indicating "OK".
3. If there is a database error while trying to delete the staff member, return a `500` status code indicating "Internal Server Error" along with an error message.

### Classes

- `GET /classes` - Retrieve a list of all classes.
  Explaination for order in the server.js:

1. We first check if there exists anything in a table called "classes" in our database. if not classes are found, give `404` status code indicating "not found" and an error message.
2. If it exists, return the list of classes with a `200` status code indicating "OK".
3. If there is a database error while trying to retrieve the classes, return a `500` status code indicating "Internal Server Error" along with an error message.

- `GET /classes/:id` - Retrieve details of a specific class by its ID.
  Explaination for order in the server.js:

1. We first check if a class with the specified ID exists in the "classes" table of our database. if not found, give `404` status code indicating "not found" and an error message.
2. If it exists, return the class details with a `200` status code indicating "OK".
3. If there is a database error while trying to retrieve the class, return a `500` status code indicating "Internal Server Error" along with an error message.

- `POST /classes` - Create a new class.
  Explaination for order in the server.js:

1. We first check if a class with the same name already exists in the "classes" table of our database. if found, give `400` status code indicating "Bad Request" and an error message.
2. If it does not exist, insert the new class into the database and return the newly created class with a `200` status code indicating "OK".
3. If there is a database error while trying to create the class, return a `500` status code indicating "Internal Server Error" along with an error message.

- `PUT /classes/:id` - Update an existing class by its ID.
  Explaination for order in the server.js:

1. We first check if a class with the specified ID exists in the "classes" table of our database. if not found, give `404` status code indicating "not found" and an error message.
2. If it exists, update the class details in the database and return the updated class with a `200` status code indicating "OK".
3. If there is a database error while trying to update the class, return a `500` status code indicating "Internal Server Error" along with an error message.

- `DELETE /classes/:id` - Delete a class by its ID.
  Explaination for order in the server.js:

1. We first check if a class with the specified ID exists in the "classes" table of our database. if not found, give `404` status code indicating "not found" and an error message.
2. If it exists, delete the class from the database and return the deleted class with a `200` status code indicating "OK".
3. If there is a database error while trying to delete the class, return a `500` status code indicating "Internal Server Error" along with an error message.

### Students

- `GET /students` - Retrieve a list of all students.
  Explaination for order in the server.js:

1. We first check if there exists anything in a table called "students" in our database. if not students are found, give `404` status code indicating "not found" and an error message.
2. If it exists, return the list of students with a `200` status code indicating "OK".
3. If there is a database error while trying to retrieve the students, return a `500` status code indicating "Internal Server Error" along with an error message.

- `GET /students/:id` - Retrieve details of a specific student by their ID.
  Explaination for order in the server.js:

1. We first check if a student with the specified ID exists in the "students" table of our database. if not found, give `404` status code indicating "not found" and an error message.
2. If it exists, return the student details with a `200` status code indicating "OK".
3. If there is a database error while trying to retrieve the student, return a `500` status code indicating "Internal Server Error" along with an error message.

- `POST /students` - Create a new student.
  Explaination for order in the server.js:

1. We first check if a student with the same name already exists in the "students" table of our database. if found, give `400` status code indicating "Bad Request" and an error message.
2. If it does not exist, insert the new student into the database and return the newly created student with a `200` status code indicating "OK".
3. If there is a database error while trying to create the student, return a `500` status code indicating "Internal Server Error" along with an error message.

- `PUT /students/:id` - Update an existing student by their ID.
  Explaination for order in the server.js:

1. We first check if a student with the specified ID exists in the "students" table of our database. if not found, give `404` status code indicating "not found" and an error message.
2. If it exists, update the student details in the database and return the updated student with a `200` status code indicating "OK".
3. If there is a database error while trying to update the student, return a `500` status code indicating "Internal Server Error" along with an error message.

- `DELETE /students/:id` - Delete a student by their ID.
  Explaination for order in the server.js:

1. We first check if a student with the specified ID exists in the "students" table of our database. if not found, give `404` status code indicating "not found" and an error message.
2. If it exists, delete the student from the database and return the deleted student with a `200` status code indicating "OK".
3. If there is a database error while trying to delete the student, return a `500` status code indicating "Internal Server Error" along with an error message.

### Student-Classes Combinations

- `GET /student_classes` - See all student-classes combinations.
  Explaination for order in the server.js:

1. Retrieve all student-classes combinations from the "student_classes" table of our database.
2. If successful, return the combinations with a `200` status code indicating "OK".
3. If there is a database error while trying to retrieve the combinations, return a `500` status code indicating "Internal Server Error" along with an error message.

- `POST /student_classes` - Add a new student-class combination.
  Explaination for order in the server.js:

1. Check if the student-class combination already exists in the "student_classes" table of our database. If it does, return a `409` status code indicating "Conflict" along with an error message.
2. If it does not exist, insert the new combination into the database and return the created combination with a `201` status code indicating "Created".
3. If there is a database error while trying to add the combination, return a `500` status code indicating "Internal Server Error" along with an error message.

- `DELETE /student_classes/:student_id/:class_id/:year` - Remove a student-class combination.
  Explaination for order in the server.js:

1. We first check if a student-class combination with the specified student ID, class ID, and year exists in the "student_classes" table of our database. if not found, give `404` status code indicating "not found" and an error message.
2. If it exists, delete the combination from the database and return the deleted combination with a `200` status code indicating "OK".
3. If there is a database error while trying to delete the combination, return a `500` status code indicating "Internal Server Error" along with an error message.

### teacher-classes Combinations

- `GET /teacher_classes` - See all teacher-classes combinations.
  Explaination for order in the server.js:

1. Retrieve all teacher-classes combinations from the "teacher_classes" table of our database.
2. If successful, return the combinations with a `200` status code indicating "OK".
3. If there is a database error while trying to retrieve the combinations, return a `500` status code indicating "Internal Server Error" along with an error message.

- `POST /teacher_classes` - Add a new teacher-class combination.
  Explaination for order in the server.js:

1. Check if the teacher-class combination already exists in the "teacher_classes" table of our database. If it does, return a `409` status code indicating "Conflict" along with an error message.
2. If it does not exist, insert the new combination into the database and return the created combination with a `201` status code indicating "Created".
3. If there is a database error while trying to add the combination, return a `500` status code indicating "Internal Server Error" along with an error message.

- `DELETE /teacher_classes/:teacher_id/:class_id/:year` - Remove a teacher-class combination.
  Explaination for order in the server.js:

1. We first check if a teacher-class combination with the specified teacher ID, class ID, and year exists in the "teacher_classes" table of our database. if not found, give `404` status code indicating "not found" and an error message.
2. If it exists, delete the combination from the database and return the deleted combination with a `200` status code indicating "OK".
3. If there is a database error while trying to delete the combination, return a `500` status code indicating "Internal Server Error" along with an error message.
