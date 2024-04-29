import 'package:flutter/material.dart';
import 'package:formflutter/models/product.dart';

class EditProductPageArguments {
  final Product product;
  final VoidCallback onProductUpdated;

  EditProductPageArguments(
      {required this.product, required this.onProductUpdated});
}
