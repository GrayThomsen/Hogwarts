const express = require("express");
const pool = require("./db");

const app = express();

app.use(express.json());

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

(app.delete("/students/:id"),
  async (req, res) => {
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

app.patch("students/:id", async (req, res) => {
  const { id } = req.params;
  const { first_name, last_name, house } = req.body;
  try {
    const reult = await pool.query(
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

app.listen(3000, () => {
  console.log("Server running on port 3000");
});
