const express = require('express');
const router = express.Router();
const authController = require('../controllers/auth');
const authValidator = require('../validators/auth')

router.post('/login', authValidator.login, authController.login);
router.post('/register', authValidator.register, authController.register);
router.post('/forgot-password', authValidator.forgotPassword, authController.forgotPassword);
router.post('/verify-otp', authValidator.verifyPasswordResetOTP, authController.verifyPasswordResetOTP);
router.post('/reset-password', authValidator.resetPassword, authController.resetPassword);

module.exports = router;