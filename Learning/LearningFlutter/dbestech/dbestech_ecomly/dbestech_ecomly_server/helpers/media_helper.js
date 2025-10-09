/*
 * *****************************************************************************
 * * \author Dao Thanh Tung (MS/EAE1-BST) - thanhtungpfiev@gmail.com
 * *
 * * \date Thu Oct 09 2025
 * *
 * * \copyright 2025 - thanhtungpfiev@gmail.com. All rights reserved.
 * *
 * * \filename media_helper.js
 * *
 * * \brief
 * *
 * *
 * *****************************************************************************
 */
const { unlink } = require("fs").promises;
const multer = require("multer");
const path = require("path");

const { Category } = require("../models/category");

const ALLOWED_EXTENSIONS = {
  "image/jpg": "jpg",
  "image/jpeg": "jpeg",
  "image/png": "png",
};

const storage = multer.diskStorage({
  destination: function (_, __, cb) {
    cb(null, "public/uploads");
  },
  filename: function (_, file, cb) {
    const filename = file.originalname
      .replace(" ", "-")
      .replace(".jpg", "")
      .replace(".jpeg", "")
      .replace(".png", "");
    const extension = ALLOWED_EXTENSIONS[file.mimetype];
    cb(null, `${filename}-${Date.now()}.${extension}`);
  },
});

exports.upload = multer({
  storage: storage,
  limits: { fileSize: 1024 * 1024 * 5 }, // 5 MB
  fileFilter: (_, file, cb) => {
    const isValid = ALLOWED_EXTENSIONS[file.mimetype];
    let uploadError = new Error(
      `Invalid image type\n${file.mimetype} is not allowed`
    );
    if (!isValid) return cb(uploadError);
    return cb(null, true);
  },
});

exports.updateCategory = async (req, res) => {
  try {
    const { name, icon, color } = req.body;
    const category = await Category.findByIdAndUpdate(
      req.params.id,
      {
        name,
        icon,
        color,
      },
      { new: true }
    );
    if (!category) {
      return res.status(404).json({ message: "Category not found" });
    }
    return res
      .status(200)
      .json({ message: "Category updated successfully", category });
  } catch (error) {
    console.error("Error updating category:", error);
    return res.status(500).json({ message: "Internal server error" });
  }
};

exports.deleteImages = async function (imageUrls, continueOnErrorName) {
  await Promise.all(
    imageUrls.map(async (imageUrl) => {
      const imagePath = path.resolve(
        __dirname,
        "..",
        "public",
        "uploads",
        path.basename(imageUrl)
      );
      try {
        await unlink(imagePath);
      } catch (error) {
        if (error.code === continueOnErrorName) {
          console.error(`File not found, skipping deletion: ${imagePath}`);
        } else {
          console.error(`Error deleting file ${imagePath}:`, error);
          throw error;
        }
      }
    })
  );
};
