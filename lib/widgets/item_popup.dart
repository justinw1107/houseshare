import 'package:flutter/material.dart';

void showProductDetailsDialog(BuildContext context, dynamic productDetails) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 200,
              child: PageView.builder(
                itemCount: productDetails['images'].length,
                itemBuilder: (BuildContext context, int index) {
                  final productImageUri =
                      productDetails['images'][index]['sizes'][0]['url'];
                  return Image.network(productImageUri);
                },
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              productDetails['description'],
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text('\$${productDetails['items'][0]['price']['regular']}'),
          ],
        ),
        actions: [
          TextButton(
            child: Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
