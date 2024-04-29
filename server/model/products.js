const mongoose = require("mongoose");

const productSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true,
  },
  code: {
    type: String,
    required: true,
  },
  pabrikan: {
    type: String,
    required: true,
  },
  price: {
    type: Integer,
    required: true,
  },
  stock: {
    type: Integer,
    required: true,
  },
});

const Products = mongoose.model("Products", productSchema);

module.exports = Products;
