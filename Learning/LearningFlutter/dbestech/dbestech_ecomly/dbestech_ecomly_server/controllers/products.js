/*
 * *****************************************************************************
 * * \author Dao Thanh Tung (MS/EAE1-BST) - thanhtungpfiev@gmail.com
 * *
 * * \date Fri Oct 10 2025
 * *
 * * \copyright 2025 - thanhtungpfiev@gmail.com. All rights reserved.
 * *
 * * \filename products.js
 * *
 * * \brief
 * *
 * *
 * *****************************************************************************
 */
const { Product } = require("../models/product");

exports.getProducts = async (req, res) => {
  try {
    const page = parseInt(req.query.page) || 1;
    const pageSize = parseInt(req.query.pageSize) || 10;
    let product;
    if (req.query.criteria) {
      let query = {};
      if (req.query.category) {
        query["category"] = req.query.category;
      }
      switch (req.query.criteria) {
        case "newArrivals": {
          const twoWeeksAgo = new Date();
          twoWeeksAgo.setDate(twoWeeksAgo.getDate() - 14);
          query["createdAt"] = { $gte: twoWeeksAgo };
          break;
        }
        case "popular": {
          query["rating"] = { $gte: 4.5 };
          break;
        }
        default:
          break;
      }
      product = await Product.find(query)
        .select("-images -reviews -size")
        .sort({ createdAt: -1 })
        .skip((page - 1) * pageSize)
        .limit(pageSize);
    } else if (req.query.category) {
      product = await Product.find({ category: req.query.category })
        .select("-images -reviews -size")
        .sort({ createdAt: -1 })
        .skip((page - 1) * pageSize)
        .limit(pageSize);
    } else {
      products = await Product.find()
        .select("-images -reviews -size")
        .sort({ createdAt: -1 })
        .skip((page - 1) * pageSize)
        .limit(pageSize);
    }
    if (!products) {
      return res.status(404).json({ message: "No products found" });
    }
    return res.status(200).json(products);
  } catch (error) {
    console.error("Error fetching products:", error);
    return res.status(500).json({ type: error.name, message: error.message });
  }
};
exports.searchProducts = async (req, res) => {
  try {
    const searchTerm = req.query.q;
    const page = parseInt(req.query.page) || 1;
    const pageSize = parseInt(req.query.pageSize) || 10;
    let query = {};
    if (req.query.category) {
      query = { category: req.query.category };
      if (req.query.genderAgeCategory) {
        query["genderAgeCategory"] = req.query.genderAgeCategory.toLowerCase();
      }
    } else if (req.query.genderAgeCategory) {
      query = { genderAgeCategory: req.query.genderAgeCategory.toLowerCase() };
    }
    if (searchTerm) {
      query = {
        ...query,
        $text: {
          $search: searchTerm,
          $language: "english",
          $caseSensitive: false,
        },
      };
    }
    const searchResults = await Product.find(query)
      .select("-images -reviews -size")
      .skip((page - 1) * pageSize)
      .limit(pageSize);
    return res.status(200).json(searchResults);
  } catch (error) {
    console.error("Error searching products:", error);
    return res.status(500).json({ type: error.name, message: error.message });
  }
};
exports.getProductById = async (req, res) => {
  try {
    const product = await Product.findById(req.params.id).select("-reviews");
    if (!product) {
      return res.status(404).json({ message: "Product not found" });
    }
    return res.status(200).json(product);
  } catch (error) {
    console.error("Error fetching product:", error);
    return res.status(500).json({ type: error.name, message: error.message });
  }
};
exports.addProductReview = async (req, res) => {
  try {
  } catch (error) {}
};
exports.getProductReviews = async (req, res) => {
  try {
  } catch (error) {}
};
