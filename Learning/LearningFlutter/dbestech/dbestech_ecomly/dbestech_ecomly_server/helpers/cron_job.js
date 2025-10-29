/*
 * *****************************************************************************
 * * \author Dao Thanh Tung (MS/EAE1-BST) - thanhtungpfiev@gmail.com
 * *
 * * \date Fri Oct 10 2025
 * *
 * * \copyright 2025 - thanhtungpfiev@gmail.com. All rights reserved.
 * *
 * * \filename cron_job.js
 * *
 * * \brief
 * *
 * *
 * *****************************************************************************
 */
const cron = require("node-cron");
const { Category } = require("../models/category");
const { Product } = require("../models/product");
const { CartProduct } = require("../models/cart_product");
const { default: mongoose } = require("mongoose");

cron.schedule("0 0 * * *", async () => {
  console.log("Running a job at midnight every day");
  // Add your scheduled task logic here
  try {
    const categoriesToBeDeleted = await Category.find({
      markedForDeletion: true,
    });
    for (const category of categoriesToBeDeleted) {
      const categoryProductsCount = await Product.countDocuments({
        category: category._id,
      });
      if (categoryProductsCount === 0) {
        await category.deleteOne();
      }
    }
    console.log("Scheduled task completed successfully.");
  } catch (error) {
    console.error("Error executing scheduled task:", error);
  }
});

cron.schedule("*/30 * * * *", async () => {
  console.log("Running a job every 30 minutes");
  // Add your scheduled task logic here
  const session = await mongoose.startSession();
  session.startTransaction();
  try {
    console.log("Reservation release CRON job started at", new Date());
    const expiredReservations = await CartProduct.find({
      reserved: true,
      reservationExpiry: { $lte: new Date() },
    }).session(session);
    for (const cartProduct of expiredReservations) {
      const product = await Product.findById(cartProduct.product).session(
        session
      );
      if (product) {
        const updatedProduct = await Product.findByIdAndUpdate(
          product._id,
          { $inc: { countInStock: cartProduct.quantity } },
          { new: true, runValidators: true, session }
        );
        if (!updatedProduct) {
          console.error(
            "Error occurred: Product update failed. Potential concurrency issue."
          );
          await session.abortTransaction();
          return;
        }

        await CartProduct.findByIdAndUpdate(
          cartProduct._id,
          { reserved: false },
          { session }
        );
      }
      await session.commitTransaction();
      console.log("Reservation release CRON job completed at", new Date());
    }
  } catch (error) {
    await session.abortTransaction();
    console.error("Error executing scheduled task:", error);
    return resizeBy
      .status(500)
      .json({ type: error.name, message: error.message });
  } finally {
    session.endSession();
  }
});
