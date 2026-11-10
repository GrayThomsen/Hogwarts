import { STATUS_CODES } from "node:http";

export default (err, req, res, next) => {
  const status = err.statusCode || err.status || 500;
  res.status(status).json({
    error: STATUS_CODES[status] || "Internal Server Error",
    message: err.message || "Something has gone severely wrong!",
    status,
  });
};

// export default (err, req, res, next) => {
//   let error = "";
//   if (err.statusCode === 404) {
//     error = "Not Found";
//   } else if (err.statusCode === 400) {
//     error = "Bad Request";
//   } else if (err.statusCode === 401) {
//     error = "Unauthorized";
//   } else if (err.statusCode === 403) {
//     error = "Forbidden";
//   } else if (err.statusCode === 409) {
//     error = "Conflict";
//   } else if (err.statusCode === 418) {
//     error = "I'm a teapot";
//   } else if (err.statusCode === 500) {
//     error = "Internal Server Error";
//   }

//   res.status(err.statusCode || err.status || 500).json({
//     error: error,
//     message: err.message || "Something has gone severely wrong!",
//     status: err.statusCode || err.status || 500,
//   });
// };
