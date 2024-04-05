const { User } = require('../../models/user');
const { Order } = require('../../models/order');
const { OrderItem } = require('../../models/order_item');
const { CartProduct } = require('../../models/cart_product');
const { Token } = require('../../models/token');

exports.getUsersCount = async (req, res) => {
  try {
    const usersCount = await User.countDocuments();
    if (!usersCount) {
      return res.status(500).json({ message: 'Could not count users.'});
    }
    return res.json({ usersCount});
  } catch (error) {
    return res.status(500).json({ error: 'Could not count users.' });
  }
};

exports.deleteUser = async (req, res) => {
  try {
    const userId = req.params.id;
    
    const user = await User.findById(userId);
    if (!user) {
      return res.status(404).json({ message: 'User not found.' });
    }

    const orders = await Order.find({ user: userId });
    const orderItemIds = orders.flatMap((order) => order.orderItems);

    await Order.deleteMany({ user: userId });
    await OrderItem.deleteMany({ _id: { $in: orderItemIds }});
    await CartProduct.deleteMany({ _id: { $in: user.cart }});
    await User.findByIdAndUpdate(userId, { $pull: { cart: { $exists: true } }});
    await Token.deleteOne({ userId: userId });
    await User.deleteOne({ _id: userId });

    return res.status(204).end();
  } catch (error) {
    return res.status(500).json({ error: 'Could not count users.' });
  }
};