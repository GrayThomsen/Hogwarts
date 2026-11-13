import * as staffRepository from "../repositories/staff.repository.js";
import httpError from "../errors/httpError.js";
import validateBody from "../errors/validateBody.js";
import createStaffSchema from "../dtos/createStaff.dto.js";
import updateStaffSchema from "../dtos/updateStaff.dto.js";

//* Controller functions for handling Hogwarts staff data

export const getAllStaff = async (req, res) => {
  const staff = await staffRepository.getAllStaff();

  if (staff.length === 0) {
    throw new httpError(404, "Staff not found");
  }
  res.status(200).json(staff);
};
// Get a staff member by ID
export const getStaffById = async (req, res) => {
  const { id } = req.params;
  const member = await staffRepository.getStaffById(id);

  if (!member) {
    throw new httpError(404, "Staff member not found");
  }
  res.status(200).json(member);
};

export const createStaff = async (req, res) => {
  const staff = validateBody(createStaffSchema, req.body);

  const existing = await staffRepository.findStaff(staff);
  if (existing) {
    throw new httpError(409, "Staff member already exists");
  }

  const newStaff = await staffRepository.createStaff(staff);
  res.status(201).json(newStaff);
};

export const updateStaff = async (req, res) => {
  const { id } = req.params;
  const staff = validateBody(updateStaffSchema, req.body);

  const updated = await staffRepository.updateStaff(id, staff);
  if (!updated) {
    throw new httpError(404, "Staff member not found");
  }
  res.status(200).json(updated);
};

// Delete a staff member by ID

export const deleteStaff = async (req, res) => {
  const { id } = req.params;
  const existing = await staffRepository.getStaffById(id);

  if (!existing) {
    throw new httpError(404, "Staff member not found");
  }

  const deleted = await staffRepository.deleteStaff(id);
  res.status(200).json(deleted);
};
