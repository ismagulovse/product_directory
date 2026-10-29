import '../api/product_api.dart';
import '../models/product.dart';

class ProductRepo {
  final ProductApi api = ProductApi();

  Future<List<Product>> getProducts() {
    return api.getProducts();
  }
}
