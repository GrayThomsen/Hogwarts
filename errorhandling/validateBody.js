import httpError from "./httpError.js";

// Instead of having to do this every time in the controllers, we do it here.
export default function validateBody(schema, body) {
  const result = schema.safeParse(body);
  if (!result.success) {
    throw new httpError(400, result.error.issues[0].message);
  }
  return result.data;
}
