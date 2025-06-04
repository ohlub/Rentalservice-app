const mongoose = require('mongoose');
const { productSchema } = require("./product");

const chatSchema = mongoose.Schema({
  member1: {
    type: String,
    required: true,
    trim: true,
  },
  member2:{
    type: String,
    required: true,
    trim: true,
  },
  message1: [
    {
      type: String,
      required: true,
      trim: true,
    },
  ],
  message2: [
    {
      type: String,
      required: true,
      trim: true,
    },
  ],
  sentAt1: [
    {
      type: String,
      required: true,
      trim: true,
    },
  ],
  sentAt2: [
    {
      type: String,
      required: true,
      trim: true,
    },
  ],
  name:
    {
      type: String,
      required: true,
    },
  images: [
    {
      type: String,
      required: true,
    },
  ],
  price:
    {
      type: Number,
      required: true,
    },
  option:
    {
      type: String,
      required: true,
    },
  direct: {
    type: Boolean,
    required: true,
  },
  delivery: {
    type: Boolean,
    required: true,
  },
});

const Chat = mongoose.model('Chat', chatSchema);
module.exports = Chat;