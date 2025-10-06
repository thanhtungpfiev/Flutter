/*
 * *****************************************************************************
 * * \author Dao Thanh Tung - thanhtungpfiev@gmail.com
 * *
 * * \date Mon Oct 06 2025
 * *
 * * \copyright 2025 - thanhtungpfiev@gmail.com. All rights reserved.
 * *
 * * \filename order_item.js
 * *
 * * \brief
 * *
 * *
 * *****************************************************************************
 */

const mongoose = require("mongoose");

const orderItemSchema = new mongoose.Schema({
  product: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "Product",
    required: true,
  },
  productName: { type: String, required: true },
  productImage: { type: String, required: true },
  productPrice: { type: Number, required: true, min: 0 },
  quantity: { type: Number, required: true, min: 1 },
  selectedSize: String,
  selectedColor: String,
  price: { type: Number, required: true, min: 0 },
});

orderItemSchema.set("toObject", { virtuals: true });
orderItemSchema.set("toJSON", { virtuals: true });

exports.OrderItem = mongoose.model("OrderItem", orderItemSchema);
