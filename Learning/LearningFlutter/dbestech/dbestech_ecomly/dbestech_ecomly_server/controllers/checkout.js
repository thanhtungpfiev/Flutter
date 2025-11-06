/*
 * *****************************************************************************
 * * \author Dao Thanh Tung (MS/EAE1-BST) - thanhtungpfiev@gmail.com
 * *
 * * \date Thu Nov 06 2025
 * *
 * * \copyright 2025 - thanhtungpfiev@gmail.com. All rights reserved.
 * *
 * * \filename checkout.js
 * *
 * * \brief
 * *
 * *
 * *****************************************************************************
 */
const jsonwebtoken = require("jsonwebtoken");
const stripe = require("stripe")(process.env.STRIPE_SECRET_KEY);

const { User } = require("../models/user");
const { Product } = require("../models/product");
const { CartProduct } = require("../models/cart_product");

exports.checkout = async (req, res) => {
  const accessToken = req
    .header("Authorization")
    ?.replace("Bearer ", "")
    .trim();
  const tokenData = jsonwebtoken.decode(accessToken);

  const user = await User.findById(tokenData.userId);
  if (!user) {
    return res.status(404).json({ message: "User not found" });
  }
  for (const cartItem of req.body.cartItems) {
    const product = await Product.findById(cartItem.product);
    if (!product) {
      return res.status(404).json({ message: "Product not found" });
    } else if (!cartItem.reserved && product.countInStock < cartItem.quantity) {
      return res
        .status(400)
        .json({ message: `Insufficient stock for product ${product.name}` });
    }
  }
  let customerId;
  if (user.paymentCustomerId) {
    customerId = user.paymentCustomerId;
  } else {
    const customer = await stripe.customers.create({
      metadata: { userId: tokenData.id },
    });
    customerId = customer.id;
  }
  const session = await stripe.checkout.sessions.create({
    line_items: req.body.cartItems.map((item) => {
      return {
        price_data: {
          currency: "usd",
          product_data: {
            name: item.name,
            image: item.images,
            metadata: {
              productId: item.productId,
              CartProductId: item.cartProductId,
              selectedSize: item.selectedSize ?? undefined,
              selectedColor: item.selectedColor ?? undefined,
            },
          },
          unit_amount: Math.round(item.price * 100).toFixed(0),
        },
        quantity: item.quantity,
      };
    }),
    payment_method_options: {
      card: { setup_future_usage: "on_session" },
    },
    billing_address_collection: "auto",
    shipping_address_collection: {
      allowed_countries: ["US", "CA"],
    },
    phone_number_collection: {
      enabled: true,
    },
    customer: customerId,
    mode: "payment",
    success_url: req.body.successUrl,
    cancel_url: req.body.cancelUrl,
  });
  res.status(201).json({ url: session.url });
};
