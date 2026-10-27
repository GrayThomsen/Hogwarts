//* Database connection setup using ES modules
//Notice how we don't use "Require" here. We changed from commonJS to ES modules with import/export syntax. We did this to modernize our code and take advantage of ES module features.
//ES is a newer version of JS. Which includes features like import/export syntax, arrow functions, and more.
//CJS (CommonJS) uses require() and module.exports for importing and exporting modules. But is a legacy system from Node.js.

/* Database connection setup */
import "dotenv/config";
import { Pool } from "pg";

/* Initialize PostgreSQL connection pool */
const pool = new Pool({
  host: process.env.DB_HOST,
  port: Number(process.env.DB_PORT),
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
});

export { pool };
