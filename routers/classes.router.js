import express from "express";
import {
  getAllClasses,
  getClassById,
  createClass,
  updateClass,
  deleteClass,
} from "../controllers/classes.controller.js";

const router = express.Router();

router.get("/classes", getAllClasses);
router.get("/classes/:id", getClassById);
router.post("/classes", createClass);
router.put("/classes/:id", updateClass);
router.delete("/classes/:id", deleteClass);

export default router;
