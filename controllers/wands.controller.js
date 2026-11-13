import * as wandsRepository from "../repositories/wands.repository.js";
import httpError from "../errorhandling/httpError.js";
import validateBody from "../errorhandling/validateBody.js";

export const getAllWands = async (req, res) => {
  const wands = await wandsRepository.getAllWands();
  res.json(wands);
};

export const getWandById = async (req, res) => {
  const { id } = req.params;
  const wand = await wandsRepository.getWandById(id);
  if (!wand) {
    throw new httpError(404, "Wand not found");
  }
  res.json(wand);
};

export const getWandByStudentOwner = async (req, res) => {
  const { studentId } = req.params;
  const wand = await wandsRepository.getWandByStudentOwner(studentId);
  if (!wand) {
    throw new httpError(404, "Wand not found for the given student");
  }
  res.json(wand);
};

export const getWandByStaffOwner = async (req, res) => {
  const { staffId } = req.params;
  const wands = await wandsRepository.getWandByStaffOwner(staffId);
  if (!wands || wands.length === 0) {
    throw new httpError(404, "No wands found for the given staff member");
  }
  res.json(wands);
};

export const createWand = async (req, res) => {
  const wand = validateBody(createWandSchema, req.body);
  const created = await wandsRepository.createWand(wand);
  res.status(201).json(created);
};
