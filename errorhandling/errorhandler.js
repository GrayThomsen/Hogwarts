export default (err, req, res, next) => {
  res.status(err.statusCode || err.status || 500).json({
    error: err.name || "Internal Server Error",
    message: err.message || "Something has gone severely wrong!",
    status: err.statusCode || err.status || 500,
  });
};
