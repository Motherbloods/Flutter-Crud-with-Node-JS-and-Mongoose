import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:formflutter/models/product.dart';
import 'package:formflutter/ui/edit_product_arguments.dart';
import 'dart:convert';

class ProductListPage extends StatefulWidget {
  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  Future<List<Product>> _getProducts() async {
    String url =
        'http://192.168.56.1:8000/api/product'; // Tanpa karakter spasi di depan alamat IP
    var data = await http.get(Uri.parse(url));
    var jsonData = json.decode(data.body);
    List<Product> products = [];
    for (var item in jsonData) {
      products.add(Product.fromJson(item));
    }
    return products;
  }

  Future<void> _refreshProducts() async {
    setState(() {});
  }

  Future<void> _deleteProduct(String id) async {
    String url = 'http://192.168.56.1:8000/api/delete/product/$id';
    final response = await http.delete(Uri.parse(url));

    if (response.statusCode == 200) {
      // Produk berhasil dihapus dari server
      final Map<String, dynamic> responseData = json.decode(response.body);
      String productName =
          responseData['deletedProduct']; // Ambil nama produk dari respons

      // Menampilkan alert untuk memberi tahu pengguna bahwa produk berhasil dihapus
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('Product $productName berhasil dihapus.'),
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

      // Memuat ulang tampilan untuk menampilkan perubahan setelah penghapusan produk
      setState(() {
        _getProducts();
      });
    } else {
      // Gagal menghapus produk
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to delete product.'),
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
        title: Text('Product List'),
      ),
      body: FutureBuilder(
        future: _getProducts(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null || snapshot.data.length == 0) {
            return Container(child: Center(child: Text('Loading...')));
          } else {
            return ListView.builder(
              addAutomaticKeepAlives: true,
              itemCount:
                  snapshot.data.length + 1, // Tambahkan 1 untuk ElevatedButton
              itemBuilder: (BuildContext context, int index) {
                if (index == snapshot.data.length) {
                  // Item terakhir adalah ElevatedButton
                  return Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: FractionallySizedBox(
                      widthFactor:
                          0.5, // Misalnya, lebar button adalah setengah dari parentnya
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Kembali'),
                      ),
                    ),
                  );
                } else {
                  // Item lainnya adalah produk
                  return ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'No Barcode: ${snapshot.data[index].codeOfProduct}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Nama Produk: ${snapshot.data[index].nameOfProduct ?? ''}',
                        ),
                        Text(
                          'Harga Produk: Rp. ${snapshot.data[index].priceOfProduct.toString()}',
                        ),
                        Text(
                          'Stok Produk: ${snapshot.data[index].stockOfProduct.toString()}',
                        ),
                        Text(
                          'Pabrikan: ${snapshot.data[index].pabrikanOfProduct ?? ''}',
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            // Navigate to edit product page
                            Navigator.pushNamed(
                              context,
                              '/edit-product',
                              arguments: EditProductPageArguments(
                                product: snapshot.data[index],
                                onProductUpdated: _refreshProducts,
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Confirm Delete'),
                                  content: Text(
                                    'Are you sure you want to delete this product?',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        // Panggil metode _deleteProduct dengan id produk yang sesuai
                                        _deleteProduct(snapshot.data[index].id);
                                        Navigator.pop(context);
                                      },
                                      child: Text('Delete'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}
