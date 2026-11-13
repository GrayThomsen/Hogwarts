// Express app setup
import express from "express";

// Routers
//* Notice the complete seperation of concerns.
import housesRouter from "./routers/houses.router.js";
import studentsRouter from "./routers/students.router.js";
import staffRouter from "./routers/staff.router.js";
import subjectsRouter from "./routers/classes.router.js";
import studentSubjectRouter from "./routers/student_subjects.router.js";
import staffSubjectsRouter from "./routers/staff_subjects.router.js";
import wandsRouter from "./routers/wands.router.js";
import examsRouter from "./routers/exams.router.js";

import errorHandler from "./errorhandling/errorhandler.js";
const app = express();

// Middleware for parsing JSON bodies
app.use(express.json());
app.use(studentsRouter);
app.use(staffRouter);
app.use(subjectsRouter);
app.use(studentSubjectRouter);
app.use(staffSubjectsRouter);
app.use(examsRouter);
app.use(housesRouter);
app.use(wandsRouter);

app.use(errorHandler);

// Start the server
app.listen(3000, () => {
  console.log("Server running on port 3000");
});
