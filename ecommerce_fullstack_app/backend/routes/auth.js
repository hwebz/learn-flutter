const express = require('express');
const router = express.Router();
const authController = require('../controllers/auth');
const authValidator = require('../validators/auth')

router.post('/login', authValidator.login, authController.login);
router.post('/register', authValidator.register, authController.register);
router.post('/forgot-password', authController.forgotPassword);
router.post('/verify-otp', authController.verifyPasswordResetOTP);
router.post('/reset-password', authController.resetPassword);

module.exports = router;