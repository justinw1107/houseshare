import 'dart:convert';

import 'package:http/http.dart' as http;

class ProductService {
  static Future<List<dynamic>> searchForProducts(
      String accessToken, String searchTerm) async {
    final productSearchUri = Uri.parse(
        'https://api.kroger.com/v1/products?filter.term=$searchTerm&filter.limit=50&filter.locationId=01400943');

    final productSearchResponse = await http.get(
      productSearchUri,
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $accessToken",
      },
    );

    final Map<String, dynamic> data = jsonDecode(productSearchResponse.body);
    if (data.containsKey('data')) {
      return data['data'];
    } else {
      return [];
    }
  }
}
