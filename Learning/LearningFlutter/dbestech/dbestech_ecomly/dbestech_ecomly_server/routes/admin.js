/*
 * *****************************************************************************
 * * \author Dao Thanh Tung - thanhtungpfiev@gmail.com
 * *
 * * \date Mon Oct 06 2025
 * *
 * * \copyright 2025 - thanhtungpfiev@gmail.com. All rights reserved.
 * *
 * * \filename admin.js
 * *
 * * \brief
 * *
 * *
 * *****************************************************************************
 */
const express = require("express");
const router = express.Router();

const adminController = require("../controllers/admin");

// USERS
router.get("/users/count", adminController.getUserCount);
router.delete("/users/:id", adminController.deleteUserById);

// CATEGORIES
router.post("/categories", adminController.createCategory);
router.put("/categories/:id", adminController.updateCategoryById);
router.delete("/categories/:id", adminController.deleteCategoryById);

// PRODUCTS
router.get("/products/count", adminController.getProductCount);
router.post("/products", adminController.createProduct);
router.put("/products/:id", adminController.updateProductById);
router.delete("/products/:id", adminController.deleteProductById);

// ORDERS
router.get("/orders", adminController.getAllOrders);
router.get("/orders/count", adminController.getOrderCount);
router.put("/orders/:id/status", adminController.updateOrderStatusById);
router.delete("/orders/:id", adminController.deleteOrderById);

module.exports = router;
