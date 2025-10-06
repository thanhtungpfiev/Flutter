/*
 * *****************************************************************************
 * * \author Dao Thanh Tung - thanhtungpfiev@gmail.com
 * *
 * * \date Mon Oct 06 2025
 * *
 * * \copyright 2025 - thanhtungpfiev@gmail.com. All rights reserved.
 * *
 * * \filename cart_product.js
 * *
 * * \brief
 * *
 * *
 * *****************************************************************************
 */
const mongoose = require("mongoose");

const cartProductSchema = new mongoose.Schema({
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
  reservationExpiry: {
    type: Date,
    default: () => new Date(Date.now() + 30 * 60 * 1000), // Default to 30 minutes from now
  },
  reserved: { type: Boolean, default: true },
});

cartProductSchema.set("toObject", { virtuals: true });
cartProductSchema.set("toJSON", { virtuals: true });

exports.CartProduct = mongoose.model("CartProduct", cartProductSchema);
