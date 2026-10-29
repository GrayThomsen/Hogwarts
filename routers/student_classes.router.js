import express from "express";
import {
  getAllStudentClasses,
  findStudentClassByIdsAndYear,
  createStudentClass,
  deleteStudentClass,
} from "../controllers/student_classes.controller.js";

const router = express.Router();

router.get("/student_classes", getAllStudentClasses);
router.get("/student_classes/:student_id/:class_id/:year", findStudentClassByIdsAndYear);
router.post("/student_classes", createStudentClass);
router.delete("/student_classes/:student_id/:class_id/:year", deleteStudentClass);

export default router;
