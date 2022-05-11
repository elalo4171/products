import 'package:products/Data/product_model.dart';
import 'package:http/http.dart' as http;

abstract class ProductRepositoryI {
  Future<List<ProductModel>> getProducts(int? pag);
}

class ProductRepository implements ProductRepositoryI {
  @override
  Future<List<ProductModel>> getProducts(int? pag) async {
    final uri = Uri(
      scheme: 'https',
      host: '627ad722b54fe6ee007e8c49.mockapi.io',
      path: '/api/products/products',
      queryParameters: {
        'page': pag != null ? pag.toString() : '1',
        'limit': '5',
      },
    );

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      return productFromJson(response.body);
    }
    return [];
  }
}
