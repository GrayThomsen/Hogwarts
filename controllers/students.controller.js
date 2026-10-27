import * as studentsRepo from "../repos/students.repo.js";

//* Controller functions for handling Hogwarts students data

export const getAllStudents = async (req, res) => {
  try {
    const students = await studentsRepo.getAllStudents();

    if (students.length === 0) {
      return res.status(404).json({ error: "No students found" });
    }
    res.json(students);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Database error" });
  }
};

export const getStudentById = async (req, res) => {
  try {
    const { id } = req.params;
    const student = await studentsRepo.getStudentById(id);

    if (!student) {
      return res.status(404).json({ error: "Student not found" });
    }
    res.json(student);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Database error" });
  }
};

export const createStudent = async (req, res) => {
  try {
    const { first_name, last_name, house } = req.body;
    //? Not against the rules, but prevents accidental re-creation of the same student.
    const existing = await studentsRepo.findStudent(
      first_name,
      last_name,
      house,
    );

    if (existing) {
      return res.status(400).json({ error: "Student already exists" });
    }

    const created = await studentsRepo.createStudent(
      first_name,
      last_name,
      house,
    );
    res.status(201).json(created);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Database error" });
  }
};

export const updateStudent = async (req, res) => {
  try {
    const { id } = req.params;
    const { first_name, last_name, house } = req.body;
    const existing = await studentsRepo.getStudentById(id);

    if (!existing) {
      return res.status(404).json({ error: "Student not found" });
    }

    const updated = await studentsRepo.updateStudent(
      id,
      first_name,
      last_name,
      house,
    );
    res.status(200).json(updated);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Database error" });
  }
};

export const deleteStudent = async (req, res) => {
  try {
    const { id } = req.params;
    const existing = await studentsRepo.getStudentById(id);

    if (!existing) {
      return res.status(404).json({ error: "Student not found" });
    }

    const deleted = await studentsRepo.deleteStudent(id);
    res.status(200).json(deleted);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Database error" });
  }
};
