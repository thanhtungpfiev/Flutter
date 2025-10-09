/*
 * *****************************************************************************
 * * \author Dao Thanh Tung - thanhtungpfiev@gmail.com
 * *
 * * \date Thu Oct 09 2025
 * *
 * * \copyright 2025 - thanhtungpfiev@gmail.com. All rights reserved.
 * *
 * * \filename admin_products.js
 * *
 * * \brief
 * *
 * *
 * *****************************************************************************
 */

const { Product } = require("../models/product");
const { Category } = require("../models/category");
const media_helper = require("../helpers/media_helper");
const util = require("util");

exports.getProductCount = async (req, res) => {
  try {
    const productCount = await Product.countDocuments();
    if (!productCount) {
      return res.status(500).json({ message: "Could not count products." });
    }
    res.status(200).json({ productCount });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

exports.createProduct = async (req, res) => {
  try {
    const uploadImages = util.promisify(
      media_helper.upload.fields([
        { name: "image", maxCount: 1 },
        { name: "images", maxCount: 10 },
      ])
    );

    try {
      await uploadImages(req, res);
    } catch (uploadError) {
      return res
        .status(400)
        .json({ message: "Image upload failed", error: uploadError.message });
    }

    const {
      name,
      description,
      price,
      color,
      sizes,
      category,
      genderAgeCategory,
      countInStock,
    } = req.body;

    // Validate required fields
    if (!name || !description || !price || !category || !countInStock) {
      return res.status(400).json({
        message:
          "Missing required fields: name, description, price, category, countInStock",
      });
    }

    // Validate category exists
    const categoryExists = await Category.findById(category);
    if (!categoryExists) {
      return res.status(400).json({ message: "Invalid category ID" });
    }

    // Handle image upload
    let imageUrl = null;
    let imagesUrls = [];

    if (req.files && req.files.image) {
      imageUrl = `${req.protocol}://${req.get("host")}/public/uploads/${
        req.files.image[0].filename
      }`;
    }

    if (req.files && req.files.images) {
      imagesUrls = req.files.images.map(
        (file) =>
          `${req.protocol}://${req.get("host")}/public/uploads/${file.filename}`
      );
    }

    const product = new Product({
      name,
      description,
      price: parseFloat(price),
      color: color ? JSON.parse(color) : [],
      image: imageUrl,
      images: imagesUrls,
      sizes: sizes ? JSON.parse(sizes) : [],
      category,
      genderAgeCategory,
      countInStock: parseInt(countInStock),
    });

    const savedProduct = await product.save();
    res.status(201).json(savedProduct);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

exports.updateProductById = async (req, res) => {
  try {
    const { id } = req.params;

    // Validate product exists
    const existingProduct = await Product.findById(id);
    if (!existingProduct) {
      return res.status(404).json({ message: "Product not found" });
    }

    const uploadImages = util.promisify(
      media_helper.upload.fields([
        { name: "image", maxCount: 1 },
        { name: "images", maxCount: 10 },
      ])
    );

    try {
      await uploadImages(req, res);
    } catch (uploadError) {
      // Continue without new images if upload fails
    }

    const updateData = { ...req.body };

    // Handle image updates
    if (req.files && req.files.image) {
      updateData.image = `${req.protocol}://${req.get("host")}/public/uploads/${
        req.files.image[0].filename
      }`;
    }

    if (req.files && req.files.images) {
      updateData.images = req.files.images.map(
        (file) =>
          `${req.protocol}://${req.get("host")}/public/uploads/${file.filename}`
      );
    }

    // Parse arrays if they're strings
    if (updateData.color && typeof updateData.color === "string") {
      updateData.color = JSON.parse(updateData.color);
    }
    if (updateData.sizes && typeof updateData.sizes === "string") {
      updateData.sizes = JSON.parse(updateData.sizes);
    }

    // Validate category if provided
    if (updateData.category) {
      const categoryExists = await Category.findById(updateData.category);
      if (!categoryExists) {
        return res.status(400).json({ message: "Invalid category ID" });
      }
    }

    const updatedProduct = await Product.findByIdAndUpdate(id, updateData, {
      new: true,
      runValidators: true,
    });

    res.status(200).json(updatedProduct);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

exports.deleteProductById = async (req, res) => {
  try {
    const { id } = req.params;

    const deletedProduct = await Product.findByIdAndDelete(id);
    if (!deletedProduct) {
      return res.status(404).json({ message: "Product not found" });
    }

    res.status(200).json({ message: "Product deleted successfully" });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

exports.deleteProductImagesById = async (req, res) => {
  try {
    const { id } = req.params;

    const product = await Product.findById(id);
    if (!product) {
      return res.status(404).json({ message: "Product not found" });
    }

    // Clear the images array
    product.images = [];
    await product.save();

    res.status(200).json({ message: "Product images deleted successfully" });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};
