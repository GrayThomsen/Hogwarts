import express from "express";
const app = express();

export default app.use((err, req, res, next) => {
  res.status(500).json({
    error: "Something has gone severely wrong!",
    message: err.message,
    status: res.statusCode,
  });
});
