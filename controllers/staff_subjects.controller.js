import * as staffSubjectsRepo from "../repositories/staff_subjects.repository.js";
import httpError from "../errorhandling/httpError.js";
import validateBody from "../errorhandling/validateBody.js";
import createStaffSubjectSchema from "../dtos/createStaffSubject.dto.js";

export const getAllStaffSubjects = async (req, res) => {
  const assignments = await staffSubjectsRepo.getAllStaffSubjects();

  if (assignments.length === 0) {
    throw new httpError(404, "No staff-subject assignments found");
  }
  res.status(200).json(assignments);
};

export const createStaffSubject = async (req, res) => {
  const assignment = validateBody(createStaffSubjectSchema, req.body);
  const existing = await staffSubjectsRepo.findStaffSubject(assignment);

  if (existing) {
    throw new httpError(409, "Staff-subject combination already exists");
  }

  const created = await staffSubjectsRepo.createStaffSubject(assignment);
  res.status(201).json(created);
};

export const deleteStaffSubject = async (req, res) => {
  const assignment = req.params;
  const deleted = await staffSubjectsRepo.deleteStaffSubject(assignment);

  if (!deleted) {
    throw new httpError(404, "Staff-subject assignment not found");
  }
  res.status(200).json(deleted);
};
