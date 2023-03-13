import 'package:flutter/material.dart';

class SelectedProductsPage extends StatelessWidget {
  final List<dynamic> selectedProducts;

  const SelectedProductsPage({Key? key, required this.selectedProducts})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          "Selected Products",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 27),
        ),
      ),
      body: selectedProducts.isEmpty
          ? const Center(
              child: Text('No products selected'),
            )
          : ListView.builder(
              itemCount: selectedProducts.length,
              itemBuilder: (context, index) {
                final product = selectedProducts[index];
                final productName = product['description'];
                final productPrice = product['items'][0]['price']['regular'];
                final productImageUri = product['images'][0]['sizes'][0]['url'];

                return ListTile(
                  leading: Image.network(productImageUri),
                  title: Text(productName),
                  subtitle: Text('\$$productPrice'),
                );
              },
            ),
    );
  }
}
