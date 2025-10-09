/*
 * *****************************************************************************
 * * \author Dao Thanh Tung (MS/EAE1-BST) - thanhtungpfiev@gmail.com
 * *
 * * \date Thu Oct 09 2025
 * *
 * * \copyright 2025 - thanhtungpfiev@gmail.com. All rights reserved.
 * *
 * * \filename admin_orders.js
 * *
 * * \brief
 * *
 * *
 * *****************************************************************************
 */

const { Order } = require("../models/order");

exports.getAllOrders = async (req, res) => {
  try {
    const orders = await Order.find()
      .select("-statusHistory")
      .sort({ dateOrdered: -1 });
    if (!orders) {
      return res.status(404).json({ message: "No orders found" });
    }
    return res.status(200).json({ orders });
  } catch (error) {
    console.error("Error fetching orders:", error);
    return res.status(500).json({ message: "Internal server error" });
  }
};

exports.getOrdersCount = async (req, res) => {};

exports.updateOrderStatusById = async (req, res) => {};
