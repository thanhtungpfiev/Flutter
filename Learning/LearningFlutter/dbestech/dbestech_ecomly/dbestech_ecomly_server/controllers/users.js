/*
 * *****************************************************************************
 * * \author Dao Thanh Tung (MS/EAE1-BST) - thanhtungpfiev@gmail.com
 * *
 * * \date Fri Oct 03 2025
 * *
 * * \copyright 2025 - thanhtungpfiev@gmail.com. All rights reserved.
 * *
 * * \filename users.js
 * *
 * * \brief
 * *
 * *
 * *****************************************************************************
 */

const e = require("cors");
const { User } = require("../models/user");

exports.getUsers = async (req, res) => {
  try {
    const users = await User.find().select("name email id isAdmin");
    if (!users) {
      return res.status(404).json({ message: "No users found" });
    }
    res.json(users);
  } catch (error) {
    res.status(500).json({ message: "Error fetching users", error });
  }
};

exports.getUserById = async (req, res) => {
  try {
    const user = await User.findById(req.params.id).select(
      "-passwordHash -resetPasswordOtp -resetPasswordOtpExpiry"
    );
    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }
    res.json(user);
  } catch (error) {
    res.status(500).json({ message: "Error fetching user", error });
  }
};

exports.updateUser = async (req, res) => {
  try {
    const { name, email, phone } = req.body;
    const user = await User.findByIdAndUpdate(
      req.params.id,
      {
        name,
        email,
        phone,
      },
      {
        new: true,
      }
    ).select("-passwordHash -resetPasswordOtp -resetPasswordOtpExpiry");
    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }
    res.json(user);
  } catch (error) {
    res.status(500).json({ message: "Error updating user", error });
  }
};
