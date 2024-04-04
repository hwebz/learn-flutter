const { validationResult } = require('express-validator');

const validateRequest = (req) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    const errorMessages = errors.array().map((error) => ({
      field: error.path,
      message: error.msg
    }));
    return errorMessages;
  }
  return null;
}

module.exports = validateRequest;