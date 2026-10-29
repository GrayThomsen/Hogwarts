import express from "express";
import {
  getAllTeacherClasses,
  createTeacherClass,
  deleteTeacherClass,
} from "../controllers/teacher_classes.controller.js";

const router = express.Router();

router.get("/teacher_classes", getAllTeacherClasses);
router.post("/teacher_classes", createTeacherClass);
router.delete("/teacher_classes/:teacher_id/:class_id", deleteTeacherClass);

export default router;
