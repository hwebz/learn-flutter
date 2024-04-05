const { User } = require('../models/user');

exports.getUsers = async (req, res) => {
  try {
    const users = await User.find().select('name email id isAdmin');
    if (!users) {
      return res.status(404).json({ message: 'No users found' });
    }
    return res.json(users);
  } catch (error) {
    return res.status(500).json({ type: error.name, message: error.message });
  }
};

exports.getUserById = async (req, res) => {
  try {
    const user = await User.findById(req.params.id).select('-passwordHash -resetPasswordOtp -resetPasswordOtpExpires -resetPasswordOtpVerified -cart');
    if (!user) {
      return res.status(404).json({ message: 'User not found' });
    }

    return res.json(user);
  } catch (error) {
    return res.status(500).json({ type: error.name, message: error.message });
  }
};

exports.updateUser = async (req, res) => {
  try {
    const { name, phone } = req.body;
    const updatedUser = await User.findByIdAndUpdate(
      req.params.id,
      { name, phone },
      { new: true },
    );

    if (!updatedUser) {
      return res.status(404).json({ message: 'User not found' });
    }
    user.passwordHash = undefined;
    return res.json(updatedUser);
  } catch (error) {
    return res.status(500).json({ type: error.name, message: error.message });
  }
};