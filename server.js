// Express app setup
import express from "express";

// Routers
//* Notice the complete seperation of concerns.
import housesRouter from "./routers/houses.router.js";
import studentsRouter from "./routers/students.router.js";
import staffRouter from "./routers/staff.router.js";
import classesRouter from "./routers/classes.router.js";
import studentClassesRouter from "./routers/student_classes.router.js";
import teacherClassesRouter from "./routers/teacher_classes.router.js";
const app = express();

app.use(express.json());
app.use(studentsRouter);
app.use(staffRouter);
app.use(classesRouter);
app.use(studentClassesRouter);
app.use(teacherClassesRouter);
app.use(housesRouter);

app.listen(3000, () => {
  console.log("Server running on port 3000");
});
