import 'package:flutter/material.dart';
import 'package:formflutter/models/product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:formflutter/ui/edit_product_arguments.dart';

class EditProductPage extends StatefulWidget {
  final EditProductPageArguments arguments;

  EditProductPage({required this.arguments});

  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final _formKey = GlobalKey<FormState>();
  Product? _product;

  final _codeOfProductTextboxController = TextEditingController();
  final _nameOfProductTextboxController = TextEditingController();
  final _pabrikanOfProductTextboxController = TextEditingController();
  final _priceOfProductTextboxController = TextEditingController();
  final _stockOfProductTextboxController = TextEditingController();

  @override
  //UNTUK MENAMPILKAN DATANYA LANGSUNG
  //dua cara pakai  Product? _product; atau langsun dari argument widget.arguments.product.name
  void initState() {
    super.initState();
    _product = widget.arguments.product;
    _codeOfProductTextboxController.text = _product!.codeOfProduct ?? '';
    _nameOfProductTextboxController.text = _product!.nameOfProduct ?? '';
    _pabrikanOfProductTextboxController.text =
        _product!.pabrikanOfProduct?.toString() ?? '';
    _priceOfProductTextboxController.text =
        _product!.priceOfProduct?.toString() ?? '';
    _stockOfProductTextboxController.text =
        _product!.stockOfProduct?.toString() ?? '';
  }

  Future<void> _updateProduct() async {
    String url = 'http://192.168.56.1:8000/api/edit/product/${_product!.id}';
    Map<String, dynamic> data = {
      'code': _codeOfProductTextboxController.text,
      'name': _nameOfProductTextboxController.text,
      'price': double.parse(_priceOfProductTextboxController.text),
      'stock': double.parse(_stockOfProductTextboxController.text),
      'pabrikan': _pabrikanOfProductTextboxController.text,
    };

    var response = await http.put(Uri.parse(url),
        body: json.encode(data), headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      // Produk berhasil diupdate
      widget.arguments.onProductUpdated();
      Navigator.pop(context);
    } else {
      // Tangani error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Produk'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
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
              SizedBox(
                height: 16.0,
                width: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: _savedButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _codeOfProductTextboxController.dispose();
    _nameOfProductTextboxController.dispose();
    _priceOfProductTextboxController.dispose();
    _stockOfProductTextboxController.dispose();
    _pabrikanOfProductTextboxController.dispose();
    super.dispose();
  }

  Widget _textBoxCodeOfProduct() {
    return TextFormField(
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
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter the product code';
        }
        return null;
      },
    );
  }

  _textBoxNameOfProduct() {
    return TextFormField(
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
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter the product name';
        }
        return null;
      },
    );
  }

  _textBoxPabrikanOfProduct() {
    return TextFormField(
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
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter the manufacturer';
        }
        return null;
      },
    );
  }

  _textBoxPriceOfProduct() {
    return TextFormField(
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
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter the product price';
        }
        return null;
      },
    );
  }

  _textBoxStockOfProduct() {
    return TextFormField(
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
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter the Product Stock';
        }
        return null;
      },
    );
  }

  _savedButton() {
    return ElevatedButton(
        onPressed: _updateProduct, child: const Text('Simpan'));
  }
}
