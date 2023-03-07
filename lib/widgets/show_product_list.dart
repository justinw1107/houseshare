import 'package:flutter/material.dart';

class SelectedProductsPage extends StatelessWidget {
  final List<dynamic> selectedProducts;

  const SelectedProductsPage({Key? key, required this.selectedProducts})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selected Products'),
      ),
      body: selectedProducts.isEmpty
          ? Center(
              child: Text('No products selected'),
            )
          : ListView.builder(
              itemCount: selectedProducts.length,
              itemBuilder: (context, index) {
                final product = selectedProducts[index];
                final productName = product['description'];
                final productPrice = product['items'][0]['price'];
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
