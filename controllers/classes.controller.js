import * as classesRepo from "../repos/classes.repo.js";

//* Controller functions for handling Hogwarts classes data
export const getAllClasses = async (req, res) => {
  try {
    const allClasses = await classesRepo.getAllClasses();

    if (allClasses.length === 0) {
      return res.status(404).json({
        error: "Classes not found",
      });
    }

    res.status(200).json(allClasses);
  } catch (error) {
    console.error(error);
    res.status(500).json({
      error: "Database error",
    });
  }
};
// Get a specific Hogwarts class by ID
export const getClassById = async (req, res) => {
  try {
    const { id } = req.params;
    const classData = await classesRepo.getClassById(id);

    if (!classData) {
      return res.status(404).json({
        error: "Class not found",
      });
    }

    res.status(200).json(classData);
  } catch (error) {
    console.error(error);
    res.status(500).json({
      error: "Database error",
    });
  }
};

// Create a new class
export const createClass = async (req, res) => {
  try {
    const { name } = req.body;
    const existing = await classesRepo.getClassByName(name);

    if (existing) {
      return res.status(409).json({
        error: "Class with the same name already exists",
      });
    }

    const created = await classesRepo.createClass(name);
    res.status(201).json(created);
  } catch (error) {
    console.error(error);
    res.status(500).json({
      error: "Database error",
    });
  }
};

// Update a class by ID
export const updateClass = async (req, res) => {
  try {
    const { id } = req.params;
    const { name } = req.body;
    const existing = await classesRepo.getClassById(id);

    if (!existing) {
      return res.status(404).json({
        error: "Class not found",
      });
    }

    const updated = await classesRepo.updateClass(id, name);
    res.status(200).json(updated);
  } catch (error) {
    console.error(error);
    res.status(500).json({
      error: "Database error",
    });
  }
};

// Delete a class by ID
export const deleteClass = async (req, res) => {
  try {
    const { id } = req.params;
    const existing = await classesRepo.getClassById(id);

    if (!existing) {
      return res.status(404).json({
        error: "Class not found",
      });
    }

    const deleted = await classesRepo.deleteClass(id);
    res.status(200).json(deleted);
  } catch (error) {
    console.error(error);
    res.status(500).json({
      error: "Database error",
    });
  }
};
