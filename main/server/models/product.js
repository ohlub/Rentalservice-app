const mongoose = require('mongoose');
const ratingSchema = require('./rating');

const productSchema = mongoose.Schema({
  name: {
    type: String,
    required: true,
    trim: true,
  },
  images: [
    {
      type: String,
      required: true,
    },
  ],
  price:{
    type: Number,
    required: true
  },
  quantity: {
    type: Number,
    required: true,
  },
  description:{
    type: String,
    required: true,
    trim: true,
  },
  category:{
    type: String,
    required: true,
  },
  seller:{
    type: String,
    required: true,
  },
  type:{
    type: String,
    required: true,
  },
  region:{
    type: String,
    required: true,
  },
  option:{
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
  reviews: [
    {
      type: String,
      required: true,
    },
  ],
  ratings: [ratingSchema],

});

const Product = mongoose.model('Product', productSchema);
module.exports = {Product, productSchema};