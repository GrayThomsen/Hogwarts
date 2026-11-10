import * as housesRepo from "../repos/houses.repo.js";
import httpError from "../errorhandling/httpError.js";

//* Controller functions for handling Hogwarts houses data

// Get all Hogwarts houses
export const getAllHouses = async (req, res) => {
  const AllHouses = await housesRepo.getAllHouses();

  if (AllHouses.length === 0) {
    throw new httpError(404, "No houses found");
  }
  res.status(200).json(AllHouses);
};
// Get a specific Hogwarts house by ID
export const getHouseById = async (req, res) => {
  const { id } = req.params;
  const house = await housesRepo.getHouseById(id);

  if (!house) {
    throw new httpError(404, "House not found");
  }
  res.status(200).json(house);
};
