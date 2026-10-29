import * as studentClassesRepo from "../repos/student_classes.repo.js";

//* Controller functions for handling student-class assignments

export const getAllStudentClasses = async (req, res) => {
  try {
    const assignments = await studentClassesRepo.getAllStudentClasses();

    if (assignments.length === 0) {
      return res.status(404).json({ error: "Student not found" });
    }
    res.status(200).json(assignments);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Database error" });
  }
};

export const findStudentClassByIdsAndYear = async (req, res) => {
  try {
    const { student_id, class_id, year } = req.params;
    const assignment = await studentClassesRepo.findStudentClassByIdsAndYear(
      student_id,
      class_id,
      year,
    );

    if (!assignment) {
      return res
        .status(404)
        .json({ error: "Student-class assignment not found" });
    }
    res.status(200).json(assignment);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Database error" });
  }
};

export const createStudentClass = async (req, res) => {
  try {
    const { student_id, class_id, year } = req.body;
    const existing = await studentClassesRepo.findStudentClassByIdsAndYear(
      student_id,
      class_id,
      year,
    );

    if (existing) {
      return res
        .status(409)
        .json({ error: "Student-class combination already exists" });
    }
    if (year < 1 || year > 7) {
      return res.status(400).json({ error: "Year must be between 1 and 7" });
    }

    const created = await studentClassesRepo.createStudentClass(
      student_id,
      class_id,
      year,
    );
    res.status(201).json(created);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Database error" });
  }
};

export const deleteStudentClass = async (req, res) => {
  try {
    const { student_id, class_id, year } = req.params;
    const deleted = await studentClassesRepo.deleteStudentClass(
      student_id,
      class_id,
      year,
    );

    if (!deleted) {
      return res
        .status(404)
        .json({ error: "Student-class assignment not found" });
    }
    res.status(200).json(deleted);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Database error" });
  }
};
