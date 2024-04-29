import 'package:flutter/material.dart';
// import 'package:formflutter/ui/produk_form.dart';
import 'package:formflutter/ui/home_page.dart';
import 'package:formflutter/ui/product_page.dart';
import 'package:formflutter/ui/listproduct_page.dart';
import 'package:formflutter/ui/editproduct_page.dart';
import 'package:formflutter/models/product.dart';
import 'package:formflutter/ui/edit_product_arguments.dart';

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
      title: "CRUD PRODUCT",
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/create': (context) => CreateProductPage(),
        '/list': (context) => ProductListPage(),
        '/edit-product': (context) => EditProductPage(
              arguments: ModalRoute.of(context)!.settings.arguments
                  as EditProductPageArguments,
            ),
      },
      //yen pindah halaman pakek navigator.pushNamed()
    );
  }
}
