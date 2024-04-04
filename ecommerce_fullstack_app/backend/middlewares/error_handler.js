const jwt = require('jsonwebtoken');
const { Token } = require('../models/token');
const { User } = require('../models/user');

const errorHandler = async (error, req, res, next) => {
  // Only handling UnauthorizedError from jwt
  if (error.name === 'UnauthorizedError') {
    // If the error is not jwt expired, then return the error
    if (!error.message.includes('jwt expired')) {
      return res.status(error.status).json({
        type: error.name,
        message: error.message
      });
    }

    // If the error is jwt expired, then refresh the token
    try {
      const tokenHeader = req.header('Authorization');
      const authToken = tokenHeader?.split(' ')[1];

      const token = await Token.findOne({
        accessToken: authToken,
        refreshToken: { $exists: true },
      });

      if (!token) {
        return res.status(401).json({
          type: 'Unauthorized',
          message: 'Token doesn not exist.'
        });
      }

      const userData = jwt.verify(token.refreshToken, process.env.REFRESH_TOKEN_SECRET);
      const user = await User.findById(userData.id);
      if (!user) {
        return res.status(404).json({ message: 'Invalid user!' });
      }

      // Generate new access token
      const newAccessToken = jwt.sign(
        { id: user.id, isAdmin: user.isAdmin },
        process.env.ACCESS_TOKEN_SECRET,
        {
          expiresIn: '24h'
        }
      );

      // Update the request header with the new access token
      req.headers['authorization'] = `Bearer ${newAccessToken}`;
      
      // Update new access token in the database
      await Token.updateOne({
        _id: token._id
      }, {
        accessToken: newAccessToken
      }).exec();

      // Update the response header with the new access token
      res.set('Authorization', `Bearer ${newAccessToken}`);

      return next();
    } catch (refreshError) {
      return res.status(401).json({
        type: 'Unauthorized',
        message: refreshError.message
      });
    }
  }  
}

module.exports = errorHandler;