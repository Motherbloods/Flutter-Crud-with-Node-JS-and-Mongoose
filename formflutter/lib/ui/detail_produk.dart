import 'package:flutter/material.dart';

// ignore_for_file: prefer_const_constructors
class DetailProduk extends StatefulWidget {
  final String? codeOfProduct;
  final String? nameOfProduct;
  final String? pabrikanOfProduct;
  final int? priceOfProduct;
  final int? stockOfProduct;

  const DetailProduk(
      {Key? key,
      this.codeOfProduct,
      this.nameOfProduct,
      this.priceOfProduct,
      this.stockOfProduct,
      this.pabrikanOfProduct})
      : super(key: key);

  @override
  _DetailProdukState createState() => _DetailProdukState();
}

class _DetailProdukState extends State<DetailProduk> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Detail Product'),
        ),
        body: Column(
          children: [
            Text('Kode Produk : ' + widget.codeOfProduct.toString()),
            Text("Nama Produk : " + widget.nameOfProduct.toString()),
            Text("Harga Produk :  ${widget.priceOfProduct}"),
            Text("Stock Produk :  ${widget.stockOfProduct}"),
            Text("Pabrikan : " + widget.pabrikanOfProduct.toString()),
          ],
        ));
  }
}
