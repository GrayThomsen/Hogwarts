import * as housesRepo from "../repos/houses.repo.js";

//* Controller functions for handling Hogwarts houses data

// Get all Hogwarts houses
export const getAllHouses = async (req, res) => {
  try {
    const AllHouses = await housesRepo.getAllHouses();

    if (AllHouses.length === 0) {
      return res.status(404).json({
        error: "Houses not found",
      });
    }
    res.status(200).json(AllHouses);
  } catch (error) {
    console.error(error);
    res.status(500).json({
      error: "Database error",
    });
  }
};
// Get a specific Hogwarts house by ID
export const getHouseById = async (req, res) => {
  try {
    const { id } = req.params;
    const house = await housesRepo.getHouseById(id);

    if (!house) {
      return res.status(404).json({
        error: "House not found",
      });
    }

    res.status(200).json(house);
  } catch (error) {
    console.error(error);
    res.status(500).json({
      error: "Database error",
    });
  }
};
