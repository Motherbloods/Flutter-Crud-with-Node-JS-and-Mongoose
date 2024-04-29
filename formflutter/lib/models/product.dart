// File: product_model.dart

class Product {
  final String? id;
  final String? codeOfProduct;
  final String? nameOfProduct;
  final String? pabrikanOfProduct;
  final double? priceOfProduct;
  final double? stockOfProduct;

  Product({
    this.id,
    this.codeOfProduct,
    this.nameOfProduct,
    this.priceOfProduct,
    this.stockOfProduct,
    this.pabrikanOfProduct,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      codeOfProduct: json['code'],
      nameOfProduct: json['name'],
      pabrikanOfProduct: json['pabrikan'],
      stockOfProduct: json['stock'] != null ? json['stock'].toDouble() : null,
      priceOfProduct: json['price'] != null ? json['price'].toDouble() : null,
    );
  }
}
