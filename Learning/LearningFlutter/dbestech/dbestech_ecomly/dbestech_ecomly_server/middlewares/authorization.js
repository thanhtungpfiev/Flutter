/*
 * *****************************************************************************
 * * \author Dao Thanh Tung (MS/EAE1-BST) - thanhtungpfiev@gmail.com
 * *
 * * \date Wed Oct 29 2025
 * *
 * * \copyright 2025 - thanhtungpfiev@gmail.com. All rights reserved.
 * *
 * * \filename authorization.js
 * *
 * * \brief
 * *
 * *
 * *****************************************************************************
 */
const jsonwebtoken = require("jsonwebtoken");
const { default: mongoose } = require("mongoose");

async function authorizePostRequests(req, res, next) {
  if (req.method !== "POST") return next();
  if (req.originalUrl.startsWith(`${process.env.API_URL}/admin`)) return next();
  const endpoints = [
    `${process.env.API_URL}/auth/login`,
    `${process.env.API_URL}/auth/register`,
    `${process.env.API_URL}/auth/forgot-password`,
    `${process.env.API_URL}/auth/verify-otp`,
    `${process.env.API_URL}/auth/reset-password`,
    `${process.env.API_URL}/auth/verify-token`,
  ];
  const isMatchingEndpoint = endpoints.some((endpoint) =>
    req.originalUrl.includes(endpoint)
  );
  if (isMatchingEndpoint) return next();

  const authHeader = req.header("Authorization");
  if (!authHeader) return next();
  const accessToken = authHeader.replace("Bearer ", "").trim();
  const tokenData = jsonwebtoken.decode(accessToken);
  if (req.body.user && tokenData != req.body.user) {
    return res.status(401).json({ message: "Unauthorized: User mismatch" });
  } else if (/\/users\/([^/]+)\//.test(req.originalUrl)) {
    const parts = req.originalUrl.split("/");
    const usersIndex = parts.indexOf("users");
    const id = parts[usersIndex + 1];
    if (!mongoose.isValidObjectId(id)) return next();
    if (tokenData.id !== id) return res.status(401).json({ message });
  }
  return next();
}

module.exports = authorizePostRequests;
