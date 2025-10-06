/*
 * *****************************************************************************
 * * \author Dao Thanh Tung - thanhtungpfiev@gmail.com
 * *
 * * \date Mon Oct 06 2025
 * *
 * * \copyright 2025 - thanhtungpfiev@gmail.com. All rights reserved.
 * *
 * * \filename order.js
 * *
 * * \brief
 * *
 * *
 * *****************************************************************************
 */

const mongoose = require("mongoose");
const { use } = require("react");

const orderSchema = new mongoose.Schema({
  orderItems: [
    { type: mongoose.Schema.Types.ObjectId, ref: "OrderItem", required: true },
  ],
  shippingAddress: { type: String, required: true },
  city: { type: String, required: true },
  postalCode: { type: String, required: true },
  country: { type: String, required: true },
  phone: { type: String, required: true },
  paymentId: String,
  status: {
    type: String,
    enum: [
      "pending",
      "processed",
      "shipped",
      "out-for-delivery",
      "delivered",
      "cancelled",
      "on-hold",
      "expired",
    ],
    default: "pending",
  },
  statusHistory: {
    type: [String],
    enum: [
      "pending",
      "processed",
      "shipped",
      "out-for-delivery",
      "delivered",
      "cancelled",
      "on-hold",
      "expired",
    ],
    default: ["pending"],
  },
  totalPrice: { type: Number },
  user: { type: mongoose.Schema.Types.ObjectId, ref: "User", required: true },
  dateOrdered: { type: Date, default: Date.now },
});

orderSchema.set("toObject", { virtuals: true });
orderSchema.set("toJSON", { virtuals: true });

exports.Order = mongoose.model("Order", orderSchema);
