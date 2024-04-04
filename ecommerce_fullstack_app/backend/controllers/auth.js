const { User } = require('../models/user');
const { Token } = require('../models/token');
const bcrypt = require('bcryptjs');
const validateRequest = require('../utils/validate_request')
const jwt = require('jsonwebtoken');
const sendMail = require('../helpers/email_sender');

exports.register = async (req, res) => {
  const errors = validateRequest(req);
  if (errors) {
    return res.status(400).json({ errors });
  }

  try {
    let user = new User({
      ...req.body,
      passwordHash: bcrypt.hashSync(req.body.password, 8),
    });

    user = await user.save();
    
    if (!user) {
      return res.status(500).json({ type: 'Internal Server Error', message: 'Could not create a new user' });
    }

    return res.status(201).json(user);
  } catch (error) {
    if (error.message.includes('email_1')) {
      return res.status(409).json({ type: 'AuthError', message: 'Email already exists' });
    }
    return res.status(500).json({ type: error.name, message: error.message });
  }
};

exports.login = async (req, res) => {
  const errors = validateRequest(req);
  if (errors) {
    return res.status(400).json({ errors });
  }

  try {
     const { email, password } = req.body;
     const user = await User.findOne({ email: email });

     if (!user) {
      return res.status(404).json({ type: 'AuthError', message: 'User not found. Check your email and try again.' });
     }
     if (!bcrypt.compareSync(password, user.passwordHash)) {
      return res.status(400).json({ type: 'AuthError', message: 'Incorrect password.' });
     }

     const accessToken = jwt.sign({
      id: user.id,
      isAdmin: user.isAdmin,
     }, process.env.ACCESS_TOKEN_SECRET, {
      expiresIn: '24h'
     },);

     const refreshToken = jwt.sign({
      id: user.id,
      isAdmin: user.isAdmin,
     }, process.env.REFRESH_TOKEN_SECRET, {
      expiresIn: '60d'
     },);

     const token = await Token.findOne({ userId: user.id });
     if (token) {
      await token.deleteOne();
     }
     await new Token({
      userId: user.id,
      accessToken,
      refreshToken: refreshToken,
    }).save();

     user.passwordHash = undefined;

     return res.status(200).json({
      ...user._doc,
      accessToken,
      refreshToken,
     });
  } catch (error) {
    return res.status(500).json({ type: error.name, message: error.message });
  }
};

exports.verifyToken = async (req, res) => {
  try {
    let accessToken = req.headers.authorization;
    if (!accessToken) {
      return res.json(false)
    };
    accessToken = accessToken.replace('Bearer ', '').trim();

    const token = await Token.findOne({
      accessToken
    });
    if (!token) {
      return res.json(false);
    }

    const tokenData = jwt.decode(token.refreshToken);
    const user = await User.findById(tokenData.id);
    if (!user) {
      return res.json(false);
    }

    // The reason why we verify refreshToken instead of accessToken is because
    // accessToken can be expired from users' perspective, but refreshToken need
    // to be valid in order to generate a new accessToken from ourside, so
    // that's why accessToken is only the key to find the refreshToken in the
    // database only.
    const isValid = jwt.verify(token.refreshToken, process.env.REFRESH_TOKEN_SECRET);
    if (!isValid) {
      return res.json(false);
    }

    return res.json(true);
  } catch (error) {
    return res.status(500).json({ type: error.name, message: error.message });
  }
};

exports.forgotPassword = async (req, res) => {
  const errors = validateRequest(req);
  if (errors) {
    return res.status(400).json({ errors });
  }

  try {
    const { email } = req.body;
    const user = await User.findOne({ email });

    if (!user) {
      return res.status(404).json({ type: 'AuthError', message: 'User not found. Check your email and try again.' });
    }

    const otp = Math.floor(100000 + Math.random() * 900000);

    user.resetPasswordOtp = otp;
    user.resetPasswordOtpExpires = Date.now() + 600000; // 10 minutes

    await user.save();

    const response = await sendMail(
      email,
      'Password Reset OTP',
      `Your OTP for password reset is: ${otp}`,
      `Password Reset OTP sent successfully for ${email}`,
      `Error sending password reset OTP for ${email}`
    );

    return res.status(200).json({ message: response.message });
  } catch (error) {
    return res.status(500).json({ type: error.name, message: error.message });
  }
};
exports.verifyPasswordResetOTP = async (req, res) => {
  const errors = validateRequest(req);
  if (errors) {
    return res.status(400).json({ errors });
  }

  try {
    const { email, otp } = req.body;

    const user = await User.findOne({ email: email });
    if (!user) {
      return res.status(404).json({ type: 'AuthError', message: 'User not found. Check your email and try again.' });
    }

    if (user.resetPasswordOtp !== +otp || user.resetPasswordOtpExpires < Date.now()) {
      return res.status(400).json({ type: 'AuthError', message: 'Invalid OTP. Please try again.' });
    }

    user.resetPasswordOtp = undefined;
    user.resetPasswordOtpExpires = undefined;
    user.resetPasswordOtpVerified = true;

    await user.save();

    return res.status(200).json({ message: 'OTP verified successfully' });
  } catch (error) {
    return res.status(500).json({ type: error.name, message: error.message }); 
  }
};
exports.resetPassword = async (req, res) => {
  const errors = validateRequest(req);
  if (errors) {
    return res.status(400).json({ errors });
  }
  
  try {
    const { email, password } = req.body;

    const user = await User.findOne({ email: email });
    if (!user) {
      return res.status(404).json({ type: 'AuthError', message: 'User not found. Check your email and try again.' });
    }

    if (!user.resetPasswordOtpVerified) {
      return res.status(400).json({ type: 'AuthError', message: 'Please verify OTP first.' });
    }

    user.passwordHash = bcrypt.hashSync(password, 8);
    user.resetPasswordOtpVerified = false;

    await user.save();

    return res.status(200).json({ message: 'Password reset successfully' });
  } catch (error) {
    return res.status(500).json({ type: error.name, message: error.message });
  }
};