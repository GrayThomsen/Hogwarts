import * as classesRepo from "../repos/classes.repo.js";
import httpError from "../errorhandling/httpError.js";

//* Controller functions for handling Hogwarts classes data
export const getAllClasses = async (req, res) => {
  const allClasses = await classesRepo.getAllClasses();

  if (allClasses.length === 0) {
    throw new httpError(404, "Classes not found");
  }

  res.status(200).json(allClasses);
};

export const getClasses = async (req, res) => {
  const classes = await classesRepo.getAllClasses();

  if (classes.length === 0) {
    throw new httpError(404, "Classes not found");
  }

  res.status(200).json(classes);
};

// Get a specific Hogwarts class by ID
export const getClassById = async (req, res) => {
  const { id } = req.params;
  const classData = await classesRepo.getClassById(id);

  if (!classData) {
    throw new httpError(404, "Class not found");
  }

  res.status(200).json(classData);
};

// Create a new class
export const createClass = async (req, res) => {
  const { name } = req.body;
  const existing = await classesRepo.getClassByName(name);

  if (existing) {
    throw new httpError(409, "Class with the same name already exists");
  }

  const created = await classesRepo.createClass(name);
  res.status(201).json(created);
};

// Update a class by ID
export const updateClass = async (req, res) => {
  const { id } = req.params;
  const { name } = req.body;
  const existing = await classesRepo.getClassById(id);

  if (!existing) {
    throw new httpError(404, "Class not found");
  }

  const updated = await classesRepo.updateClass(id, name);
  res.status(200).json(updated);
};

// Delete a class by ID
export const deleteClass = async (req, res) => {
  const { id } = req.params;
  const existing = await classesRepo.getClassById(id);

  if (!existing) {
    throw new httpError(404, "Class not found");
  }

  const deleted = await classesRepo.deleteClass(id);
  res.status(200).json(deleted);
};
