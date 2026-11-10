import * as staffRepo from "../repos/staff.repo.js";
import httpError from "../errorhandling/httpError.js";

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
  const { first_name, last_name, role } = req.body;
  // Prevents duplicate staff entries, which could cause confusion in the database. Although two different people could have the same name and role, this check helps maintain data integrity.
  const existing = await staffRepo.findStaff(first_name, last_name, role);

  if (existing) {
    throw new httpError(400, "Staff member already exists");
  }

  const created = await staffRepo.createStaff(first_name, last_name, role);
  res.status(201).json(created);
};
// Update a staff member by ID
export const updateStaff = async (req, res) => {
  const { id } = req.params;
  const { first_name, last_name, role } = req.body;
  const existing = await staffRepo.getStaffById(id);

  if (!existing) {
    throw new httpError(404, "Staff member not found");
  }

  const updated = await staffRepo.updateStaff(id, first_name, last_name, role);
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
