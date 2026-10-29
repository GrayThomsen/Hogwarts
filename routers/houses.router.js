import express from "express";
import { getAllHouses, getHouseById } from "../controllers/houses.controller.js";

const router = express.Router();

router.get("/houses", getAllHouses);
router.get("/houses/:id", getHouseById);

export default router;
