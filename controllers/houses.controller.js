import * as housesRepository from "../repositories/houses.repository.js";
import httpError from "../errorhandling/httpError.js";

//* Controller functions for handling Hogwarts houses data

// Get all Hogwarts houses
export const getAllHouses = async (req, res) => {
  const AllHouses = await housesRepository.getAllHouses();

  if (AllHouses.length === 0) {
    throw new httpError(404, "No houses found");
  }
  res.status(200).json(AllHouses);
};
// Get a specific Hogwarts house by ID
export const getHouseById = async (req, res) => {
  const { id } = req.params;
  const house = await housesRepository.getHouseById(id);

  if (!house) {
    throw new httpError(404, "House not found");
  }
  res.status(200).json(house);
};

export const getHouseByName = async (req, res) => {
  const { name } = req.params;
  const house = await housesRepository.getHouseByName(name);

  if (!house) {
    throw new httpError(404, "House not found");
  }
  res.status(200).json(house);
};
