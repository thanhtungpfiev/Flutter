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
const express = require("express");
const router = express.Router();

const authController = require("../controllers/auth");

const { body } = require("express-validator");

const validateUser = [
  body("name").notEmpty().withMessage("Name is required"),
  body("email").isEmail().withMessage("Valid email is required"),
  body("password")
    .isLength({ min: 8 })
    .withMessage("Password must be at least 8 characters long")
    .isStrongPassword()
    .withMessage(
      "Password must include uppercase, lowercase, number, and symbol"
    ),
  body("phone")
    .notEmpty()
    .withMessage("Phone number is required")
    .isMobilePhone()
    .withMessage("Valid phone number is required"),
];

router.post("/register", validateUser, authController.register);

router.post("/login", authController.login);

router.post("/verify-token", authController.verifyToken);

module.exports = router;
