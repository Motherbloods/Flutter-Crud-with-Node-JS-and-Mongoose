import 'package:flutter/material.dart';
import 'package:formflutter/ui/produk_form.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProdukForm(),
      theme: ThemeData(primarySwatch: Colors.pink),
    );
  }
}
