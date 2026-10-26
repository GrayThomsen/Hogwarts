const express = require("express");
const pool = require("./db");

const app = express();

app.use(express.json());

app.listen(3000, () => {
  console.log("Server running on port 3000");
});

//---------------------------------------------------------------------------------------------------------------
//*  Student Data
//---------------------------------------------------------------------------------------------------------------

// GET all Hogwarts students.
app.get("/students", async (req, res) => {
  try {
    // A little more excessive, since we want to see the name of the house.
    const result = await pool.query(`
            SELECT
                students.id,
                students.first_name,
                students.last_name,
                houses.name AS house
            FROM students
            LEFT JOIN houses
                ON students.house = houses.id
            ORDER BY students.id
        `);
    if (result.rows.length === 0) {
      return res.status(404).json({
        error: "No students found",
      });
    }
    res.json(result.rows);
  } catch (error) {
    console.error(error);
    res.status(500).json({
      error: "Database error",
    });
  }
});

app.get("/students/:id", async (req, res) => {
  const { id } = req.params;
  try {
    const result = await pool.query(
      //? Is there a shorter way to do this query using a view or a simpler join?
      "SELECT students.id, students.first_name, students.last_name, houses.name AS house FROM students LEFT JOIN houses ON students.house = houses.id WHERE students.id = $1",
      [id],
    );
    if (result.rows.length === 0) {
      return res.status(404).json({
        error: "Student not found",
      });
    }
    res.json(result.rows[0]);
  } catch (error) {
    console.error(error);
    res.status(500).json({
      error: "Database error",
    });
  }
});

// POST and thereby create a new Hogwarts student.

app.post("/students", async (req, res) => {
  const { first_name, last_name, house } = req.body;

  try {
    // controlRead checks if a student with that same first name, last name, and house already exists in the database.
    //? This is not actually against the rules, but I am checking to train my code writing. What would work better, to ensure a specific student is not "re-created"?
    const controlRead = await pool.query(
      "SELECT * FROM students WHERE first_name = $1 AND last_name = $2 AND house = $3",
      [first_name, last_name, house],
    );
    //* If student exists, return an error response to say "hey, this student already exists." HTTP status 400 is used since it means "bad request".
    if (controlRead.rows.length > 0) {
      return res.status(400).json({
        error: "Student already exists",
      });
    }
    //? Should all constants be kept together at the top or at their first usage?
    const createdStudent = await pool.query(
      //* To me, returning * makes sense, as it just returns the newly created student record. Instead of having to make an additional "GET" request to fetch it.
      "INSERT INTO students (first_name, last_name, house) VALUES ($1, $2, $3) RETURNING *",
      [first_name, last_name, house],
    );
    // At least, res(ponse) is called once to send the response to the client. It is made into JSON format and we say "create.rows[0]" to return the newly created student. With this approach, the client immediately gets the newly created student data without needing an additional GET request.
    res.status(201).json(createdStudent.rows[0]);
  } catch (error) {
    console.error(error);
    res.status(500).json({
      error: "Database error",
    });
  }
});

app.delete("/students/:id", async (req, res) => {
  const { id } = req.params;
  try {
    const controlRead = await pool.query(
      "SELECT * FROM students WHERE id = $1",
      [id],
    );
    if (controlRead.rows.length === 0) {
      return res.status(404).json({
        error: "Student not found",
      });
    }

    const result = await pool.query(
      "DELETE FROM students WHERE id = $1 RETURNING *",
      [id],
    );
    //Added status (200) to say "OK", even tho it is the default for when things go acording to plan.
    res.status(200).json(result.rows[0]);
  } catch (error) {
    console.error(error);
    res.status(500).json({
      error: "Database error",
    });
  }
});

