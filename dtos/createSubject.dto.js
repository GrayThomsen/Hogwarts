import * as z from "zod";

export const createSubjectSchema = z
  .strictObject({
    name: z.string().min(1),
    start_year: z.number().int().min(1).max(7),
    end_year: z.number().int().min(1).max(7),
    fk_type: z.number().int().positive().nullish(),
    fk_required_grade: z.number().int().positive().nullish(),
  })
  .refine((data) => data.end_year >= data.start_year, {
    message: "End year must not be before start year",
    path: ["end_year"],
  });

export default createSubjectSchema;
