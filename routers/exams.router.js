import express from "express";
import {
  getAllExams,
  getExamById,
  deleteExam,
  createExam,
  updateExam,
  getExamsByStudentId,
} from "../controllers/exams.controller.js";

const router = express.Router();

router.get("/exams/", getAllExams);
router.get("/exams/:id", getExamById);
router.delete("/exams/:id", deleteExam);
router.post("/exams/", createExam);
router.put("/exams/:id", updateExam);
router.get("/exams/student/:studentId", getExamsByStudentId);

export default router;
