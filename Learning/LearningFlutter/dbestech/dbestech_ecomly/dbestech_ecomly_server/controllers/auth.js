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

// External libraries
const { validationResult } = require("express-validator");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");

// Config / side-effects
require("dotenv").config();
const env = process.env;

// Internal modules
const mailSender = require("../helpers/email_sender");
const { Token } = require("../models/token");
const { User } = require("../models/user");

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

    // Remove sensitive fields before sending the user back
    const userObj = user.toObject ? user.toObject() : { ...user };
    delete userObj.passwordHash;

    return res
      .status(200)
      .json({ message: "Login successful", user: userObj, accessToken });
  } catch (error) {
    return res.status(500).json({ type: error.name, message: error.message });
  }
};

exports.verifyToken = async (req, res) => {
  try {
    let accessToken = req.headers.authorization;
    if (!accessToken) return res.json(false);
    accessToken = accessToken.replace("Bearer ", "").trim();
    const token = await Token.findOne({ accessToken });
    if (!token) return res.json(false);
    const tokenData = jwt.decode(token.refreshToken);
    const user = await User.findById(tokenData.userId);
    if (!user) return res.json(false);
    const isValid = jwt.verify(
      token.refreshToken,
      env.JWT_REFRESH_TOKEN_SECRET
    );
    if (!isValid) return res.json(false);

    return res.json(true);
  } catch (error) {
    return res.status(500).json({ type: error.name, message: error.message });
  }
};

exports.forgotPassword = async (req, res) => {
  try {
    const { email } = req.body;
    const user = await User.findOne({ email });
    if (!user) {
      return res
        .status(404)
        .json({ message: "User with that email does NOT exist!" });
    }
    const otp = Math.floor(1000 + Math.random() * 9000); // Generate a 4-digit OTP
    user.resetPasswordOtp = otp;
    user.resetPasswordOtpExpiry = Date.now() + 3600000; // OTP valid for 1 hour
    await user.save();
    const response = await mailSender.sendMail(
      email,
      "Password Reset OTP",
      `Your OTP for password reset is: ${otp}. It is valid for 1 hour.`,
      "Password reset OTP sent successfully",
      "Error sending password reset OTP"
    );
    return res.json({ message: response });
  } catch (error) {
    return res.status(500).json({ type: error.name, message: error.message });
  }
};

exports.verifyOtp = async (req, res) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    const errorMessages = errors.array().map((error) => ({
      field: error.path,
      message: error.msg,
    }));
    return res.status(400).json({ errors: errorMessages });
  }
  try {
    const { email, otp } = req.body;

    const user = await User.findOne({ email });
    if (!user) {
      return res
        .status(404)
        .json({ message: "User with that email does NOT exist!" });
    }

    if (user.resetPasswordOtp !== +otp) {
      return res.status(401).json({ message: "Invalid OTP" });
    }

    if (user.resetPasswordOtpExpiry < Date.now()) {
      return res.status(401).json({ message: "OTP has expired" });
    }

    user.resetPasswordOtp = 1;
    user.resetPasswordOtpExpiry = null;
    await user.save();

    return res.json({ message: "OTP verified successfully" });
  } catch (error) {
    return res.status(500).json({ type: error.name, message: error.message });
  }
};

exports.resetPassword = async (req, res) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    const errorMessages = errors.array().map((error) => ({
      field: error.path,
      message: error.msg,
    }));
    return res.status(400).json({ errors: errorMessages });
  }
  try {
    const { email, newPassword } = req.body;
    const user = await User.findOne({ email });
    if (!user) {
      return res
        .status(404)
        .json({ message: "User with that email does NOT exist!" });
    }

    if (user.resetPasswordOtp !== 1) {
      return res
        .status(401)
        .json({ message: "OTP not verified. Cannot reset password." });
    }

    user.passwordHash = bcrypt.hashSync(newPassword, 8);
    user.resetPasswordOtp = null;
    user.resetPasswordOtpExpiry = null;
    await user.save();

    return res.json({ message: "Password reset successfully" });
  } catch (error) {
    return res.status(500).json({ type: error.name, message: error.message });
  }
};
