import express from "express";

//--------------------------------
//* Import Controllers
//--------------------------------
import * as studentsController from "./controllers/students.controller.js";
import * as housesController from "./controllers/houses.controller.js";
import * as staffController from "./controllers/staff.controller.js";
import * as classesController from "./controllers/classes.controller.js";
import * as teacherClassesController from "./controllers/teacher_classes.controller.js";
import * as studentClassesController from "./controllers/student_classes.controller.js";

// Express app setup
const app = express();

app.use(express.json());

app.listen(3000, () => {
  console.log("Server running on port 3000");
});

//---------------------------------------------------------------------------------------------------------------
//*  Student Data
//---------------------------------------------------------------------------------------------------------------
app.get("/students", studentsController.getAllStudents);
app.get("/students/:id", studentsController.getStudentById);
app.post("/students", studentsController.createStudent);
app.put("/students/:id", studentsController.updateStudent);
app.delete("/students/:id", studentsController.deleteStudent);

//---------------------------------------------------------------------------------------------------------------
//*  Houses Data
//---------------------------------------------------------------------------------------------------------------
app.get("/houses", housesController.getAllHouses);
app.get("/houses/:id", housesController.getHouseById);

//---------------------------------------------------------------------------------------------------------------
//*  Staff Data
//---------------------------------------------------------------------------------------------------------------
app.get("/staff", staffController.getAllStaff);
app.get("/staff/:id", staffController.getStaffById);
app.post("/staff", staffController.createStaff);
app.put("/staff/:id", staffController.updateStaff);
app.delete("/staff/:id", staffController.deleteStaff);

//---------------------------------------------------------------------------------------------------------------
//*  Class Data
//---------------------------------------------------------------------------------------------------------------
app.get("/classes", classesController.getAllClasses);
app.get("/classes/:id", classesController.getClassById);
app.post("/classes", classesController.createClass);
app.put("/classes/:id", classesController.updateClass);
app.delete("/classes/:id", classesController.deleteClass);

//---------------------------------------------------------------------------------------------------------------
//*  Teacher Class Data
//---------------------------------------------------------------------------------------------------------------
app.get("/teacher_classes", teacherClassesController.getAllTeacherClasses);
app.post("/teacher_classes", teacherClassesController.createTeacherClass);
app.delete(
  "/teacher_classes/:teacher_id/:class_id",
  teacherClassesController.deleteTeacherClass,
);

//---------------------------------------------------------------------------------------------------------------
//*  Student Class Data
//---------------------------------------------------------------------------------------------------------------
app.get("/student_classes", studentClassesController.getAllStudentClasses);
app.post("/student_classes", studentClassesController.createStudentClass);
app.delete(
  "/student_classes/:student_id/:class_id/:year",
  studentClassesController.deleteStudentClass,
);
