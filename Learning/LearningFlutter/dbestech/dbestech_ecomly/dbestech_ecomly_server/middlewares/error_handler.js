const jsonwebtoken = require("jsonwebtoken");
const { Token } = require("../models/token");
const { User } = require("../models/user");

async function errorHandler(error, req, res, next) {
  if (error.name === "UnauthorizedError") {
    if (!error.message.includes("jwt expired")) {
      return res
        .status(error.status)
        .json({ type: error.name, message: error.message });
    }
    try {
      const tokenHeader = req.header("Authorization");
      const accessToken = tokenHeader?.split(" ")[1];
      let token = await Token.findOne({
        accessToken,
        refreshToken: { $exists: true },
      });
      if (!token) {
        return res
          .status(401)
          .json({ type: "Unauthorized", message: "Invalid token" });
      }
      const userData = jsonwebtoken.verify(
        token.refreshToken,
        process.env.JWT_REFRESH_TOKEN_SECRET
      );
      // The refresh token payload uses `userId` (consistent with login controller)
      const user = await User.findById(userData.userId);
      if (!user) {
        return res
          .status(404)
          .json({ type: "Not Found", message: "User not found" });
      }
      const newAccessToken = jsonwebtoken.sign(
        { userId: user.id, isAdmin: user.isAdmin },
        process.env.JWT_ACCESS_TOKEN_SECRET,
        { expiresIn: "5m" }
      );
      req.headers["authorization"] = `Bearer ${newAccessToken}`;
      await Token.updateOne(
        { _id: token._id },
        { accessToken: newAccessToken }
      ).exec();

      res.set("Authorization", `Bearer ${newAccessToken}`);
      return next();
    } catch (refreshError) {
      console.error("Error refreshing token:", refreshError);
      return res
        .status(401)
        .json({ type: "Unauthorized", message: refreshError });
    }
  }
}

module.exports = errorHandler;