app.put("/students/:id", async (req, res) => {
  const { id } = req.params;
  const { first_name, last_name, house } = req.body;
  try {
    const controlRead = await pool.query(
      "SELECT * FROM students WHERE id = $1",
      [id],
    );
    if (controlRead.rows.length === 0) {
      return res.status(404).json({
        error: "Student not found",
      });
    }

    const result = await pool.query(
      "UPDATE students SET first_name = $1, last_name = $2, house = $3 WHERE id = $4 RETURNING *",
      [first_name, last_name, house, id],
    );
    res.status(200).json(result.rows[0]);
  } catch (error) {
    console.error(error);
    res.status(500).json({
      error: "Database error",
    });
  }
});

//---------------------------------------------------------------------------------------------------------------
//*  Houses Data
//---------------------------------------------------------------------------------------------------------------

// GET all Hogwarts houses
app.get("/houses", async (req, res) => {
  try {
    const result = await pool.query("SELECT * FROM houses");

    if (result.rows.length === 0) {
      return res.status(404).json({
        error: "Houses not found",
      });
    }

    res.status(200).json(result.rows);
  } catch (error) {
    console.error(error);
    res.status(500).json({
      error: "Database error",
    });
  }
});
// Get a specific house.
app.get("/houses/:id", async (req, res) => {
  try {
    const { id } = req.params;
    const result = await pool.query("SELECT * FROM houses WHERE id = $1", [id]);

    if (result.rows.length === 0) {
      return res.status(404).json({
        error: "House not found",
      });
    }

    res.status(200).json(result.rows[0]);
  } catch (error) {
    console.error(error);
    res.status(500).json({
      error: "Database error",
    });
  }
});

//---------------------------------------------------------------------------------------------------------------
//*  Staff Data
//---------------------------------------------------------------------------------------------------------------

//Show list of all staff members
app.get("/staff", async (req, res) => {
  try {
    const controlRead = await pool.query("SELECT * FROM staff");
    if (controlRead.rows.length === 0) {
      return res.status(404).json({
        error: "Staff not found",
      });
    }
    const result = await pool.query(`SELECT * FROM staff`);
    res.status(200).json(result.rows);
  } catch (error) {
    console.error(error);
    res.status(500).json({
      error: "Database error",
    });
  }
});

app.get("/staff/:id", async (req, res) => {
  try {
    const { id } = req.params;
    const result = await pool.query("SELECT * FROM staff WHERE id = $1", [id]);

    if (result.rows.length === 0) {
      return res.status(404).json({
        error: "Staff member not found",
      });
    }

    res.status(200).json(result.rows[0]);
  } catch (error) {
    console.error(error);
    res.status(500).json({
      error: "Database error",
    });
  }
});

//This is posting (creating) a new staff member
app.post("/staff", async (req, res) => {
  const { first_name, last_name, role } = req.body;
  try {
    //Like with students, not really necessary, but it prevents duplicate staff entries, which could cause confusion in the database.
    const controlRead = await pool.query(
      "SELECT * FROM staff WHERE first_name = $1 AND last_name = $2 AND role = $3",
      [first_name, last_name, role],
    );
    if (controlRead.rows.length > 0) {
      return res.status(400).json({
        error: "Staff member already exists",
      });
    }

    const result = await pool.query(
      "INSERT INTO staff (first_name, last_name, role) VALUES ($1, $2, $3) RETURNING *",
      [first_name, last_name, role],
    );
    res.status(201).json(result.rows[0]);
  } catch (error) {
    console.error(error);
    res.status(500).json({
      error: "Database error",
    });
  }
});
//Delete a staff member by their ID
app.delete("/staff/:id", async (req, res) => {
  const { id } = req.params;
  try {
    const controlRead = await pool.query("SELECT * FROM staff WHERE id = $1", [
      id,
    ]);
    if (controlRead.rows.length === 0) {
      return res.status(404).json({
        error: "Staff member not found",
      });
    }

    const result = await pool.query(
      "DELETE FROM staff WHERE id = $1 RETURNING *",
      [id],
    );
    res.status(200).json(result.rows[0]);
  } catch (error) {
    console.error(error);
    res.status(500).json({
      error: "Database error",
    });
  }
});
//Update an existing staff member by their ID
app.put("/staff/:id", async (req, res) => {
  const { id } = req.params;
  const { first_name, last_name, role } = req.body;
  try {
    const controlRead = await pool.query("SELECT * FROM staff WHERE id = $1", [
      id,
    ]);
    if (controlRead.rows.length === 0) {
      return res.status(404).json({
        error: "Staff member not found",
      });
    }

    const result = await pool.query(
      "UPDATE staff SET first_name = $1, last_name = $2, role = $3 WHERE id = $4 RETURNING *",
      [first_name, last_name, role, id],
    );
    res.status(200).json(result.rows[0]);
  } catch (error) {
    console.error(error);
    res.status(500).json({
      error: "Database error",
    });
  }
});

