/*
 * *****************************************************************************
 * * \author Dao Thanh Tung (MS/EAE1-BST) - thanhtungpfiev@gmail.com
 * *
 * * \date Fri Oct 10 2025
 * *
 * * \copyright 2025 - thanhtungpfiev@gmail.com. All rights reserved.
 * *
 * * \filename reviews.js
 * *
 * * \brief
 * *
 * *
 * *****************************************************************************
 */
const { User } = require("../models/user");
const { Review } = require("../models/review");
const { Product } = require("../models/product");
const { default: mongoose } = require("mongoose");

exports.addProductReview = async (req, res) => {
  try {
    const user = await User.findById(req.body.user);
    if (!user) {
      return res.status(404).json({ message: "Invalid user!" });
    }
    const review = await new Review({
      ...req.body,
      userName: user.name,
    }).save();
    if (!review) {
      return res.status(400).json({ message: "Failed to add review!" });
    }
    let product = await Product.findById(req.params.id);
    if (!product) {
      return res.status(404).json({ message: "Product not found!" });
    }
    product.reviews.push(review._id);
    product = await product.save();
    if (!product) {
      return res
        .status(400)
        .json({ message: "Failed to add review to product!" });
    }
    return res.status(201).json({ product, review });
  } catch (error) {
    console.error("Error adding review:", error);
    return res.status(500).json({ type: error.name, message: error.message });
  }
};
exports.getProductReviews = async (req, res) => {
  const session = await mongoose.startSession();
  session.startTransaction();
  try {
    const product = await Product.findById(req.params.id);
    if (!product) {
      await session.abortTransaction();
      return res.status(404).json({ message: "Product not found!" });
    }
    const page = req.query.page || 1;
    const pageSize = 10;

    const reviews = await Review.find({ _id: { $in: product.reviews } })
      .sort({ date: -1 })
      .skip((page - 1) * pageSize)
      .limit(pageSize);

    const processedReviews = [];
    for (const review of reviews) {
      const user = await User.findById(review.user);
      if (!user) {
        processedReviews.push(review);
        continue;
      }
      let newReview;
      if (review.userName != user.name) {
        review.userName = user.name;
        newReview = await review.save({ session });
      }
      processedReviews.push(newReview ?? review);
    }

    await session.commitTransaction();
    return res.status(200).json({ processedReviews });
  } catch (error) {
    await session.abortTransaction();
    console.error("Error getting product reviews:", error);
    return res.status(500).json({ type: error.name, message: error.message });
  } finally {
    await session.endSession();
  }
};
