import * as teacherClassesRepo from "../repositories/teacher_classes.repository.js";
import httpError from "../errorhandling/httpError.js";

//* Controller functions for handling teacher-class assignments

export const getAllTeacherClasses = async (req, res) => {
  const assignments = await teacherClassesRepo.getAllTeacherClasses();

  if (assignments.length === 0) {
    throw new httpError(404, "No teacher-class assignments found");
  }
  res.status(200).json(assignments);
};

export const createTeacherClass = async (req, res) => {
  const assignment = req.body;
  const existing = await teacherClassesRepo.findTeacherClass(assignment);

  if (existing) {
    throw new httpError(409, "Teacher-class combination already exists");
  }

  const created = await teacherClassesRepo.createTeacherClass(assignment);
  res.status(201).json(created);
};

export const deleteTeacherClass = async (req, res) => {
  const assignment = req.params;
  const deleted = await teacherClassesRepo.deleteTeacherClass(assignment);

  if (!deleted) {
    throw new httpError(404, "Teacher-class assignment not found");
  }
  res.status(200).json(deleted);
};
