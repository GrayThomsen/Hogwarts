import * as z from "zod";

export const createExamSchema = z.strictObject({
  fk_student_id: z.number().int().positive(),
  fk_subject_id: z.number().int().positive(),
  date: z.string().min(1),
  fk_grade_id: z.number().int().positive().nullish(),
  fk_qualifications: z.number().int().positive().nullish(),
  fk_regulators: z.number().int().positive().nullish(),
});

export default createExamSchema;
