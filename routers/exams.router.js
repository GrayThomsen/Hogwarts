import express from "express";
import * as examsController from "../controllers/exams.controller.js";

const router = express.Router();

router.get("/exams/", examsController.getAllExams);
router.get("/exams/:id", examsController.getExamById);
router.delete("/exams/:id", examsController.deleteExam);
router.post("/exams/", examsController.createExam);
router.put("/exams/:id", examsController.updateExam);
router.get("/exams/student/:studentId", examsController.getExamsByStudentId);

export default router;
