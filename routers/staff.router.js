import express from "express";
import * as staffController from "../controllers/staff.controller.js";

const router = express.Router();

router.get("/staff", staffController.getAllStaff);
router.get("/staff/:id", staffController.getStaffById);
router.post("/staff", staffController.createStaff);
router.put("/staff/:id", staffController.updateStaff);
router.delete("/staff/:id", staffController.deleteStaff);

export default router;
