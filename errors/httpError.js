export default class httpError extends Error {
  constructor(statusCode, message) {
    super(message);
    this.statusCode = statusCode;
    this.type = this.constructor.name;
  }
}
