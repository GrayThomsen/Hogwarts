import express from "express";
import * as classesController from "../controllers/classes.controller.js";

const router = express.Router();

router.get("/classes", classesController.getAllClasses);
router.get("/classes/:id", classesController.getClassById);
router.get("/classes/name/:name", classesController.getClassByName);
router.post("/classes", classesController.createClass);
router.put("/classes/:id", classesController.updateClass);
router.delete("/classes/:id", classesController.deleteClass);

export default router;
