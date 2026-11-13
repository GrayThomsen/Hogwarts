import * as subjectsRepository from "../repositories/classes.repository.js";
import httpError from "../errors/httpError.js";
import validateBody from "../errors/validateBody.js";
import createSubjectSchema from "../dtos/createSubject.dto.js";
import updateSubjectSchema from "../dtos/updateSubject.dto.js";

//* Controller functions for handling Hogwarts classes data
export const getAllClasses = async (req, res) => {
  const allClasses = await subjectsRepository.getAllClasses();

  if (allClasses.length === 0) {
    throw new httpError(404, "Classes not found");
  }

  res.status(200).json(allClasses);
};

export const getClasses = async (req, res) => {
  const classes = await subjectsRepository.getAllClasses();

  if (classes.length === 0) {
    throw new httpError(404, "Classes not found");
  }

  res.status(200).json(classes);
};

// Get a specific Hogwarts class by ID
export const getClassById = async (req, res) => {
  const { id } = req.params;
  const classData = await subjectsRepository.getClassById(id);

  if (!classData) {
    throw new httpError(404, "Class not found");
  }

  res.status(200).json(classData);
};

export const getClassByName = async (req, res) => {
  const { name } = req.params;
  const classData = await subjectsRepository.getClassByName(name);

  if (!classData) {
    throw new httpError(404, "No subject of that name");
  }

  res.status(200).json(classData);
};

// Create a new class
export const createClass = async (req, res) => {
  const subjectData = validateBody(createSubjectSchema, req.body);
  const existing = await subjectsRepository.getClassByName(
    subjectData.name,
    subjectData.start_year,
    subjectData.end_year,
  );

  if (existing) {
    throw new httpError(409, "Class with the same name already exists");
  }

  const created = await subjectsRepository.createClass(subjectData);
  res.status(201).json(created);
};

// Update a class by ID
export const updateClass = async (req, res) => {
  const { id } = req.params;
  const classData = validateBody(updateSubjectSchema, req.body);
  const existing = await subjectsRepository.getClassById(id);

  if (!existing) {
    throw new httpError(404, "Class not found");
  }

  const updated = await subjectsRepository.updateClass(id, classData);
  res.status(200).json(updated);
};

// Delete a class by ID
export const deleteClass = async (req, res) => {
  const { id } = req.params;
  const existing = await subjectsRepository.getClassById(id);

  if (!existing) {
    throw new httpError(404, "Class not found");
  }

  const deleted = await subjectsRepository.deleteClass(id);
  res.status(200).json(deleted);
};
