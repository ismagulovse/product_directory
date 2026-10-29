import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/product.dart';

class ProductApi {
  Future<List<Product>> getProducts() async {
    final url = Uri.parse('https://dummyjson.com/products?limit=0');
    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('Товары не загрузились');
    }

    final data = jsonDecode(response.body);
    final List<Product> items = [];

    for (final item in data['products']) {
      items.add(Product.fromJson(item));
    }

    return items;
  }
}
