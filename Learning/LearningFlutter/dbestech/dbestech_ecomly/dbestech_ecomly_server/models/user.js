/*
 * *****************************************************************************
 * * \author Dao Thanh Tung (MS/EAE1-BST) - thanhtungpfiev@gmail.com
 * *
 * * \date Mon Sep 22 2025
 * *
 * * \copyright 2025 - thanhtungpfiev@gmail.com. All rights reserved.
 * *
 * * \filename user.js
 * *
 * * \brief
 * *
 * *
 * *****************************************************************************
 */

const mongoose = require("mongoose");

const userSchema = new mongoose.Schema({
  name: { type: String, required: true, trim: true },
  email: { type: String, required: true, trim: true, unique: true },
  passwordHash: { type: String, required: true },
  street: String,
  apartment: String,
  city: String,
  postalCode: String,
  country: String,
  phone: { type: String, required: true, trim: true },
  isAdmin: { type: Boolean, default: false },
  resetPasswordOtp: { type: Number, default: null },
  resetPasswordOtpExpiry: { type: Date, default: null },
  wishlist: [
    {
      productId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Product",
        required: true,
      },
      productName: { type: String, required: true },
      productImage: { type: String, required: true },
      productPrice: { type: Number, required: true },
    },
  ],
});

userSchema.set("toObject", { virtuals: true });
userSchema.set("toJSON", { virtuals: true });

exports.User = mongoose.model("User", userSchema);