//---------------------------------------------------------------------------------------------------------------
//*  Class Data
//---------------------------------------------------------------------------------------------------------------
//Get a list of all classes
app.get("/classes", async (req, res) => {
  try {
    const result = await pool.query(`SELECT * FROM classes`);
    if (result.rows.length === 0) {
      return res.status(404).json({
        error: "No classes found",
      });
    }
    res.status(200).json(result.rows);
  } catch (error) {
    console.error(error);
    res.status(500).json({
      error: "Database error",
    });
  }
});

app.get("/classes/:id", async (req, res) => {
  const { id } = req.params;
  try {
    const result = await pool.query("SELECT * FROM classes WHERE id = $1", [
      id,
    ]);
    if (result.rows.length === 0) {
      return res.status(404).json({
        error: "Class not found",
      });
    }
    res.status(200).json(result.rows[0]);
  } catch (error) {
    console.error(error);
    res.status(500).json({
      error: "Database error",
    });
  }
});

//Create a new class
app.post("/classes", async (req, res) => {
  const { name } = req.body;
  try {
    const controlRead = await pool.query(
      "SELECT * FROM classes WHERE name = $1",
      [name],
    );
    if (controlRead.rows.length > 0) {
      return res.status(409).json({
        error: "Class with the same name already exists",
      });
    }

    const result = await pool.query(
      "INSERT INTO classes (name) VALUES ($1) RETURNING *",
      [name],
    );
    res.status(201).json(result.rows[0]);
  } catch (error) {
    console.error(error);
    res.status(500).json({
      error: "Database error",
    });
  }
});

app.put("/classes/:id", async (req, res) => {
  const { id } = req.params;
  const { name } = req.body;
  try {
    const controlRead = await pool.query(
      "SELECT * FROM classes WHERE id = $1",
      [id],
    );
    if (controlRead.rows.length === 0) {
      return res.status(404).json({
        error: "Class not found",
      });
    }

    const result = await pool.query(
      "UPDATE classes SET name = $1 WHERE id = $2 RETURNING *",
      [name, id],
    );
    res.status(200).json(result.rows[0]);
  } catch (error) {
    console.error(error);
    res.status(500).json({
      error: "Database error",
    });
  }
});

//Delete a class by its ID
app.delete("/classes/:id", async (req, res) => {
  const { id } = req.params;
  try {
    const controlRead = await pool.query(
      "SELECT * FROM classes WHERE id = $1",
      [id],
    );
    if (controlRead.rows.length === 0) {
      return res.status(404).json({
        error: "Class not found",
      });
    }
    const result = await pool.query(
      "DELETE FROM classes WHERE id = $1 RETURNING *",
      [id],
    );
    res.status(200).json(result.rows[0]);
  } catch (error) {
    console.error(error);
    res.status(500).json({
      error: "Database error",
    });
  }
});

//-----------------------------------------------------------------------------------------------------------------
//*  Teacher Class Data
//-----------------------------------------------------------------------------------------------------------------

