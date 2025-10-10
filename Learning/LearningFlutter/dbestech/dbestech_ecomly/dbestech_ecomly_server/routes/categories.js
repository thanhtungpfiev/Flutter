/*
 * *****************************************************************************
 * * \author Dao Thanh Tung (MS/EAE1-BST) - thanhtungpfiev@gmail.com
 * *
 * * \date Fri Oct 10 2025
 * *
 * * \copyright 2025 - thanhtungpfiev@gmail.com. All rights reserved.
 * *
 * * \filename categories.js
 * *
 * * \brief
 * *
 * *
 * *****************************************************************************
 */
const express = require("express");
const router = express.Router();

const categoriesController = require("../controllers/categories");

router.get("/", categoriesController.getCategories);
router.get("/:id", categoriesController.getCategoryById);

module.exports = router;
