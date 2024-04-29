const express = require("express");
const mongoose = require("mongoose");
const bodyParser = require("body-parser");
const cors = require("cors");
const PORT = process.env.PORT || 8000;
const app = express();

const url = "mongodb://localhost:27017/pukesmas"; // Ganti dengan URL MongoDB lokal Anda

(async () => {
  try {
    const db = await mongoose.connect(url);
    console.log("Connected to MongoDB");
  } catch (e) {
    console.error("Couldn't connect to MongoDB", e);
  }
})();

const Product = mongoose.model("Product", {
  name: String,
  code: String,
  pabrikan: String,
  price: Number,
  stock: Number,
});

// Middleware
app.use(cors());
app.use(bodyParser.json());

// Routes
app.post("/api/product", async (req, res) => {
  try {
    const { name, code, pabrikan, price, stock } = req.body;
    console.log(name, code, pabrikan, price, stock);
    const product = new Product({ name, code, pabrikan, price, stock });
    await product.save();
    res.status(201).json({ message: "Product created successfully" });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Internal server error" });
  }
});

app.get("/api/product", async (req, res) => {
  try {
    const products = await Product.find();
    res.json(products);
    console.log("ini semua product: ", products);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

app.delete("/api/delete/product/:id", async (req, res) => {
  const id = req.params.id;

  try {
    // Temukan produk yang akan dihapus
    const product = await Product.findById(id);

    if (!product) {
      // Produk tidak ditemukan
      return res.status(404).send("Product not found");
    }

    // Simpan nama produk sebelum dihapus
    const productName = product.name;

    // Menghapus satu produk berdasarkan ID
    const result = await Product.deleteOne({ _id: id });

    if (result.deletedCount === 1) {
      // Jika produk berhasil dihapus, kirim nama produk ke frontend
      res.status(200).send({
        message: "Product deleted successfully",
        deletedProduct: productName,
      });
    } else {
      res.status(500).send("Internal Server Error");
    }
  } catch (error) {
    console.error("Error deleting product:", error);
    res.status(500).send("Internal Server Error");
  }
});
app.get("/api/edit/product/:id", async (req, res) => {
  const product = req.params.id;
  console.log("ini produ", product);
});
app.put("/api/edit/product/:id", async (req, res) => {
  const productId = req.params.id;
  const updatedProduct = req.body;
  console.log("ini req.body dari fronted", productId, updatedProduct);
  try {
    // Cari produk berdasarkan ID dan perbarui datanya
    const product = await Product.findByIdAndUpdate(
      productId,
      {
        code: updatedProduct.code,
        name: updatedProduct.name,
        price: updatedProduct.price,
        stock: updatedProduct.stock,
        pabrikan: updatedProduct.pabrikan,
      },
      { new: true }
    );
    console.log("ini product updated", product);
    if (product) {
      res
        .status(200)
        .json({ message: "Product updated successfully", product });
    } else {
      res.status(404).json({ message: "Product not found" });
    }
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});
// Start server

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
