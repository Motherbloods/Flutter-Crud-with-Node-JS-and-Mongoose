import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CreateProductPage extends StatefulWidget {
  @override
  _CreateProductPageState createState() => _CreateProductPageState();
}

class _CreateProductPageState extends State<CreateProductPage> {
  final _formKey = GlobalKey<FormState>();
  String? codeOfProduct;
  String? nameOfProduct;
  String? pabrikanOfProduct;
  int? priceOfProduct;
  int? stockOfProduct;
  final _codeOfProductTextboxController = TextEditingController();
  final _nameOfProductTextboxController = TextEditingController();
  final _pabrikanOfProductTextboxController = TextEditingController();
  final _priceOfProductTextboxController = TextEditingController();
  final _stockOfProductTextboxController = TextEditingController();

  Future<void> _createProduct() async {
    try {
      String url = 'http://192.168.56.1:8000/api/product';
      final response = await http.post(
        (Uri.parse(url)),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'name': nameOfProduct,
          'code': codeOfProduct,
          'pabrikan': pabrikanOfProduct,
          'price': priceOfProduct,
          'stock': stockOfProduct,
        }),
      );
      if (response.statusCode == 201) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Success'),
              content: Text('Product created successfully.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _formKey.currentState?.reset();
                  },
                  child: Text('Add Another'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.popUntil(context, ModalRoute.withName('/'));
                  },
                  child: Text('Go to Home'),
                ),
              ],
            );
          },
        );
      } else {
        throw Exception('Failed to create product');
      }
    } catch (error) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('There was an error: $error'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Product'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
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
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 0),
                      child: _savedButton(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
      onSaved: (value) {
        codeOfProduct = value;
      },
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
      onSaved: (value) {
        nameOfProduct = value;
      },
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
      onSaved: (value) {
        pabrikanOfProduct = value;
      },
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
      onSaved: (value) {
        priceOfProduct = int.tryParse(value ?? '');
      },
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
      onSaved: (value) {
        stockOfProduct = int.tryParse(value ?? '');
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter the Product Stock';
        }
        return null;
      },
    );
  }

  Widget _savedButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: FractionallySizedBox(
        widthFactor: 0.5, // Lebar button adalah setengah dari parentnya
        child: ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              _createProduct();
            }
          },
          child: Text('Simpan'),
        ),
      ),
    );
  }
}
