/*
 * *****************************************************************************
 * * \author Dao Thanh Tung (MS/EAE1-BST) - thanhtungpfiev@gmail.com
 * *
 * * \date Mon Sep 22 2025
 * *
 * * \copyright 2025 - thanhtungpfiev@gmail.com. All rights reserved.
 * *
 * * \filename auth.js
 * *
 * * \brief
 * *
 * *
 * *****************************************************************************
 */

const { validationResult } = require("express-validator");
const { User } = require("../models/user");
const bcrypt = require("bcryptjs");

exports.register = async (req, res) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    const errorMessages = errors.array().map((error) => ({
      field: error.path,
      message: error.msg,
    }));
    return res.status(400).json({ errors: errorMessages });
  }
  try {
    let user = new User({
      ...req.body,
      passwordHash: bcrypt.hashSync(req.body.password, 8),
    });

    user = await user.save();

    if (!user) {
      return res.status(500).json({
        type: "Internal Server Error",
        message: "User cannot be created",
      });
    }
    return res.status(201).json({ message: "User created successfully", user });
  } catch (error) {
    if (error.message.includes("email_1 dup key")) {
      return res
        .status(409)
        .json({ type: "Auth Error", message: "Email already exists" });
    }
    return res.status(500).json({ type: error.name, message: error.message });
  }
};
