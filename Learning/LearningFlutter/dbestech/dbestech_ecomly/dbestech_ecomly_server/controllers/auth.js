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
const jwt = require("jsonwebtoken");
require("dotenv").config();
const env = process.env;

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

exports.login = async (req, res) => {
  const { email, password } = req.body;

  try {
    const user = await User.findOne({ email });
    if (!user) {
      return res
        .status(404)
        .json({ type: "Auth Error", message: "User not found" });
    }

    const isPasswordValid = bcrypt.compareSync(password, user.passwordHash);
    if (!isPasswordValid) {
      return res
        .status(401)
        .json({ type: "Auth Error", message: "Invalid password" });
    }

    const accessToken = jwt.sign(
      { userId: user._id, isAdmin: user.isAdmin },
      env.JWT_ACCESS_TOKEN_SECRET,
      {
        expiresIn: "1h",
      }
    );
    const refreshToken = jwt.sign(
      { userId: user._id, isAdmin: user.isAdmin },
      env.JWT_REFRESH_TOKEN_SECRET,
      {
        expiresIn: "30d",
      }
    );

    const token = await Token.findOne({ userId: user._id });
    if (token) await Token.deleteOne({ userId: user._id });
    await new Token({ userId: user._id, refreshToken, accessToken }).save();

    return res
      .status(200)
      .json({ message: "Login successful", user, accessToken, refreshToken });
  } catch (error) {
    return res.status(500).json({ type: error.name, message: error.message });
  }
};
