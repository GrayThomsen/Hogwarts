import express from "express";
import * as studentsController from "../controllers/students.controller.js";

const router = express.Router();

router.get("/students", studentsController.getAllStudents);
router.get("/students/:id", studentsController.getStudentById);
router.post("/students", studentsController.createStudent);
router.put("/students/:id", studentsController.updateStudent);
router.delete("/students/:id", studentsController.deleteStudent);

export default router;
