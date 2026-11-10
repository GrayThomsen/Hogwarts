import * as studentClassesRepo from "../repos/student_classes.repo.js";
import httpError from "../errorhandling/httpError.js";

//* Controller functions for handling student-class assignments

export const getAllStudentClasses = async (req, res) => {
  const assignments = await studentClassesRepo.getAllStudentClasses();

  if (assignments.length === 0) {
    throw new httpError(404, "No student-class assignments found");
  }
  res.status(200).json(assignments);
};

export const createStudentClass = async (req, res) => {
  const { student_id, class_id, year } = req.body;
  const allAssignments = await studentClassesRepo.getAllStudentClasses();
  const existing = allAssignments.find(
    (assignment) =>
      assignment.student_id === student_id &&
      assignment.class_id === class_id &&
      assignment.year === year,
  );

  if (existing) {
    throw new httpError(409, "Student-class combination already exists");
  }
  if (year < 1 || year > 7) {
    throw new httpError(400, "Year must be between 1 and 7");
  }

  const created = await studentClassesRepo.createStudentClass(
    student_id,
    class_id,
    year,
  );
  res.status(201).json(created);
};

export const deleteStudentClass = async (req, res) => {
  const { student_id, class_id, year } = req.params;
  const deleted = await studentClassesRepo.deleteStudentClass(
    student_id,
    class_id,
    year,
  );

  if (!deleted) {
    throw new httpError(404, "Student-class assignment not found");
  }
  res.status(200).json(deleted);
};
