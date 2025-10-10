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

const { populate } = require("dotenv");
const { Order } = require("../models/order");
const { OrderItem } = require("../models/order_item");

exports.getAllOrders = async (req, res) => {
  try {
    const orders = await Order.find()
      .select("-statusHistory")
      .populate("user", "name email")
      .sort({ dateOrdered: -1 })
      .populate({
        path: "orderItems",
        populate: {
          path: "product",
          select: "name",
          populate: {
            path: "category",
            select: "name",
          },
        },
      });
    if (!orders) {
      return res.status(404).json({ message: "No orders found" });
    }
    return res.status(200).json({ orders });
  } catch (error) {
    console.error("Error fetching orders:", error);
    return res.status(500).json({ type: error.name, message: error.message });
  }
};

exports.getOrdersCount = async (req, res) => {
  try {
    const count = await Order.countDocuments();
    if (!count) {
      return res.status(404).json({ message: "No orders found" });
    }
    return res.status(200).json({ count });
  } catch (error) {
    console.error("Error fetching orders count:", error);
    return res.status(500).json({ type: error.name, message: error.message });
  }
};

exports.updateOrderStatusById = async (req, res) => {
  try {
    const orderId = req.params.id;
    const newStatus = req.body.status;

    const order = await Order.findById(orderId);
    if (!order) {
      return res.status(404).json({ message: "Order not found" });
    }
    if (!order.statusHistory.includes(newStatus)) {
      order.statusHistory.push(newStatus);
    }
    order.status = newStatus;
    order = await order.save();
    return res
      .status(200)
      .json({ message: "Order status updated successfully", order });
  } catch (error) {
    console.error("Error updating order status:", error);
    return res.status(500).json({ type: error.name, message: error.message });
  }
};

exports.deleteOrderById = async (req, res) => {
  try {
    const orderId = req.params.id;
    const order = await Order.findByIdAndDelete(orderId);
    if (!order) {
      return res.status(404).json({ message: "Order not found" });
    }
    for (const orderItemId of order.orderItems) {
      await OrderItem.findByIdAndDelete(orderItemId);
    }
    return res.status(204).end();
  } catch (error) {
    console.error("Error deleting order:", error);
    return res.status(500).json({ type: error.name, message: error.message });
  }
};
