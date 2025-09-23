/*
 * *****************************************************************************
 * * \author Dao Thanh Tung (MS/EAE1-BST) - thanhtungpfiev@gmail.com
 * *
 * * \date Tue Sep 23 2025
 * *
 * * \copyright 2025 - thanhtungpfiev@gmail.com. All rights reserved.
 * *
 * * \filename email_sender.js
 * *
 * * \brief
 * *
 * *
 * *****************************************************************************
 */
const nodemailer = require("nodemailer");
require("dotenv").config();
const env = process.env;

exports.sendMail = async (
  email,
  subject,
  body,
  successMessage,
  errorMessage
) => {
  return new Promise((resolve, reject) => {
    const transporter = nodemailer.createTransport({
      host: "smtp.ethereal.email",
      port: 587,
      auth: {
        user: env.EMAIL_USERNAME,
        pass: env.EMAIL_PASSWORD,
      },
    });

    const mailOptions = {
      from: env.EMAIL_USERNAME,
      to: email,
      subject: subject,
      text: body,
    };

    transporter.sendMail(mailOptions, (error, info) => {
      if (error) {
        console.error("Error sending email:", error);
        reject(Error(errorMessage));
      } else {
        console.log("Email sent:", info.response);
        // If caller provided a custom successMessage, return that; otherwise return the transport response
        resolve(successMessage || info.response);
      }
    });
  });
};
