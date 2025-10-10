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
const multer = require("multer");
const { default: mongoose } = require("mongoose");

exports.getProductsCount = async (req, res) => {
  try {
    const productCount = await Product.countDocuments();
    if (!productCount) {
      return res.status(500).json({ message: "Could not count products." });
    }
    return res.status(200).json({ productCount });
  } catch (error) {
    return res.status(500).json({ message: error.message });
  }
};

exports.getAllProducts = async (req, res) => {
  try {
    const page = req.query.page ? parseInt(req.query.page) : 1;
    const limit = req.query.limit ? parseInt(req.query.limit) : 10;
    const products = await Product.find()
      .select("-reviews -rating")
      .skip((page - 1) * limit)
      .limit(limit);
    if (!products) {
      return res.status(404).json({ message: "Could not retrieve products." });
    }
    return res.status(200).json(products);
  } catch (error) {
    return res.status(500).json({ message: error.message });
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
      console.error("Image upload error:", uploadError);
      return res.status(500).json({
        type: uploadError.code,
        message: `${uploadError.message} ${uploadError.field}`,
        storageErrors: uploadError.storageErrors,
      });
    }

    const category = await Category.findById(req.body.category);
    if (!category) {
      return res.status(404).json({ message: "Invalid category ID" });
    }
    if (category.markedForDeletion) {
      return res
        .status(404)
        .json({ message: "Category is marked for deletion" });
    }
    const image = req.files["image"][0];
    if (!image) {
      return res.status(404).json({ message: "Main image is required" });
    }
    req.body["image"] = `${req.protocol}://${req.get("host")}/${image.path}`;
    const gallery = req.files["images"];
    const imagePaths = [];
    if (gallery) {
      for (const image of gallery) {
        const imagePath = `${req.protocol}://${req.get("host")}/${image.path}`;
        imagePaths.push(imagePath);
      }
    }
    if (imagePaths.length > 0) {
      req.body["images"] = imagePaths;
    }
    const product = await new Product(req.body).save();
    if (!product) {
      return res.status(500).json({ message: "Could not create product" });
    }
    return res.status(201).json(product);
  } catch (error) {
    console.error("Error creating product:", error);
    if (error instanceof multer.MulterError) {
      return res.status(error.code).json({ message: error.message });
    }
    return res.status(500).json({ message: error.message });
  }
};

exports.updateProductById = async (req, res) => {
  try {
    if (
      !mongoose.isValidObjectId(req.params.id) ||
      !(await Product.findById(req.params.id))
    ) {
      return res.status(404).json({ message: "Invalid product ID" });
    }
    if (req.body.category) {
      const category = await Category.findById(req.body.category);
      if (!category) {
        return res.status(404).json({ message: "Invalid category ID" });
      }
      if (category.markedForDeletion) {
        return res
          .status(404)
          .json({ message: "Category is marked for deletion" });
      }
      const product = await Product.findById(req.params.id);
      if (req.body.images) {
        const limit = 10 - product.images.length;
        const uploadImages = util.promisify(
          media_helper.upload.fields([
            { name: "image", maxCount: 1 },
            { name: "images", maxCount: limit },
          ])
        );
        try {
          await uploadImages(req, res);
        } catch (uploadError) {
          console.error("Image upload error:", uploadError);
          return res.status(500).json({
            type: uploadError.code,
            message: `${uploadError.message} ${uploadError.field}`,
            storageErrors: uploadError.storageErrors,
          });
        }
        const imageFiles = req.files["images"];
        const updateGallery = imageFiles && imageFiles.length > 0;
        if (updateGallery) {
          const imagePaths = [];
          for (const image of uploadImages) {
            const imagePath = `${req.protocol}://${req.get("host")}/${
              image.path
            }`;
            imagePaths.push(imagePath);
          }
          req.body["images"] = [...product.images, ...imagePaths];
        }
      }
      if (req.body.image) {
        const uploadImage = util.promisify(
          media_helper.upload.fields({
            name: "image",
            maxCount: 1,
          })
        );
        try {
          await uploadImage(req, res);
        } catch (error) {
          console.error("Error uploading image:", error);
          return res.status(500).json({
            type: error.code,
            message: `${error.message}{${error.field}}`,
            storageErrors: error.storageErrors,
          });
        }
        const image = req.files["image"][0];
        if (!image) {
          return res.status(404).json({ message: "Image file is required" });
        }
        req.body["image"] = `${req.protocol}://${req.get("host")}/${
          image.path
        }`;
      }
    }
    const updatedProduct = await Product.findByIdAndUpdate(
      req.params.id,
      req.body,
      { new: true }
    );
    if (!updatedProduct) {
      return res.status(404).json({ message: "Could not update product" });
    }
    return res.status(200).json(updatedProduct);
  } catch (error) {
    return res.status(500).json({ message: error.message });
  }
};

exports.deleteProductImagesById = async (req, res) => {
  try {
    const productId = req.params.id;
    const { deletedImageUrls } = req.body;
    if (
      !mongoose.isValidObjectId(productId) ||
      !Array.isArray(deletedImageUrls)
    ) {
      return res.status(400).json({ message: "Invalid request data" });
    }
    await media_helper.deleteImages(deletedImageUrls);
    const product = await Product.findById(productId);
    if (!product) {
      return res.status(404).json({ message: "Product not found" });
    }
    product.images = product.images.filter(
      (img) => !deletedImageUrls.includes(img)
    );
    await product.save();
    return res.status(204).end();
  } catch (error) {
    console.error("Error deleting product images:", error);
    if (error.code === "ENOENT") {
      return res.status(404).json({ message: "One or more images not found" });
    }
    return res.status(500).json({ message: error.message });
  }
};

exports.deleteProductById = async (req, res) => {
  try {
    const productId = req.params.id;
    if (!mongoose.isValidObjectId(productId)) {
      return res.status(404).json({ message: "Invalid product ID" });
    }
    const product = await Product.findById(productId);
    if (!product) {
      return res.status(404).json({ message: "Product not found" });
    }
    await media_helper.deleteImages([
      product.image,
      ...product.images,
      "ENOENT",
    ]);
    await Review.deleteMany({ _id: { $in: product.reviews } });
    await Product.findByIdAndDelete(productId);
    return res.status(204).end();
  } catch (error) {
    console.error("Error deleting product:", error);
    return res.status(500).json({ message: error.message });
  }
};
