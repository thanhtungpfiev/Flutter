/*
 * *****************************************************************************
 * * \author Dao Thanh Tung - thanhtungpfiev@gmail.com
 * *
 * * \date Mon Oct 06 2025
 * *
 * * \copyright 2025 - thanhtungpfiev@gmail.com. All rights reserved.
 * *
 * * \filename category.js
 * *
 * * \brief
 * *
 * *
 * *****************************************************************************
 */

const mongoose = require("mongoose");

const categorySchema = new mongoose.Schema({
  name: { type: String, required: true, trim: true },
  color: { type: String, default: "#000000" },
  image: { type: String, required: true, default: "" },
  markedForDeletion: { type: Boolean, default: false },
});

categorySchema.set("toObject", { virtuals: true });
categorySchema.set("toJSON", { virtuals: true });

exports.Category = mongoose.model("Category", categorySchema);
