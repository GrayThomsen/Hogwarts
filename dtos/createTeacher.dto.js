import * as z from "zod";

export const createTeacherSchema = z.object({
  first_name: z.string().min(1, "First name is required"),
  last_name: z.string().min(1, "Last name is required").optional(),
  role: z.string().min(1, "Role is required"),
  house: z.string().min(1, "House is required").optional(),
});

export default createTeacherSchema;
