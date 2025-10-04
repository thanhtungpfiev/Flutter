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
const express = require("express");
const router = express.Router();

const usersController = require("../controllers/users");

router.get("/", usersController.getUsers);
router.get("/:id", usersController.getUserById);
router.put("/:id", usersController.updateUser);

module.exports = router;
