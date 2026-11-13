import * as examsRepository from "../repositories/exams.repository.js";
import httpError from "../errors/httpError.js";
import validateBody from "../errors/validateBody.js";
import createExamSchema from "../dtos/createExam.dto.js";
import updateExamSchema from "../dtos/updateExam.dto.js";

export async function getAllExams(req, res, next) {
  const AllExams = await examsRepository.getAllExams();

  if (AllExams.length === 0) {
    throw new httpError(404, "No exams found");
  }
  res.status(200).json(AllExams);
}

export async function getExamById(req, res, next) {
  const exam = await examsRepository.getExamById(req.params.id);

  if (!exam) {
    throw new httpError(404, "Exam not found");
  }
  res.status(200).json(exam);
}

export async function deleteExam(req, res, next) {
  const exam = await examsRepository.deleteExam(req.params.id);

  if (!exam) {
    throw new httpError(404, "Exam not found");
  }
  res.status(200).json(exam);
}

export async function createExam(req, res, next) {
  const data = validateBody(createExamSchema, req.body);
  const exam = await examsRepository.createExam(data);
  res.status(201).json(exam);
}

export async function updateExam(req, res, next) {
  const data = validateBody(updateExamSchema, req.body);
  const exam = await examsRepository.updateExam(req.params.id, data);

  if (!exam) {
    throw new httpError(404, "Exam not found");
  }
  res.status(200).json(exam);
}

export async function getExamsByStudentId(req, res, next) {
  const exams = await examsRepository.getExamsByStudentId(req.params.studentId);

  if (exams.length === 0) {
    throw new httpError(404, "No exams found for this student");
  }
  res.status(200).json(exams);
}
