import express from "express";
import * as staffSubjectsController from "../controllers/staff_subjects.controller.js";

const router = express.Router();

router.get("/staff_subjects", staffSubjectsController.getAllStaffSubjects);
router.post("/staff_subjects", staffSubjectsController.createStaffSubject);
router.delete("/staff_subjects/:fk_staff_id/:fk_subject_id", staffSubjectsController.deleteStaffSubject);

export default router;
