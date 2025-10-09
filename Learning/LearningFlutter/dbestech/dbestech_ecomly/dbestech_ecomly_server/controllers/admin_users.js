/*
 * *****************************************************************************
 * * \author Dao Thanh Tung (MS/EAE1-BST) - thanhtungpfiev@gmail.com
 * *
 * * \date Thu Oct 09 2025
 * *
 * * \copyright 2025 - thanhtungpfiev@gmail.com. All rights reserved.
 * *
 * * \filename admin_users.js
 * *
 * * \brief
 * *
 * *
 * *****************************************************************************
 */

const { User } = require("../models/user");
const { Order } = require("../models/order");
const { OrderItem } = require("../models/order_item");
const { CartProduct } = require("../models/cart_product");
const { Token } = require("../models/token");

exports.getUserCount = async (req, res) => {
  try {
    const userCount = await User.countDocuments();
    if (!userCount) {
      return res.status(500).json({ message: "Could not count users." });
    }
    res.status(200).json({ userCount });
  } catch (error) {
    console.error("Error fetching user count:", error);
    res.status(500).json({ error: "Internal Server Error" });
  }
};

exports.deleteUserById = async (req, res) => {
  try {
    const userId = req.params.id;
    const user = User.findById(userId);
    if (!user) {
      return res.status(404).json({ message: "User not found." });
    }

    const orders = await Order.find({ user: userId });
    const orderItemIds = orders.flatMap((order) => order.orderItems);
    await OrderItem.deleteMany({ _id: { $in: orderItemIds } });
    await Order.deleteMany({ user: userId });
    await CartProduct.deleteMany({ _id: { $in: user.cart } });
    await User.findByIdAndUpdate(userId, {
      $pull: { cart: { $exists: true } },
    });
    await Token.deleteOne({ userId: userId });
    await User.deleteOne({ _id: userId });
    return res.status(204).end();
  } catch (error) {
    console.error("Error deleting user:", error);
    return res.status(500).json({ error: "Internal Server Error" });
  }
};
