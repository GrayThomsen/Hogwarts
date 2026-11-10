import * as housesRepo from "../repos/houses.repo.js";
import httpError from "../errorhandling/httpError.js";

//* Controller functions for handling Hogwarts houses data

// Get all Hogwarts houses
export const getAllHouses = async (req, res) => {
  // try {
  const AllHouses = await housesRepo.getAllHouses();

  if (AllHouses.length === 0) {
    throw new httpError(404, "No houses found");
  }
  // res.status(200).json(AllHouses);
  // } catch (error) {
  //   console.error(error);
  //   res.status(500).json({
  //     message: "Failed to retrieve houses",
  //     error: "internal server error",
  //     status: res.statusCode,
  //   });
  // }
};
// Get a specific Hogwarts house by ID
export const getHouseById = async (req, res) => {
  // try {
  const { id } = req.params;
  const house = await housesRepo.getHouseById(id);

  if (!house) {
    throw new httpError(404, "House not found");
  }
else {
  res.status(200).json(house);
}

  //   } catch (error) {
  //     console.error(error);
  //     res.status(500).json({
  //       message: "Failed to retrieve house",
  //       error: "internal server error",
  //       status: res.statusCode,
  //     });
  //   }
  //
};
