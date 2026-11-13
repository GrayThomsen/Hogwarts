import express from "express";
import {
  getAllStaffSubjects,
  createStaffSubject,
  deleteStaffSubject,
} from "../controllers/staff_subjects.controller.js";

const router = express.Router();

router.get("/staff_subjects", getAllStaffSubjects);
router.post("/staff_subjects", createStaffSubject);
router.delete("/staff_subjects/:fk_staff_id/:fk_subject_id", deleteStaffSubject);

export default router;
