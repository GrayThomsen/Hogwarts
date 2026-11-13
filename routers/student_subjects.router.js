import express from "express";
import * as studentSubjectsController from "../controllers/student_subjects.controller.js";

const router = express.Router();

router.get(
  "/student_subjects",
  studentSubjectsController.getAllStudentSubjects,
);
router.post(
  "/student_subjects",
  studentSubjectsController.createStudentSubject,
);
router.delete(
  "/student_subjects/:fk_student_id/:fk_subject_id/:year",
  studentSubjectsController.deleteStudentSubject,
);

export default router;
