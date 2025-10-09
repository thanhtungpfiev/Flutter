/*
 * *****************************************************************************
 * * \author Dao Thanh Tung (MS/EAE1-BST) - thanhtungpfiev@gmail.com
 * *
 * * \date Thu Oct 09 2025
 * *
 * * \copyright 2025 - thanhtungpfiev@gmail.com. All rights reserved.
 * *
 * * \filename admin_categories.js
 * *
 * * \brief
 * *
 * *
 * *****************************************************************************
 */
const media_helper = require("../helpers/media_helper");
const util = require("util");

const { Category } = require("../models/category");

exports.createCategory = async (req, res) => {
  try {
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
    req.body["image"] = `${req.protocol}://${req.get("host")}/${image.path}`;
    let category = new Category(req.body);
    category = await category.save();
    if (!category) {
      return res.status(500).json({ message: "Category cannot be created" });
    }
    return res
      .status(201)
      .json({ message: "Category created successfully", category });
  } catch (error) {
    console.error("Error adding category:", error);
    return res.status(500).json({ type: error.name, message: error.message });
  }
};

exports.deleteCategoryById = async (req, res) => {
  try {
    const category = await Category.findById(req.params.id);
    if (!category) {
      return res.status(404).json({ message: "Category not found" });
    }
    category.markedForDeletion = true;
    await category.save();
    return res.status(204).end();
  } catch (error) {
    console.error("Error deleting category:", error);
    return res.status(500).json({ type: error.name, message: error.message });
  }
};
