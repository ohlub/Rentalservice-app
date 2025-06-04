const express = require("express");
const userRouter = express.Router();
const auth = require("../middlewares/auth");
const Order = require("../models/order");
const { Product } = require("../models/product");
const User = require("../models/user");
const Chat = require("../models/chat");

userRouter.post("/api/add-to-cart", auth, async (req, res) => {
  try {
    const { id } = req.body;
    const product = await Product.findById(id);
    let user = await User.findById(req.user);


    if (user.cart.length == 0) {
      user.cart.push({ product, quantity: 1 });
    } else {
      let isProductFound = false;
      for (let i = 0; i < user.cart.length; i++) {
        if (user.cart[i].product._id.equals(product._id)) {
          isProductFound = true;
        }
      }

      if (isProductFound) {
      } else {
        user.cart.push({ product, quantity: 1 });
      }
    }
    user = await user.save();
    res.json(user);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

userRouter.post("/api/add-order", auth, async (req, res) => {
  try {
    const { id, member1 } = req.body;
    const product = await Product.findById(id);
    let user = await User.findById(req.user);

    let isProductFound = false;

    if (user.order.length === 0) {
      user.order.push({ product, quantity: 1 });
      user = await user.save();

      const targetUser = await User.findOne({ name: member1 });
      targetUser.order.push({ product, quantity: 1 });
      await targetUser.save();
    } else {
      for (let i = 0; i < user.order.length; i++) {
        if (user.order[i].product._id.equals(product._id)) {
          isProductFound = true;
          break; // Exit the loop early if product is found
        }
      }
      if (isProductFound) {
        return res.status(400).json({ message: "이미 채팅이 진행중입니다." });
      } else {
        user.order.push({ product, quantity: 1 });
        user = await user.save();

        const targetUser = await User.findOne({ name: member1 });
        targetUser.order.push({ product, quantity: 1 });
        await targetUser.save();
      }
    }

    return res.json(user);



  } catch (e) {
    return res.status(500).json({ error: e.message });
  }
});

userRouter.delete("/api/remove-from-cart/:id", auth, async (req, res) => {
  try {
    const { id } = req.params;
    const product = await Product.findById(id);
    let user = await User.findById(req.user);

    for (let i = 0; i < user.cart.length; i++) {
      if (user.cart[i].product._id.equals(product._id)) {
        if (user.cart[i].quantity == 1) {
          user.cart.splice(i, 1);
        } else {
          user.cart[i].quantity -= 1;
        }
      }
    }
    user = await user.save();
    res.json(user);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// save user address
userRouter.post("/api/save-user-address", auth, async (req, res) => {
  try {
    const { address } = req.body;
    let user = await User.findById(req.user);
    user.address = address;
    user = await user.save();
    res.json(user);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

userRouter.post("/api/save-user-region", auth, async (req, res) => {
  try {
    const { region } = req.body;
    let user = await User.findById(req.user);
    user.region = region;
    user = await user.save();
    res.json(user);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// order product
userRouter.post("/api/order", auth, async (req, res) => {
  try {
    const { cart, order, totalPrice, address, startDate, endDate, index } = req.body;
    let products = [];

      let product = await Product.findById(order[index].product._id);
      products.push({ product, quantity: 1 });
      await product.save();


    let orders = new Order({
      products,
      totalPrice,
      address,
      userId: req.user,
      orderedAt: new Date().getTime(),
      startDate: startDate,
      endDate: endDate,
    });
    orders = await orders.save();
    res.json(orders);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

userRouter.get("/api/orders/me", auth, async (req, res) => {
  try {
    const orders = await Order.find({ userId: req.user });
    res.json(orders);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

module.exports = userRouter;