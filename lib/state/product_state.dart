import 'package:flutter/foundation.dart';

import '../data/product_repo.dart';
import '../models/product.dart';

class ProductState extends ChangeNotifier {
  final ProductRepo repo = ProductRepo();

  List<Product> items = [];
  bool loading = false;
  String error = '';
  String query = '';
  String category = '';
  String order = 'none';
  double minPrice = 0;
  double maxPrice = double.infinity;
  double priceLimit = 1;
  bool _closed = false;

  void search(String text) {
    query = text.trim().toLowerCase();
    notifyListeners();
  }

  void selectCategory(String name) {
    category = name;
    notifyListeners();
  }

  void selectOrder(String value) {
    order = value;
    notifyListeners();
  }

  void selectPrice(double min, double max) {
    minPrice = (min * 100).round() / 100;
    maxPrice = (max * 100).round() / 100;
    notifyListeners();
  }

  void resetPrice() {
    priceLimit = 1;
    for (final item in items) {
      if (item.price > priceLimit) {
        priceLimit = item.price.ceilToDouble();
      }
    }
    minPrice = 0;
    maxPrice = priceLimit;
  }

  List<String> getCategories() {
    final List<String> result = [];

    for (final item in items) {
      if (!result.contains(item.category)) {
        result.add(item.category);
      }
    }

    return result;
  }

  List<Product> getItems() {
    final List<Product> result = [];

    for (final item in items) {
      final hasName = item.name.toLowerCase().contains(query);
      final hasCategory = category.isEmpty || item.category == category;
      final hasPrice = item.price >= minPrice && item.price <= maxPrice;

      if (hasName && hasCategory && hasPrice) {
        result.add(item);
      }
    }

    if (order == 'asc') {
      result.sort((a, b) {
        return a.price.compareTo(b.price);
      });
    } else if (order == 'desc') {
      result.sort((a, b) {
        return b.price.compareTo(a.price);
      });
    }

    return result;
  }


  @override
  void dispose() {
    _closed = true;
    super.dispose();
  }

  Future<void> loadProducts() async {
    if (loading || _closed) {
      return;
    }

    loading = true;
    error = '';
    notifyListeners();

    try {
      items = await repo.getProducts();
      resetPrice();
    } catch (e) {
      error = 'Товары не загрузились';
    } finally {
      loading = false;
      if (!_closed) {
        notifyListeners();
      }
    }
  }
}
