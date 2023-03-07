import 'package:flutter/material.dart';
import 'package:houseshare/service/auth_service.dart';
import 'package:houseshare/service/product_service.dart';
import 'package:houseshare/widgets/show_product_list.dart';

class KrogerShopPage extends StatefulWidget {
  @override
  _KrogerShopPageState createState() => _KrogerShopPageState();
}

class _KrogerShopPageState extends State<KrogerShopPage> {
  String _accesstoken = '';
  List<dynamic> _products = [];
  List<dynamic> _selectedProducts = [];

  String _accessToken = '';

  @override
  void initState() {
    super.initState();
    _getAccessToken();
  }

  Future<void> _getAccessToken() async {
    _accessToken = await AuthService.getAccessToken();
  }

  Future<void> _searchForProducts(String searchTerm) async {
    _products =
        await ProductService.searchForProducts(_accessToken, searchTerm);
  }

  void _addToSelectedProducts(dynamic product) {
    setState(() {
      _selectedProducts.add(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Kroger API test'),
          actions: [
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SelectedProductsPage(
                        selectedProducts: _selectedProducts)));
              },
            ),
          ],
        ),
        body: Column(
          children: [
            TextField(
              decoration: InputDecoration(hintText: 'Search for products'),
              onSubmitted: (value) {
                // show a popup
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Searching for products'),
                      content: Text('Please wait...'),
                    );
                  },
                );

                // search for products
                _searchForProducts(value).then((_) {
                  Navigator.of(context).pop();
                  setState(() {});
                });
              },
            ),
            Expanded(
                child: ListView.builder(
              itemCount: _products.length,
              itemBuilder: (context, index) {
                final product = _products[index];
                final productName = product['description'];
                final productPrice = product['items'][0]['price'];
                final productImageUri = product['images'][0]['sizes'][0]['url'];

                return ListTile(
                  leading: Image.network(productImageUri),
                  title: Text(productName),
                  subtitle: Text('\$$productPrice'),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(productName),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Price: \$$productPrice'),
                              SizedBox(height: 16.0),
                              Text('Description:'),
                              Text(product['description']),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Close'),
                            ),
                            TextButton(
                              onPressed: () {
                                _addToSelectedProducts(product);
                                Navigator.of(context).pop();
                              },
                              child: Text('Add to List'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              },
            )),
          ],
        ),
      ),
    );
  }
}
