import * as studentSubjectsRepo from "../repositories/student_subjects.repository.js";
import httpError from "../errorhandling/httpError.js";
import validateBody from "../errorhandling/validateBody.js";
import createStudentSubjectSchema from "../dtos/createStudentSubject.dto.js";

export const getAllStudentSubjects = async (req, res) => {
  const assignments = await studentSubjectsRepo.getAllStudentSubjects();

  if (assignments.length === 0) {
    throw new httpError(404, "No student-subject assignments found");
  }
  res.status(200).json(assignments);
};

export const createStudentSubject = async (req, res) => {
  const assignment = validateBody(createStudentSubjectSchema, req.body);
  const allAssignments = await studentSubjectsRepo.getAllStudentSubjects();
  const existing = allAssignments.find(
    (existing) =>
      existing.fk_student_id === assignment.fk_student_id &&
      existing.fk_subject_id === assignment.fk_subject_id &&
      existing.year === assignment.year,
  );

  if (existing) {
    throw new httpError(409, "Student-subject combination already exists");
  }
  const created = await studentSubjectsRepo.createStudentSubject(assignment);
  res.status(201).json(created);
};

export const deleteStudentSubject = async (req, res) => {
  const assignment = req.params;
  const deleted = await studentSubjectsRepo.deleteStudentSubject(assignment);

  if (!deleted) {
    throw new httpError(404, "Student-subject assignment not found");
  }
  res.status(200).json(deleted);
};
