import express from "express";
import {
  getAllStudentSubjects,
  createStudentSubject,
  deleteStudentSubject,
} from "../controllers/student_subjects.controller.js";

const router = express.Router();

router.get("/student_subjects", getAllStudentSubjects);
router.post("/student_subjects", createStudentSubject);
router.delete(
  "/student_subjects/:fk_student_id/:fk_subject_id/:year",
  deleteStudentSubject,
);

export default router;
