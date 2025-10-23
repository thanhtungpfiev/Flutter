/*
 * *****************************************************************************
 * * \author Dao Thanh Tung (MS/EAE1-BST) - thanhtungpfiev@gmail.com
 * *
 * * \date Tue Oct 14 2025
 * *
 * * \copyright 2025 - thanhtungpfiev@gmail.com. All rights reserved.
 * *
 * * \filename wishlist.js
 * *
 * * \brief
 * *
 * *
 * *****************************************************************************
 */
const { User } = require("../models/user");
const { Product } = require("../models/product");
const { default: mongoose } = require("mongoose");

exports.getUserWishlist = async (req, res) => {
  try {
    const user = await User.findById(req.params.id);
    if (!user) {
      return res.status(404).json({ message: "User not found!" });
    }
    const wishlist = [];
    for (const wishProduct of user.wishlist) {
      const product = await Product.findById(wishProduct.productId);
      if (!product) {
        wishlist.push({
          ...wishProduct,
          productExists: false,
          productOutOfStock: false,
        });
      } else if (product.countInStock < 1) {
        wishlist.push({
          ...wishProduct,
          productExists: true,
          productOutOfStock: true,
        });
      } else {
        wishlist.push({
          productId: product._id,
          productImage: product.image,
          productPrice: product.price,
          productName: product.name,
          productExists: true,
          productOutOfStock: false,
        });
      }
    }
    return res.status(200).json(wishlist);
  } catch (error) {
    console.error("Error getting user wishlist:", error);
    return res.status(500).json({ type: error.name, message: error.message });
  }
};

exports.addToWishlist = async (req, res) => {
  try {
    const user = await User.findById(req.params.id);
    if (!user) {
      return res.status(404).json({ message: "User not found!" });
    }
    const product = await Product.findById(req.body.productId);
    if (!product) {
      return res.status(404).json({ message: "Product not found!" });
    }
    const productAlreadyInWishlist = user.wishlist.find((wish) =>
      wish.productId.equals(
        new mongoose.Schema.Types.ObjectId(req.body.productId)
      )
    );
    if (productAlreadyInWishlist) {
      return res.status(409).json({ message: "Product already in wishlist!" });
    }
    user.wishlist.push({
      productId: req.body.productId,
      productImage: product.image,
      productName: product.name,
      productPrice: product.price,
    });
    await user.save();
    return res.status(201).end();
  } catch (error) {
    console.error("Error adding to wishlist:", error);
    return res.status(500).json({ type: error.name, message: error.message });
  }
};

exports.removeFromWishlist = async (req, res) => {
  try {
    const userId = req.params.id;
    const productId = req.params.productId;
    const user = await User.findById(userId);
    if (!user) {
      return res.status(404).json({ message: "User not found!" });
    }
    const index = user.wishlist.findIndex((wish) =>
      wish.productId.equals(new mongoose.Schema.Types.ObjectId(productId))
    );
    if (index === -1) {
      return res
        .status(404)
        .json({ message: "Product not found in wishlist!" });
    }
    user.wishlist.splice(index, 1);
    await user.save();
    return res.status(204).end();
  } catch (error) {
    console.error("Error removing from wishlist:", error);
    return res.status(500).json({ type: error.name, message: error.message });
  }
};
