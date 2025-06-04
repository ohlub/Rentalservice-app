const express = require('express');
const adminRouter = express.Router();
const admin = require('../middlewares/admin');
const { Product } = require('../models/product');
const User = require('../models/user');
const Chat = require('../models/chat');
const Order = require("../models/order");
const { PromiseProvider } = require("mongoose");


adminRouter.post('/admin/add-product', admin, async (req,res) => {
  try{
    const {name, images, price, quantity, description, category, seller, type, region, option, direct, delivery, reviews} = req.body;
    let product = new Product({
      name,
      images,
      price,
      quantity,
      description,
      category,
      seller,
      type,
      region,
      option,
      direct,
      delivery,
      reviews
    });
    product = await product.save();
    res.json(product);
  } catch (e){
    res.status(500).json({error: e.message});
  }
});

adminRouter.post('/admin/add-chat', admin, async (req,res) => {
  try{
    const {member1, member2, message1, message2, sentAt1, sentAt2, name, images, price, option, direct, delivery} = req.body;

    let chat = new Chat({
      member1,
      member2,
      message1,
      message2,
      sentAt1,
      sentAt2,
      name,
      images,
      price,
      option,
      direct,
      delivery
    });
    chat = await chat.save();
    res.json(chat);
  } catch (e){
    res.status(500).json({error: e.message});
  }
});

adminRouter.post('/admin/request-product', admin, async (req,res) => {
  try{
    const {name, images, price, quantity, description, category, seller, type, region, option, direct, delivery, reviews} = req.body;
    let product = new Product({
      name,
      images,
      price,
      quantity,
      description,
      category,
      seller,
      type,
      region,
      option,
      direct,
      delivery,
      reviews
    });
    product = await product.save();
    res.json(product);
  } catch (e){
    res.status(500).json({error: e.message});
  }
});

adminRouter.get('/admin/get-products', admin, async (req, res) => {
  try{
    const products = await Product.find({});
    res.json(products);
  }catch (e) {
    res.status(500).json({error: e.message});
  }
});

adminRouter.get('/admin/get-chats', admin, async (req, res) => {
  try{
    const chats = await Chat.find({});
    res.json(chats);
  }catch (e) {
    res.status(500).json({error: e.message});
  }
});


adminRouter.post('/admin/add-messages1', admin, async (req, res) => {
  try {
    const { member1, member2, name, message1, message2, sentAt1, sentAt2} = req.body;

    const filter = { member1: member1, member2: member2, name: name };
    const update = { $push: { message1: message1, sentAt1: sentAt1} }; // 수정된 부분

    // MongoDB의 updateOne 메서드를 호출하여 업데이트 수행
    const result = await Chat.updateOne(filter, update);

  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

adminRouter.post('/admin/add-messages2', admin, async (req, res) => {
  try {
    const { member1, member2, name, message1, message2, sentAt1, sentAt2} = req.body;

    const filter = { member1: member1, member2: member2, name: name};
    const update = { $push: { message2: message2, sentAt2: sentAt2} }; // 수정된 부분

    // MongoDB의 updateOne 메서드를 호출하여 업데이트 수행
    const result = await Chat.updateOne(filter, update);

  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

adminRouter.post('/admin/save-search', admin, async (req, res) => {
  try {
    const { name, email, password, token, region, address, cart, order, search } = req.body;

    const filter = { name: name};
    const update = { $set: { search: search } }; // 수정된 부분

    // MongoDB의 updateOne 메서드를 호출하여 업데이트 수행
    const result = await User.updateOne(filter, update);

  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});


adminRouter.post('/admin/save-region', admin, async (req, res) => {
  try {
    const { name, email, password, token, region, address, cart, order, search } = req.body;

    const filter = { name: name};
    const update = { $set: { region: region } }; // 수정된 부분

    // MongoDB의 updateOne 메서드를 호출하여 업데이트 수행
    const result = await User.updateOne(filter, update);

  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// Delete the product
adminRouter.post("/admin/delete-product", admin, async (req, res) => {
  try {
    const { id } = req.body;
    let product = await Product.findByIdAndDelete(id);
    res.json(product);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

adminRouter.post("/admin/delete-order", admin, async (req, res) => {
  try {
    const { id } = req.body;
    let order = await Order.findByIdAndDelete(id);
    res.json(order);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// Delete the product
adminRouter.post("/admin/delete-chat", admin, async (req, res) => {
  try {
    const { name, username } = req.body;
    const userId = req.user;
    let chat = await Chat.findOneAndDelete({ name: name });

    let user = await User.findById(userId);
    const targetUser = await User.findOne({ name: username });

    for (let i = 0; i < user.order.length; i++) {
      const orderItem = user.order[i];


      const productName = orderItem.product.name;


      if (productName === name) {

        user.order.splice(i, 1);
        i--;
      }
    }

    for (let i = 0; i < targetUser.order.length; i++) {
      const orderItem = targetUser.order[i];


      const productName = orderItem.product.name;


      if (productName === name) {

        targetUser.order.splice(i, 1);
        i--;
      }
    }

      // Save the updated user
    await user.save();
    await targetUser.save();

    res.json({ user, chat });
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

adminRouter.get("/admin/get-orders", admin, async (req, res) => {
  try {
    const orders = await Order.find({});
    res.json(orders);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

adminRouter.get("/admin/get-users", admin, async (req, res) => {
  try {
    const users = await User.find({});
    res.json(users);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

adminRouter.post("/admin/change-order-status", admin, async (req, res) => {
  try {
    const { id, status } = req.body;
    let order = await Order.findById(id);
    order.status = status;
    order = await order.save();
    res.json(order);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});


adminRouter.get("/admin/analytics", admin, async (req, res) => {
  try {
    const orders = await Order.find({});
    let totalEarnings = 0;

    for (let i = 0; i < orders.length; i++) {
      for (let j = 0; j < orders[i].products.length; j++) {
        totalEarnings +=
          orders[i].products[j].quantity * orders[i].products[j].product.price;
      }
    }
    // CATEGORY WISE ORDER FETCHING
    let mobileEarnings = await fetchCategoryWiseProduct("모바일");
    let essentialEarnings = await fetchCategoryWiseProduct("생활용품");
    let applianceEarnings = await fetchCategoryWiseProduct("전자기기");
    let booksEarnings = await fetchCategoryWiseProduct("도서");
    let requestEarnings = await fetchCategoryWiseProduct("물건요청");

    let earnings = {
      totalEarnings,
      mobileEarnings,
      essentialEarnings,
      applianceEarnings,
      booksEarnings,
      requestEarnings,
    };

    res.json(earnings);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

async function fetchCategoryWiseProduct(category) {
  let earnings = 0;
  let categoryOrders = await Order.find({
    "products.product.category": category,
  });

  for (let i = 0; i < categoryOrders.length; i++) {
    for (let j = 0; j < categoryOrders[i].products.length; j++) {
      earnings +=
        categoryOrders[i].products[j].quantity *
        categoryOrders[i].products[j].product.price;
    }
  }
  return earnings;
}


module.exports = adminRouter;