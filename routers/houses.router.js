import express from "express";
import {
  getAllHouses,
  getHouseById,
  getHouseByName,
} from "../controllers/houses.controller.js";

const router = express.Router();

router.get("/houses", getAllHouses);
router.get("/houses/:id", getHouseById);
router.get("/houses/name/:name", getHouseByName);

export default router;
