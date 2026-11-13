import * as z from "zod";

export const createStaffSubjectSchema = z.strictObject({
  fk_staff_id: z.number().int().positive(),
  fk_subject_id: z.number().int().positive(),
  role: z.string().max(255).nullish(),
});

export default createStaffSubjectSchema;
