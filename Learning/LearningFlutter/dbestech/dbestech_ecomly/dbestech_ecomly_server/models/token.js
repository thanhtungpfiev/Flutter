/*
 * *****************************************************************************
 * * \author Dao Thanh Tung - thanhtungpfiev@gmail.com
 * *
 * * \date Tue Sep 23 2025
 * *
 * * \copyright 2025 - thanhtungpfiev@gmail.com. All rights reserved.
 * *
 * * \filename token.js
 * *
 * * \brief
 * *
 * *
 * *****************************************************************************
 */
const mongoose = require("mongoose");

const tokenSchema = new mongoose.Schema({
  userId: {
    type: mongoose.Schema.Types.ObjectId,
    required: true,
    ref: "User",
  },
  refreshToken: { type: String, required: true },
  accessToken: String,
  createdAt: { type: Date, default: Date.now, expires: 3600 }, // Token expires after 1 hour
});

const Token = mongoose.model("Token", tokenSchema);
module.exports = { Token };
