/*
 * *****************************************************************************
 * * \author Dao Thanh Tung - thanhtungpfiev@gmail.com
 * *
 * * \date Fri Oct 10 2025
 * *
 * * \copyright 2025 - thanhtungpfiev@gmail.com. All rights reserved.
 * *
 * * \filename review.js
 * *
 * * \brief Mongoose model for product reviews
 * *
 * *****************************************************************************
 */

const mongoose = require("mongoose");

const reviewSchema = new mongoose.Schema({
  user: { type: mongoose.Schema.Types.ObjectId, ref: "User", required: true },
  product: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "Product",
    required: true,
  },
  rating: { type: Number, required: true, min: 0, max: 5 },
  title: { type: String, trim: true },
  comment: { type: String, trim: true },
  datePosted: { type: Date, default: Date.now },
});

// Prevent a user from adding more than one review per product
reviewSchema.index({ user: 1, product: 1 }, { unique: true });

reviewSchema.set("toObject", { virtuals: true });
reviewSchema.set("toJSON", { virtuals: true });

exports.Review = mongoose.model("Review", reviewSchema);
