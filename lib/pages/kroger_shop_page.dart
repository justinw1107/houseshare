import 'package:flutter/material.dart';
import 'package:houseshare/service/auth_service.dart';
import 'package:houseshare/service/product_service.dart';
import 'package:houseshare/widgets/show_product_list.dart';
import 'package:houseshare/service/database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;

class KrogerShopPage extends StatefulWidget {
  final String groupId;
  final String groupName;
  final String userName;
  const KrogerShopPage(
      {Key? key,
      required this.groupId,
      required this.groupName,
      required this.userName})
      : super(key: key);

  @override
  _KrogerShopPageState createState() => _KrogerShopPageState();
}

class _KrogerShopPageState extends State<KrogerShopPage> {
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text(
            "Kroger API test",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 27),
          ),
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
                                addToUserList(product);
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

  addToUserList(dynamic product) {
    Map<String, dynamic> selectedProductMap = {
      'name': product['description'],
      'price': product['items'][0]['price'],
      'image': product['images'][0]['sizes'][0]['url'],
    };

    DatabaseService()
        .addToUserList(widget.groupId, widget.userName, selectedProductMap);
  }
}
