import * as staffRepo from "../repos/staff.repo.js";
import httpError from "../errorhandling/httpError.js";
import createTeacherSchema from "../dtos/createTeacher.dto.js";
import UpdateTeacherSchema from "../dtos/updateTeacher.dto.js";

//* Controller functions for handling Hogwarts staff data

export const getAllStaff = async (req, res) => {
  const staff = await staffRepo.getAllStaff();

  if (staff.length === 0) {
    throw new httpError(404, "Staff not found");
  }
  res.status(200).json(staff);
};
// Get a staff member by ID
export const getStaffById = async (req, res) => {
  const { id } = req.params;
  const member = await staffRepo.getStaffById(id);

  if (!member) {
    throw new httpError(404, "Staff member not found");
  }
  res.status(200).json(member);
};

export const createStaff = async (req, res) => {
  const teacherData = req.body;

  const validation = createTeacherSchema.safeParse(teacherData);
  if (!validation.success) {
    const errors = validation.error.flatten();
    const firstError =
      Object.values(errors.fieldErrors)[0]?.[0] ||
      Object.values(errors.formErrors)?.[0] ||
      "Validation failed";
    throw new httpError(400, firstError);
  }

  // Prevents duplicate staff entries, which could cause confusion in the database. Although two different people could have the same name and role, this check helps maintain data integrity.
  const existing = await staffRepo.findStaff(validation.data);

  if (existing) {
    throw new httpError(400, "Staff member already exists");
  }

  const newStaff = await staffRepo.createStaff(validation.data);
  res.status(201).json(newStaff);
};
// Update a staff member by ID
export const updateStaff = async (req, res) => {
  const { id } = req.params;
  const teacherData = req.body;

  const validation = UpdateTeacherSchema.safeParse(teacherData);
  if (!validation.success) {
    const errorMessage = validation.error.errors[0]?.message || "Validation failed";
    throw new httpError(400, errorMessage);
  }

  const existing = await staffRepo.getStaffById(id);

  if (!existing) {
    throw new httpError(404, "Staff member not found");
  }

  const updated = await staffRepo.updateStaff(id, validation.data);
  res.status(200).json(updated);
};

export const deleteStaff = async (req, res) => {
  const { id } = req.params;
  const existing = await staffRepo.getStaffById(id);

  if (!existing) {
    throw new httpError(404, "Staff member not found");
  }

  const deleted = await staffRepo.deleteStaff(id);
  res.status(200).json(deleted);
};
