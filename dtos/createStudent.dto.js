import * as z from "zod";

export const createStudentSchema = z
  .strictObject({
    first_name: z.string().trim().min(1).nullish(),
    last_name: z.string().trim().min(1).nullish(),
    fk_house: z.number().int().positive().nullish(),
    birthday: z.string().min(1).nullish(),
  })
  .refine((data) => data.first_name || data.last_name, {
    message: "First or last name is required",
    path: ["first_name"],
  });

export default createStudentSchema;
