import { pool } from "../db.js";

//* Repository functions for handling Hogwarts houses data

export async function getAllHouses() {
  const result = await pool.query(/*SQL*/ `SELECT 
    houses.id,
    houses.name,
    concat(founder.first_name, ' ', founder.last_name) as "Founder",
    concat(house_ghost.first_name, ' ', house_ghost.last_name) as "House Ghost",
    concat(head_of_house.first_name, ' ', head_of_house.last_name) as "Head of House"
    FROM houses 
    LEFT JOIN staff AS founder ON houses.fk_founder = founder.id
    LEFT JOIN staff AS house_ghost ON houses.fk_house_ghost = house_ghost.id
    LEFT JOIN staff AS head_of_house ON houses.fk_head_of_house = head_of_house.id
    ORDER BY id`);
  return result.rows;
}

export async function getHouseById(id) {
  const result = await pool.query(
    /*SQL*/ `SELECT 
    houses.id,
    houses.name,
    concat(founder.first_name, ' ', founder.last_name) as "Founder",
    concat(house_ghost.first_name, ' ', house_ghost.last_name) as "House Ghost",
    concat(head_of_house.first_name, ' ', head_of_house.last_name) as "Head of House"
    FROM houses 
    LEFT JOIN staff AS founder ON houses.fk_founder = founder.id
    LEFT JOIN staff AS house_ghost ON houses.fk_house_ghost = house_ghost.id
    LEFT JOIN staff AS head_of_house ON houses.fk_head_of_house = head_of_house.id
    WHERE houses.id = $1
    ORDER BY id`,
    [id],
  );
  return result.rows[0];
}

export async function getHouseByName(name) {
  const result = await pool.query(
    /*SQL*/ `SELECT 
    houses.id,
    houses.name,
    concat(founder.first_name, ' ', founder.last_name) as "Founder",
    concat(house_ghost.first_name, ' ', house_ghost.last_name) as "House Ghost",
    concat(head_of_house.first_name, ' ', head_of_house.last_name) as "Head of House"
    FROM houses 
    LEFT JOIN staff AS founder ON houses.fk_founder = founder.id
    LEFT JOIN staff AS house_ghost ON houses.fk_house_ghost = house_ghost.id
    LEFT JOIN staff AS head_of_house ON houses.fk_head_of_house = head_of_house.id
    WHERE houses.name = $1
    ORDER BY id`,
    [name],
  );
  return result.rows[0];
}
