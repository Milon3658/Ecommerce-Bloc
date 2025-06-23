import 'package:bloc_ecommerce/src/data/model/product_model';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductRepository {
  final _firestore = FirebaseFirestore.instance;

  Future<List<ProductModel>> fetchProducts() async {
    final List<ProductModel> productList = [];
    try {
      final data = await _firestore.collection('products').get();
      if (data.docs.isNotEmpty) {
        for (var doc in data.docs) {
          productList.add(ProductModel.fromJson(doc.data()));
        }
        return productList;
      } else {
        throw Exception('No products found');
      }
    } catch (e) {
      throw Exception('Failed to fetch products: $e');
    }
  }
}