//Get a list of all teacher-class assignments
app.get("/teacher_classes", async (req, res) => {
  try {
    const result = await pool.query(`SELECT * FROM teacher_classes`);
    if (result.rows.length === 0) {
      return res.status(404).json({
        error: "No teacher-class assignments found",
      });
    }
    res.status(200).json(result.rows);
  } catch (error) {
    console.error(error);
    res.status(500).json({
      error: "Database error",
    });
  }
});

//Create a new teacher-class assignment
app.post("/teacher_classes", async (req, res) => {
  const { teacher_id, class_id } = req.body;

  try {
    const controlRead = await pool.query(
      "SELECT * FROM teacher_classes WHERE teacher_id = $1 AND class_id = $2",
      [teacher_id, class_id],
    );

    if (controlRead.rows.length > 0) {
      return res.status(409).json({
        error: "Teacher-class combination already exists",
      });
    }

    const result = await pool.query(
      "INSERT INTO teacher_classes (teacher_id, class_id) VALUES ($1, $2) RETURNING *",
      [teacher_id, class_id],
    );
    res.status(201).json(result.rows[0]);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Database error" });
  }
});

//Delete a teacher-class assignment by teacher ID and class ID
app.delete("/teacher_classes/:teacher_id/:class_id", async (req, res) => {
  const { teacher_id, class_id } = req.params;

  try {
    const result = await pool.query(
      "DELETE FROM teacher_classes WHERE teacher_id = $1 AND class_id = $2 RETURNING *",
      [teacher_id, class_id],
    );

    if (result.rowCount === 0) {
      return res
        .status(404)
        .json({ error: "Teacher-class assignment not found" });
    }

    res.status(200).json(result.rows[0]);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Database error" });
  }
});

//---------------------------------------------------------------------------------------------------------------
//*  Student Class Data
//-----------------------------------------------------------------------------------------------------------------

//Get a list of all student-class assignments
app.get("/student_classes", async (req, res) => {
  try {
    const controlRead = await pool.query("SELECT * FROM student_classes");
    if (controlRead.rows.length === 0) {
      return res.status(404).json({
        error: "Student not found",
      });
    }
    const result = await pool.query(`SELECT * FROM student_classes`);
    res.status(200).json(result.rows);
  } catch (error) {
    console.error(error);
    res.status(500).json({
      error: "Database error",
    });
  }
});

//Create a new student-class assignment
app.post("/student_classes", async (req, res) => {
  try {
    const { student_id, class_id, year } = req.body;
    const controlRead = await pool.query(
      "SELECT * FROM student_classes WHERE student_id = $1 AND class_id = $2 AND year = $3",
      [student_id, class_id, year],
    );
    if (controlRead.rows.length > 0) {
      return res.status(409).json({
        error: "Student-class combination already exists",
      });
    }
    if (year < 1 || year > 7) {
      return res.status(400).json({
        error: "Year must be between 1 and 7",
      });
    }
    const result = await pool.query(
      "INSERT INTO student_classes (student_id, class_id, year) VALUES ($1, $2, $3) RETURNING *",
      [student_id, class_id, year],
    );
    res.status(201).json(result.rows[0]);
  } catch (error) {
    console.error(error);
    res.status(500).json({
      error: "Database error",
    });
  }
});

//Delete a student-class assignment by student ID, class ID, and year
app.delete("/student_classes/:student_id/:class_id/:year", async (req, res) => {
  const { student_id, class_id, year } = req.params;

  try {
    const controlRead = await pool.query(
      "SELECT * FROM student_classes WHERE student_id = $1 AND class_id = $2 AND year = $3",
      [student_id, class_id, year],
    );
    if (controlRead.rows.length === 0) {
      return res.status(404).json({
        error: "Student-class assignment not found",
      });
    }
    const result = await pool.query(
      "DELETE FROM student_classes WHERE student_id = $1 AND class_id = $2 AND year = $3 RETURNING *",
      [student_id, class_id, year],
    );

    if (result.rowCount === 0) {
      return res
        .status(404)
        .json({ error: "Student-class assignment not found" });
    }

    res.status(200).json(result.rows[0]);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Database error" });
  }
});
