import * as studentsRepo from "../repositories/students.repository.js";
import httpError from "../errorhandling/httpError.js";

//* Controller functions for handling Hogwarts students data

export const getAllStudents = async (req, res) => {
  const students = await studentsRepo.getAllStudents();

  if (students.length === 0) {
    throw new httpError(404, "No students found");
  }
  res.json(students);
};

export const getStudentById = async (req, res) => {
  const { id } = req.params;
  const student = await studentsRepo.getStudentById(id);

  if (!student) {
    throw new httpError(404, "Student not found");
  }
  res.json(student);
};

export const createStudent = async (req, res) => {
  const student = req.body;
  //? Not against the rules, but prevents accidental re-creation of the same student.
  const existing = await studentsRepo.findStudent(student);

  if (existing) {
    throw new httpError(400, "Student already exists");
  }

  const created = await studentsRepo.createStudent(student);
  res.status(201).json(created);
};

export const updateStudent = async (req, res) => {
  const { id } = req.params;
  const student = req.body;
  const existing = await studentsRepo.getStudentById(id);

  if (!existing) {
    throw new httpError(404, "Student not found");
  }

  const updated = await studentsRepo.updateStudent(id, student);
  res.status(200).json(updated);
};

export const deleteStudent = async (req, res) => {
  const { id } = req.params;
  const existing = await studentsRepo.getStudentById(id);

  if (!existing) {
    throw new httpError(404, "Student not found");
  }

  const deleted = await studentsRepo.deleteStudent(id);
  res.status(200).json(deleted);
};
