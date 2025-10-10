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
