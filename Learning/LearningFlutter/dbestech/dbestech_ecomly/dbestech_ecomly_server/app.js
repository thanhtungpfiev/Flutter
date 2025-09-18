/*
 * *****************************************************************************
 * * \author Dao Thanh Tung - thanhtungpfiev@gmail.com
 * *
 * * \date Sat Sep 06 2025
 * *
 * * \copyright 2025 - thanhtungpfiev@gmail.com. All rights reserved.
 * *
 * * \filename app.js
 * *
 * * \brief
 * *
 * *
 * *****************************************************************************
 */
const bodyParser = require("body-parser");
const cors = require("cors");
const express = require("express");
const morgan = require("morgan");
const mongoose = require("mongoose");
require("dotenv").config();

const app = express();
const env = process.env;

app.use(bodyParser.json());
app.use(morgan("tiny"));
app.use(cors());

app.get("/", (req, res) => {
  res.send("Hello, World! This is the starting point of the server.");
});

// Connect to MongoDB
mongoose
  .connect(
    `mongodb+srv://${env.MONGO_DB_USERNAME}:${env.MONGO_DB_PASSWORD}@cluster0.jj3o5t2.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0`
  )
  .then(() => {
    console.log("Connected to MongoDB successfully.");
  })
  .catch((error) => {
    console.error("Error connecting to MongoDB:", error);
  });

app.listen(env.PORT, env.HOST, () => {
  console.log(`Server is running on http://${env.HOST}:${env.PORT}`);
});
