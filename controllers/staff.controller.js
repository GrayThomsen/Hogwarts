import * as staffRepo from "../repos/staff.repo.js";

//* Controller functions for handling Hogwarts staff data

export const getAllStaff = async (req, res) => {
  try {
    const staff = await staffRepo.getAllStaff();

    if (staff.length === 0) {
      return res.status(404).json({ error: "Staff not found" });
    }
    res.status(200).json(staff);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Database error" });
  }
};
// Get a staff member by ID
export const getStaffById = async (req, res) => {
  try {
    const { id } = req.params;
    const member = await staffRepo.getStaffById(id);

    if (!member) {
      return res.status(404).json({ error: "Staff member not found" });
    }
    res.status(200).json(member);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Database error" });
  }
};

export const createStaff = async (req, res) => {
  try {
    const { first_name, last_name, role } = req.body;
    // Prevents duplicate staff entries, which could cause confusion in the database. Although two different people could have the same name and role, this check helps maintain data integrity.
    const existing = await staffRepo.findStaff(first_name, last_name, role);

    if (existing) {
      return res.status(400).json({ error: "Staff member already exists" });
    }

    const created = await staffRepo.createStaff(first_name, last_name, role);
    res.status(201).json(created);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Database error" });
  }
};
// Update a staff member by ID
export const updateStaff = async (req, res) => {
  try {
    const { id } = req.params;
    const { first_name, last_name, role } = req.body;
    const existing = await staffRepo.getStaffById(id);

    if (!existing) {
      return res.status(404).json({ error: "Staff member not found" });
    }

    const updated = await staffRepo.updateStaff(
      id,
      first_name,
      last_name,
      role,
    );
    res.status(200).json(updated);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Database error" });
  }
};

export const deleteStaff = async (req, res) => {
  try {
    const { id } = req.params;
    const existing = await staffRepo.getStaffById(id);

    if (!existing) {
      return res.status(404).json({ error: "Staff member not found" });
    }

    const deleted = await staffRepo.deleteStaff(id);
    res.status(200).json(deleted);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Database error" });
  }
};
