import * as z from "zod";

export const createStudentSubjectSchema = z.strictObject({
  fk_student_id: z.number().int().positive(),
  fk_subject_id: z.number().int().positive(),
  year: z.number().int().min(1).max(7),
});

export default createStudentSubjectSchema;
