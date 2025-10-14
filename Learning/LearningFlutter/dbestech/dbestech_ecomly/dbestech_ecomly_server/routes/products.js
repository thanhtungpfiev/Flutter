/*
 * *****************************************************************************
 * * \author Dao Thanh Tung (MS/EAE1-BST) - thanhtungpfiev@gmail.com
 * *
 * * \date Fri Oct 10 2025
 * *
 * * \copyright 2025 - thanhtungpfiev@gmail.com. All rights reserved.
 * *
 * * \filename products.js
 * *
 * * \brief
 * *
 * *
 * *****************************************************************************
 */
const express = require("express");
const router = express.Router();

const productsController = require("../controllers/products");
const reviewsController = require("../controllers/reviews");

router.get("/", productsController.getProducts);
router.get("/search", productsController.searchProducts);
router.get("/:id", productsController.getProductById);
router.post("/:id/reviews", reviewsController.addProductReview);
router.get("/:id/reviews", reviewsController.getProductReviews);

module.exports = router;
