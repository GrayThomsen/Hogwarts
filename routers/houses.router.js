import express from "express";
import * as housesController from "../controllers/houses.controller.js";

const router = express.Router();

router.get("/houses", housesController.getAllHouses);
router.get("/houses/:id", housesController.getHouseById);
router.get("/houses/name/:name", housesController.getHouseByName);

export default router;
