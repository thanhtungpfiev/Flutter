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

const adminUsersController = require("../controllers/admin_users");
const adminCategoriesController = require("../controllers/admin_categories");
const adminProductsController = require("../controllers/admin_products");
const adminOrdersController = require("../controllers/admin_orders");

// USERS
router.get("/users/count", adminUsersController.getUserCount);
router.delete("/users/:id", adminUsersController.deleteUserById);

// CATEGORIES
router.post("/categories", adminCategoriesController.createCategory);
// router.put("/categories/:id", adminCategoriesController.updateCategoryById);
router.delete("/categories/:id", adminCategoriesController.deleteCategoryById);

// PRODUCTS
router.get("/products/count", adminProductsController.getProductCount);
router.post("/products", adminProductsController.createProduct);
router.put("/products/:id", adminProductsController.updateProductById);
router.delete("/products/:id", adminProductsController.deleteProductById);
router.delete(
  "/products/:id/images",
  adminProductsController.deleteProductImagesById
);

// ORDERS
router.get("/orders", adminOrdersController.getAllOrders);
router.get("/orders/count", adminOrdersController.getOrdersCount);
router.put("/orders/:id/status", adminOrdersController.updateOrderStatusById);

module.exports = router;
