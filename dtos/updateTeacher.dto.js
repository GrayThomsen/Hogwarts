import * as z from "zod";

export const updateTeacherSchema = z
  .object({
    first_name: z.string().min(1, "First name is required").optional(),
    last_name: z.string().min(1, "Last name is required").optional(),
    role: z.string().min(1, "Role is required").optional(),
    house: z.number().min(0, "House is required").optional(),
  });

export default updateTeacherSchema;