import * as teacherClassesRepo from "../repos/teacher_classes.repo.js";

//* Controller functions for handling teacher-class assignments

export const getAllTeacherClasses = async (req, res) => {
  try {
    const assignments = await teacherClassesRepo.getAllTeacherClasses();

    if (assignments.length === 0) {
      return res
        .status(404)
        .json({ error: "No teacher-class assignments found" });
    }
    res.status(200).json(assignments);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Database error" });
  }
};

export const createTeacherClass = async (req, res) => {
  try {
    const { teacher_id, class_id } = req.body;
    const existing = await teacherClassesRepo.findTeacherClass(
      teacher_id,
      class_id,
    );

    if (existing) {
      return res
        .status(409)
        .json({ error: "Teacher-class combination already exists" });
    }

    const created = await teacherClassesRepo.createTeacherClass(
      teacher_id,
      class_id,
    );
    res.status(201).json(created);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Database error" });
  }
};

export const deleteTeacherClass = async (req, res) => {
  try {
    const { teacher_id, class_id } = req.params;
    const deleted = await teacherClassesRepo.deleteTeacherClass(
      teacher_id,
      class_id,
    );

    if (!deleted) {
      return res
        .status(404)
        .json({ error: "Teacher-class assignment not found" });
    }
    res.status(200).json(deleted);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Database error" });
  }
};
