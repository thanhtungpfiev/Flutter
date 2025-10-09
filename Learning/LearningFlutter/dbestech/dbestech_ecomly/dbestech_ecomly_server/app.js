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

// External libraries
const bodyParser = require("body-parser");
const cors = require("cors");
const express = require("express");
const mongoose = require("mongoose");
const morgan = require("morgan");

// Config / side-effects
require("dotenv").config();

// Internal modules
const authJwt = require("./middlewares/jwt");
const adminRouter = require("./routes/admin");
const authRouter = require("./routes/auth");
const usersRouter = require("./routes/users");
const errorHandler = require("./middlewares/error_handler");

const app = express();
const env = process.env;

// Middlewares (order: parsers -> logging -> cors -> auth)
app.use(bodyParser.json());
app.use(morgan("tiny"));
app.use(cors());
app.use(authJwt());
app.use(errorHandler);

app.use(`${env.API_URL}/auth`, authRouter);
app.use(`${env.API_URL}/users`, usersRouter);
app.use(`${env.API_URL}/admin`, adminRouter);
app.use("/public", express.static(__dirname + "/public"));

app.get("/", (req, res) => {
  res.send("Hello, World! This is the starting point of the server.");
});

const connectToMongoDB = () => {
  const mongoEnv = env.MONGO_ENV || "local";
  console.log(`MongoDB Environment: ${mongoEnv}`);

  let connectionString;
  let connectionOptions = {
    serverSelectionTimeoutMS: 5000,
    socketTimeoutMS: 45000,
    maxPoolSize: 10,
    bufferCommands: false,
  };

  if (mongoEnv === "cloud") {
    // Cloud MongoDB Atlas connection
    connectionString = env.MONGO_CLOUD_URI;
    connectionOptions.serverSelectionTimeoutMS = 10000; // Longer timeout for cloud

    // Configure proxy for cloud connections if needed
    if (process.env.HTTP_PROXY || process.env.HTTPS_PROXY) {
      const proxyUrl = process.env.HTTPS_PROXY || process.env.HTTP_PROXY;
      const { HttpsProxyAgent } = require("https-proxy-agent");
      const agent = new HttpsProxyAgent(proxyUrl);
      const https = require("https");
      https.globalAgent = agent;
      console.log(`Using proxy for cloud connection: ${proxyUrl}`);
    }

    console.log("Attempting MongoDB Atlas (Cloud) connection...");
  } else {
    // Local MongoDB connection
    connectionString = env.MONGO_LOCAL_URI;
    console.log("Attempting Local MongoDB connection...");
  }

  mongoose
    .connect(connectionString, connectionOptions)
    .then(() => {
      console.log(`✅ Connected to MongoDB successfully (${mongoEnv})`);
      console.log(`Database: ${mongoose.connection.db.databaseName}`);
    })
    .catch((error) => {
      console.error(
        `❌ Error connecting to MongoDB (${mongoEnv}):`,
        error.message
      );

      if (mongoEnv === "cloud") {
        console.log("\n🔧 Cloud connection failed. Troubleshooting tips:");
        console.log("1. Check your internet connection");
        console.log("2. Verify MongoDB Atlas credentials");
        console.log("3. Check if your IP is whitelisted in MongoDB Atlas");
        console.log(
          "4. If behind corporate firewall, enable proxy settings in .env"
        );
        console.log("5. Consider switching to local MongoDB for development");
      } else {
        console.log("\n🔧 Local connection failed. Troubleshooting tips:");
        console.log("1. Make sure MongoDB is installed and running locally");
        console.log("2. Check if MongoDB service is started");
        console.log("3. Verify the connection string in MONGO_LOCAL_URI");
        console.log("4. Default MongoDB runs on localhost:27017");
      }
    });
};

connectToMongoDB();

app.listen(env.PORT, env.HOST, () => {
  console.log(`Server is running on http://${env.HOST}:${env.PORT}`);
});
