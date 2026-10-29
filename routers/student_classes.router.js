import express from "express";
import {
  getAllStudentClasses,
  createStudentClass,
  deleteStudentClass,
} from "../controllers/student_classes.controller.js";

const router = express.Router();

router.get("/student_classes", getAllStudentClasses);
router.post("/student_classes", createStudentClass);
router.delete(
  "/student_classes/:student_id/:class_id/:year",
  deleteStudentClass,
);

export default router;
