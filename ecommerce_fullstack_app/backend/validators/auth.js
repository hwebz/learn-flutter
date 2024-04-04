const { body } = require('express-validator');

const common = [
  body('email').isEmail().withMessage('Please enter a valid email address'),
  body('password')
  .isLength({ min: 8 }).withMessage('Password must be at least 8 characters long')
  .isStrongPassword().withMessage('Password must contain at least one uppercase, one lowercase, one symbol.'),
]

exports.register = [
  ...common,
  body('name').not().isEmpty().withMessage('Name is required'),
  body('phone').isMobilePhone().withMessage('Please enter a valid phone number'),
]

exports.login = [
  ...common
]