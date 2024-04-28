import 'package:flutter/material.dart';
import 'package:formflutter/ui/detail_produk.dart';

// ignore_for_file: prefer_const_constructors
class ProdukForm extends StatefulWidget {
  const ProdukForm({Key? key}) : super(key: key);
  @override
  _ProdukFormState createState() => _ProdukFormState();
}

class _ProdukFormState extends State<ProdukForm> {
  final _codeOfProductTextboxController = TextEditingController();
  final _nameOfProductTextboxController = TextEditingController();
  final _pabrikanOfProductTextboxController = TextEditingController();
  final _priceOfProductTextboxController = TextEditingController();
  final _stockOfProductTextboxController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Produk'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: _textBoxCodeOfProduct(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: _textBoxNameOfProduct(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: _textBoxPriceOfProduct(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: _textBoxStockOfProduct(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: _textBoxPabrikanOfProduct(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: _savedButton(),
            ),
          ],
        ),
      ),
    );
  }

  _textBoxCodeOfProduct() {
    return TextField(
      decoration: InputDecoration(
        labelText: "No Barcode Produk",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelStyle: TextStyle(fontSize: 20.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: Colors.blue,
            width: 2.0,
          ),
        ),
      ),
      controller: _codeOfProductTextboxController,
    );
  }

  _textBoxNameOfProduct() {
    return TextField(
      decoration: InputDecoration(
        labelText: "Nama Produk",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelStyle: TextStyle(fontSize: 20.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: Colors.blue,
            width: 2.0,
          ),
        ),
      ),
      controller: _nameOfProductTextboxController,
    );
  }

  _textBoxPabrikanOfProduct() {
    return TextField(
      decoration: InputDecoration(
        labelText: "Pabrikan",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelStyle: TextStyle(fontSize: 20.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: Colors.blue,
            width: 2.0,
          ),
        ),
      ),
      controller: _pabrikanOfProductTextboxController,
    );
  }

  _textBoxPriceOfProduct() {
    return TextField(
      decoration: InputDecoration(
        labelText: "Harga Produk",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelStyle: TextStyle(fontSize: 20.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: Colors.blue,
            width: 2.0,
          ),
        ),
      ),
      controller: _priceOfProductTextboxController,
    );
  }

  _textBoxStockOfProduct() {
    return TextField(
      decoration: InputDecoration(
        labelText: "Stok Produk",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelStyle: TextStyle(fontSize: 20.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: Colors.blue,
            width: 2.0,
          ),
        ),
      ),
      controller: _stockOfProductTextboxController,
    );
  }

  _savedButton() {
    return ElevatedButton(
        onPressed: () {
          String codeOfProduct = _codeOfProductTextboxController.text;
          String nameOfProduct = _nameOfProductTextboxController.text;
          String pabrikaOfProduct = _pabrikanOfProductTextboxController.text;
          int priceOfProduct = int.parse(_priceOfProductTextboxController.text);
          int stockOfProduct = int.parse(_stockOfProductTextboxController.text);

          //pindah halaman
          //yang kiri itu parameter dari detailProduk
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DetailProduk(
                    codeOfProduct: codeOfProduct,
                    nameOfProduct: nameOfProduct,
                    pabrikanOfProduct: pabrikaOfProduct,
                    priceOfProduct: priceOfProduct,
                    stockOfProduct: stockOfProduct,
                  )));
        },
        child: const Text('Simpan'));
  }
}
