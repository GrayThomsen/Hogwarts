import express from "express";
import * as wandsController from "../controllers/wands.controller.js";

const router = express.Router();

router.get("/", wandsController.getAllWands);
router.get("/:id", wandsController.getWandById);
router.get("/student/:studentId", wandsController.getWandByStudentOwner);
router.get("/staff/:staffId", wandsController.getWandByStaffOwner);
router.post("/", wandsController.createWand);

export default router;
