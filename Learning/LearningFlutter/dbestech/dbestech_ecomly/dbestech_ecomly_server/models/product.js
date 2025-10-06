/*
 * *****************************************************************************
 * * \author Dao Thanh Tung - thanhtungpfiev@gmail.com
 * *
 * * \date Mon Oct 06 2025
 * *
 * * \copyright 2025 - thanhtungpfiev@gmail.com. All rights reserved.
 * *
 * * \filename product.js
 * *
 * * \brief
 * *
 * *
 * *****************************************************************************
 */

const mongoose = require("mongoose");

const productSchema = new mongoose.Schema({
  name: { type: String, required: true, trim: true },
  description: { type: String, required: true },
  price: { type: Number, required: true, min: 0 },
  rating: { type: Number, default: 0, min: 0, max: 5 },
  color: [{ type: String }],
  image: { type: String, required: true },
  images: [{ type: String }],
  reviews: [{ type: mongoose.Schema.Types.ObjectId, ref: "Review" }],
  numberOfReviews: { type: Number, default: 0 },
  sizes: [{ type: String }],
  category: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "Category",
    required: true,
  },
  genderAgeCategory: { type: String, enum: ["men", "women", "unisex", "kids"] },
  countInStock: { type: Number, required: true, min: 0, max: 1000 },
  dateAdded: { type: Date, default: Date.now },
});

// pre-save hook
productSchema.pre("save", async function (next) {
  if (this.rating < 0) this.rating = 0;
  if (this.rating > 5) this.rating = 5;
  if (this.reviews && this.reviews.length > 0) {
    await this.populate("reviews");
    const totalRating = this.reviews.reduce(
      (acc, review) => acc + review.rating,
      0
    );
    this.numberOfReviews = this.reviews.length;
    this.rating = parseFloat(totalRating / this.reviews.length).toFixed(1);
  }
  next();
});

productSchema.index({ name: "text", description: "text" });

productSchema.set("toObject", { virtuals: true });
productSchema.set("toJSON", { virtuals: true });

exports.Product = mongoose.model("Product", productSchema);
