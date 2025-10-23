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
const wishlistController = require("../controllers/wishlist");
const cartController = require("../controllers/cart");

router.get("/", usersController.getUsers);
router.get("/:id", usersController.getUserById);
router.put("/:id", usersController.updateUser);

router.get("/:id/wishlist", wishlistController.getUserWishlist);
router.post("/:id/wishlist", wishlistController.addToWishlist);
router.delete(
  "/:id/wishlist/:productId",
  wishlistController.removeFromWishlist
);

router.get("/:id/cart", cartController.getUserCart);
router.get("/:id/cart/count", cartController.getUserCartCount);
router.get("/:id/cart/:cartProductId", cartController.getCartProductById);
router.post("/:id/cart", cartController.addToCart);
router.put("/:id/cart/:cartProductId", cartController.updateCartProduct);
router.delete("/:id/cart/:cartProductId", cartController.removeCartProduct);

module.exports = router;
