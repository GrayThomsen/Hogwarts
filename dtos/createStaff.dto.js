import * as z from "zod";

export const createStaffSchema = z
  .strictObject({
    first_name: z.string().trim().min(1).nullish(),
    last_name: z.string().trim().min(1).nullish(),
    fk_house: z.number().int().positive().nullish(),
    active_status: z.boolean(),
    health_status: z.string().min(1),
    birthday: z.string().min(1).nullish(),
    date_of_hiring: z.string().min(1).nullish(),
    final_day: z.string().min(1).nullish(),
  })
  .refine((data) => data.first_name || data.last_name, {
    message: "First or last name is required",
    path: ["first_name"],
  });

export default createStaffSchema;
