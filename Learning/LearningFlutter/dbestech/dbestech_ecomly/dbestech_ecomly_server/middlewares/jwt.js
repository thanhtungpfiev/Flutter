/*
 * *****************************************************************************
 * * \author Dao Thanh Tung (MS/EAE1-BST) - thanhtungpfiev@gmail.com
 * *
 * * \date Mon Sep 29 2025
 * *
 * * \copyright 2025 - thanhtungpfiev@gmail.com. All rights reserved.
 * *
 * * \filename jwt.js
 * *
 * * \brief
 * *
 * *
 * *****************************************************************************
 */
const { expressjwt: expressjwt } = require("express-jwt");

require("dotenv").config();
const env = process.env;

const { Token } = require("../models/token");

function authJwt() {
  return expressjwt({
    secret: env.JWT_ACCESS_TOKEN_SECRET,
    algorithms: ["HS256"],
    isRevoked: async (req, jwt) => {
      const authHeader = req.header("Authorization");
      // If there's no Authorization header or it's not a Bearer token, treat as revoked
      if (!authHeader || !authHeader.startsWith("Bearer ")) {
        return true;
      }
      const accessToken = authHeader.replace("Bearer ", "").trim();
      // Token is stored with the field name `accessToken` in MongoDB (Mongoose)
      const tokenInDb = await Token.findOne({ accessToken });

      const adminRouteRegex = /^\/api\/v1\/admin\//i;
      const adminFault =
        !jwt.payload.isAdmin && adminRouteRegex.test(req.originalUrl);
      return !tokenInDb || adminFault;
    },
  }).unless({
    path: [
      `${env.API_URL}/auth/login`,
      `${env.API_URL}/auth/login/`,
      `${env.API_URL}/auth/register`,
      `${env.API_URL}/auth/register/`,
      `${env.API_URL}/auth/forgot-password`,
      `${env.API_URL}/auth/forgot-password/`,
      `${env.API_URL}/auth/verify-otp`,
      `${env.API_URL}/auth/verify-otp/`,
      `${env.API_URL}/auth/reset-password`,
      `${env.API_URL}/auth/reset-password/`,
      `${env.API_URL}/auth/verify-token`,
      `${env.API_URL}/auth/verify-token/`,
    ],
  });
}

module.exports = authJwt;
