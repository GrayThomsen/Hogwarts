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
    res.json(result.rows);
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
    const result = await pool.query(
      "INSERT INTO students (first_name, last_name, house) VALUES ($1, $2, $3) RETURNING *",
      [first_name, last_name, house],
    );

    res.json(result.rows[0]);
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
    const result = await pool.query(
      "DELETE FROM students WHERE id = $1 RETURNING *",
      [id],
    );
    res.json(result.rows[0]);
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
    const result = await pool.query(
      "UPDATE students SET first_name = $1, last_name = $2, house = $3 WHERE id = $4 RETURNING *",
      [first_name, last_name, house, id],
    );
    res.json(result.rows[0]);
  } catch (error) {
    console.error(error);
    res.status(500).json({
      error: "Database error",
    });
  }
});

//---------------------------------------------------------------------------------------------------------------
//*  House Data
//---------------------------------------------------------------------------------------------------------------

// GET all Hogwarts houses
app.get("/houses", async (req, res) => {
  try {
    const result = await pool.query("SELECT * FROM houses");

    res.json(result.rows);
  } catch (error) {
    console.error(error);
    res.status(500).json({
      error: "Database error",
    });
  }
});

app.get("/houses/:id", async (req, res) => {
  try {
    const { id } = req.params;
    const result = await pool.query(
      "SELECT FROM houses WHERE id = $1 RETURNING *",
      [id],
    );
    res.json(result.rows[0]);
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

app.get("/staff", async (req, res) => {
  try {
    const result = await pool.query(`SELECT * FROM staff`);
    res.json(result.rows);
  } catch (error) {
    console.error(error);
    res.status(500).json({
      error: "Database error",
    });
  }
});

app.post("/staff", async (req, res) => {
  const { first_name, last_name, role } = req.body;
  try {
    const result = await pool.query(
      "INSERT INTO staff (first_name, last_name, role) VALUES ($1, $2, $3) RETURNING *",
      [first_name, last_name, role],
    );
    res.json(result.rows[0]);
  } catch (error) {
    console.error(error);
    res.status(500).json({
      error: "Database error",
    });
  }
});

app.delete("/staff/:id", async (req, res) => {
  const { id } = req.params;
  try {
    const result = await pool.query(
      "DELETE FROM staff WHERE id = $1 RETURNING *",
      [id],
    );
    res.json(result.rows[0]);
  } catch (error) {
    console.error(error);
    res.status(500).json({
      error: "Database error",
    });
  }
});

app.put("/staff/:id", async (req, res) => {
  const { id } = req.params;
  const { first_name, last_name, role } = req.body;
  try {
    const result = await pool.query(
      "UPDATE staff SET first_name = $1, last_name = $2, role = $3 WHERE id = $4 RETURNING *",
      [first_name, last_name, role, id],
    );
    res.json(result.rows[0]);
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

app.get("/classes", async (req, res) => {
  try {
    const result = await pool.query(`SELECT * FROM classes`);
    res.json(result.rows);
  } catch (error) {
    console.error(error);
    res.status(500).json({
      error: "Database error",
    });
  }
});

app.post("/classes", async (req, res) => {
  const { name } = req.body;
  try {
    const result = await pool.query(
      "INSERT INTO classes (name) VALUES ($1) RETURNING *",
      [name],
    );
    res.json(result.rows[0]);
  } catch (error) {
    console.error(error);
    res.status(500).json({
      error: "Database error",
    });
  }
});

app.delete("/classes/:id", async (req, res) => {
  const { id } = req.params;
  try {
    const result = await pool.query(
      "DELETE FROM classes WHERE id = $1 RETURNING *",
      [id],
    );
    res.json(result.rows[0]);
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

app.get("/teacher_classes", async (req, res) => {
  try {
    const result = await pool.query(`SELECT * FROM teacher_classes`);
    res.json(result.rows);
  } catch (error) {
    console.error(error);
    res.status(500).json({
      error: "Database error",
    });
  }
});

app.post("/teacher_classes", async (req, res) => {
  const { teacher_id, class_id } = req.body;

  try {
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

    res.json(result.rows[0]);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Database error" });
  }
});

//---------------------------------------------------------------------------------------------------------------
//*  Student Class Data
//-----------------------------------------------------------------------------------------------------------------

app.get("/student_classes", async (req, res) => {
  try {
    const result = await pool.query(`SELECT * FROM student_classes`);
    res.json(result.rows);
  } catch (error) {
    console.error(error);
    res.status(500).json({
      error: "Database error",
    });
  }
});

app.post("/student_classes", async (req, res) => {
  try {
    const { student_id, class_id, year } = req.body;
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
