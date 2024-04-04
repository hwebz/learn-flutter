const { body } = require('express-validator');

const emailValidator = body('email').isEmail().withMessage('Please enter a valid email address');

const common = [
  emailValidator,
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

exports.forgotPassword = [
  emailValidator
]

exports.verifyPasswordResetOTP = [
  emailValidator,
  body('otp')
    .custom(value => {
      console.log(value);
      if (!/^[0-9]{6}$/.test(value)) {
        throw new Error('OTP must be a 6-digit number');
      }
      return true;
    })
]